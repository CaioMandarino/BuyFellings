//
//  HomeViewModel.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 17/10/25.
//


import Combine
import Foundation
import SwiftUI
import WidgetKit

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var timeRemaining: TimeInterval
    @Published var feelingsColors: [Color] = []
    @Published var feelingPhase = ""
    @Published var showEditMode = false

    private let databaseService: any DatabaseProtocol
    private let foundationService: FMSessionConfiguration
    
    private var totalTime: TimeInterval
    private var minimumTime: TimeInterval
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
        minimumTime = durations.min { $0 < $1 } ?? 0
        timeRemaining = totalTime
        
        updateTimeRemaining()
        observeDatabaseChanges()
        
        appendBackgroundColor(for: allActiveFeelings)
        updatePrimaryFeelingAndWidget()
    }
    
    private func observeDatabaseChanges() {
        databaseService.databaseChangePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }

                let predicate: Predicate<PurchasedFeelingsModel> = #Predicate { $0.isActive }
                let newActiveFeelings = self.databaseService.getAllElements(predicate: predicate, sortBy: [])
                
                // Lógica existente para atualizar os sentimentos
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
                minimumTime = durations.min { $0 < $1 } ?? 0
                timeRemaining = totalTime
                
                // Atualiza a cor do app e notifica o widget sempre que há uma mudança
                self.updatePrimaryFeelingAndWidget()
                
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
            while minimumTime > 0{
                try? await Task.sleep(for: .seconds(1))
                if Task.isCancelled { return }
                timeRemaining -= 1
                minimumTime -= 1
            }
            persistTimeRemaining()
        }
    }
    
    // MARK: - Widget Communication
    
    /// Identifica a emoção primária (maior duração), atualiza as cores do app e notifica o widget.
    private func updatePrimaryFeelingAndWidget() {
        // Encontra o sentimento com a maior duração, que será o dominante.
        guard let primaryFeelingModel = allActiveFeelings.max(by: { $0.duration < $1.duration }) else {
            // Caso não haja sentimentos ativos
            notifyWidgetOfActiveEmotion(nil)
            return
        }
        
        // Converte o nome (String) de volta para o nosso enum
        guard let primaryEmotion = ProductsIdentifiers(rawValue: primaryFeelingModel.name) else {
            notifyWidgetOfActiveEmotion(nil)
            return
        }
                
        // 2. Notifica o Widget
        notifyWidgetOfActiveEmotion(primaryEmotion)
    }
    
    /// Salva a emoção ativa no `UserDefaults` compartilhado e recarrega a timeline do widget.
    /// - Parameter emotion: A emoção a ser exibida no widget, ou `nil` para limpar.
    private func notifyWidgetOfActiveEmotion(_ emotion: ProductsIdentifiers?) {
        // Acessa o "espaço" compartilhado (App Group) que configuramos.
        guard let userDefaults = UserDefaults(suiteName: Shared.groupID) else {
            print("WIDGET ERROR: Não foi possível acessar os UserDefaults compartilhados.")
            return
        }
        
        if let emotion {
            // Salva o identificador da nova emoção para o widget ler.
            userDefaults.set(emotion.rawValue, forKey: Shared.feelingID)
            print("WIDGET DATA: Emoção salva -> \(emotion.rawValue)")
        } else {
            // Se não houver emoção, remove a chave para o widget mostrar um estado padrão.
            userDefaults.removeObject(forKey: Shared.feelingID)
            print("WIDGET DATA: Nenhuma emoção ativa. Chave removida.")
        }

        // Avisa o WidgetKit que há novos dados e que ele deve recarregar sua timeline.
        WidgetCenter.shared.reloadAllTimelines()
        
        let groupID = "group.testFinal"
        guard let containerURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: groupID) else {
            assertionFailure("App Group \(groupID) ausente neste target (entitlement/provisioning).")
            // Evite gravar em suite “fantasma”; faça fallback explícito ou aborte.
            return
        }

    }
    
    // MARK: - Funções existentes
    
    func getFeelingPhrase() async throws -> String {
        guard !allActiveFeelings.isEmpty else {
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
        // Atualiza o widget quando o app entra em segundo plano, garantindo que a emoção está correta.
        updatePrimaryFeelingAndWidget()
    }
    
    private func updateTimePass(whenUpdate action: ((PurchasedFeelingsModel) -> Void)? = nil) {
        let timePass = totalTime - timeRemaining
        
        for entity in allActiveFeelings {
            entity.duration -= timePass
            action?(entity)
        }
    }
    
    func createEditHeartViewModel() -> EditHeartViewModel {
        let paymentService = StoreKitManager()
        return EditHeartViewModel(storeKitManager: paymentService, databaseService: databaseService)
    }
    
    deinit {
        taskUpdateRemaining?.cancel()
        taskUpdateRemaining = nil
    }
}
