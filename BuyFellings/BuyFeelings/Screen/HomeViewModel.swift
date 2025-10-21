//
//  HomeViewModel.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 17/10/25.
//

import Combine
import Foundation
import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var timeRemaining: TimeInterval
    @Published var feelingsColors: [Color] = []
    
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
        
        appendBackgroundColor(for: allActiveFeelings)
    }
    
    private func observeDatabaseChanges() {
        databaseService.databaseChangePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }

                let predicate: Predicate<PurchasedFeelingsModel> = #Predicate { $0.isActive }
                let newActiveFeelings = self.databaseService.getAllElements(predicate: predicate, sortBy: [])
                
                for newActiveFeeling in newActiveFeelings {
                    if self.allActiveFeelings.contains(where: { $0.id == newActiveFeeling.id }) {
                        let timePass = totalTime - timeRemaining
                        newActiveFeeling.duration -= timePass
                        allActiveFeelings.removeAll(where: { $0.id == newActiveFeeling.id })
                        allActiveFeelings.append(newActiveFeeling)
                    } else {
                        self.allActiveFeelings.append(newActiveFeeling)
                    }
                }
                
                let durations = allActiveFeelings.map(\.duration)
                totalTime = durations.max { $0 < $1} ?? 0
                timeRemaining = totalTime
                
                if timeRemaining > 0 {
                    taskUpdateRemaining?.cancel()
                    taskUpdateRemaining = nil
                    updateTimeRemaining()
                }
                
                appendBackgroundColor(for: allActiveFeelings)
            }
            .store(in: &cancellables)
    }
    
    func appendBackgroundColor(for entities: [PurchasedFeelingsModel]) {
        var colorFeelings: [Color] = []
        for entity in entities {
            guard let feeling = ProductsIdentifiers(rawValue: entity.name) else { continue }
            colorFeelings.append(Color(for: feeling))
        }
        
        feelingsColors = colorFeelings
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
    
    func getFeelingPhrase() async throws -> String {
        guard allActiveFeelings.isEmpty == false else {
            throw FeelingPhraseErrors.nonFeelingsActive
        }
        
        guard let fellingWithMoreDuration = allActiveFeelings.max(by: { $0.duration < $1.duration }) else {
            throw FeelingPhraseErrors.invalidFeeling
        }
        
        guard let felling = ProductsIdentifiers(rawValue: fellingWithMoreDuration.name) else {
            throw FeelingPhraseErrors.invalidFeeling
        }
        
        guard let response = try? await foundationService.generatePhrase(feeling: felling) else {
            throw FeelingPhraseErrors.invalidFoundationResponse
        }
        
        return response
    }
    
    func persistTimeRemaining() {
        updateTimePass { entity in
            if entity.duration <= 0 {
                self.databaseService.delete(element: entity)
                self.allActiveFeelings.removeAll(where: { $0.id == entity.id })
            } else {
                self.databaseService.update(element: entity)
            }
        }
        
        totalTime = timeRemaining
    }
    
    private func updateTimePass(whenUpdate action: ((PurchasedFeelingsModel) -> Void)? = nil) {
        let timePass = totalTime - timeRemaining
        
        for entity in allActiveFeelings {
            entity.duration -= timePass
            action?(entity)
        }
    }
    
    deinit {
        taskUpdateRemaining?.cancel()
        taskUpdateRemaining = nil
    }
}
