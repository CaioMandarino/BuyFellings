//
//  DatabaseManager.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 16/10/25.
//

import Foundation
import SwiftData

final class DatabaseManager: DatabaseProtocol {
    
    private let context: ModelContext
    
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
     Retorna todos os elementos do banco de dados com base em um FetchDescriptor
     */
    func getAllElements<T: PersistentModel>(fetchDescriptor: FetchDescriptor<T>) -> [T] {
        do {
            let elements = try context.fetch(fetchDescriptor)
            return elements
        } catch {
            print("Error ao buscar os dados: \(error)")
            return []
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Erro ao salvar o contexto: \(error)")
        }
    }
}
