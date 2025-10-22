//
//  DatabaseManager.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 16/10/25.
//

import Foundation
import SwiftData
import Combine

final class DatabaseManager: DatabaseProtocol {
    
    private let databaseChange: PassthroughSubject<Void, Never> = .init()
    private let context: ModelContext
    
    public var databaseChangePublisher: AnyPublisher<Void, Never> {
        databaseChange.eraseToAnyPublisher()
    }
    
    init(context: ModelContext) {
        self.context = context
    }
    
    /**
     Adiciona e salva no banco de dados
     */
    func add<T: PersistentModel>(element: T) {
        context.insert(element)
        saveContext()
    }
    
    /**
     Deleta do banco de dados
     */
    func delete<T: PersistentModel>(element: T) {
        context.delete(element)
        saveContext()
    }
    
    /**
     Atualiza um elemento do banco de dados
     */
    func update<T: PersistentModel>(element: T) {
        saveContext()
    }
    
    /**
     Retorna todos os elementos do banco de dados com base em um predicate e sortBy
     */
    func getAllElements<T: PersistentModel>(predicate: Predicate<T>? = nil, sortBy: [SortDescriptor<T>] = []) -> [T] {
        do {
            let fetchDescriptor = FetchDescriptor(predicate: predicate, sortBy: sortBy)
            let elements = try context.fetch(fetchDescriptor)
            return elements
        } catch {
            print("Error ao buscar os dados: \(error)")
            return []
        }
    }
    
    /**
     Retorna todos os elementos do banco de dados
     */
    func getAllElements<T: PersistentModel>() -> [T] {
        self.getAllElements(predicate: nil, sortBy: [])
    }
    
    private func saveContext() {
        do {
            try context.save()
            databaseChange.send()
        } catch {
            print("Erro ao salvar o contexto: \(error)")
        }
    }
    
}
