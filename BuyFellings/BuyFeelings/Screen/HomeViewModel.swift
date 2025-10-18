//
//  HomeViewModel.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 17/10/25.
//

import Combine
import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var timeRemaining: TimeInterval
    
    private let databaseService: any DatabaseProtocol
    private let foundationService: FMSessionConfiguration
    
    private var totalTime: TimeInterval
    private var allActiveFeelings: [PurchasedFeelingsModel]
    
    private var taskUpdateRemaining: Task<Void, Never>? = nil
    private var cancellables: Set<AnyCancellable> = []
    
    init(databaseService: any DatabaseProtocol, foundationService: FMSessionConfiguration) {
        self.databaseService = databaseService
        self.foundationService = foundationService
        
        let predicate: Predicate<PurchasedFeelingsModel> = #Predicate { $0.isActive }
        self.allActiveFeelings = databaseService.getAllElements(predicate: predicate, sortBy: [])
        let durations = allActiveFeelings.map(\.duration)
        totalTime = durations.max { $0 < $1} ?? 0
        timeRemaining = totalTime
        
        updateTimeRemaining()
        observeDatabaseChanges()
    }
    
    private func observeDatabaseChanges() {
        databaseService.databaseChangePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                
                let predicate: Predicate<PurchasedFeelingsModel> = #Predicate { $0.isActive }
                self.allActiveFeelings = self.databaseService.getAllElements(predicate: predicate, sortBy: [])
                
                let durations = allActiveFeelings.map(\.duration)
                let newTotalTime = durations.max { $0 < $1} ?? 0
                totalTime = newTotalTime - (totalTime - timeRemaining)
                timeRemaining = totalTime
                
                taskUpdateRemaining?.cancel()
                taskUpdateRemaining = nil
                updateTimeRemaining()
            }
            .store(in: &cancellables)
    }
    
    private func updateTimeRemaining() {
        taskUpdateRemaining = Task {
            while timeRemaining > 0 {
                try? await Task.sleep(for: .seconds(1))
                if Task.isCancelled { return }
                timeRemaining -= 1
            }
            persistTimeRemaining()
        }
    }
    
    func getFeelingPhrase() async -> String {
        guard allActiveFeelings.isEmpty == false else {
            return "Nenhum sentimento comprado"
        }
        
        guard let fellingWithMoreDuration = allActiveFeelings.max(by: { $0.duration < $1.duration }) else {
            return ""
        }
        
        guard let felling = ProductsIdentifiers(rawValue: fellingWithMoreDuration.name) else {
            return ""
        }
        
        guard let response = try? await foundationService.generatePhrase(feeling: felling) else {
            return ""
        }
        
        return response
    }
    
    func persistTimeRemaining() {
        let timePass = totalTime - timeRemaining

        for entity in allActiveFeelings {
            entity.duration -= timePass
            if entity.duration <= 0 {
                databaseService.delete(element: entity)
            } else {
                databaseService.update(element: entity)
            }
        }
        
        totalTime = timeRemaining
    }
    
    
    deinit {
        taskUpdateRemaining?.cancel()
        taskUpdateRemaining = nil
    }
}
