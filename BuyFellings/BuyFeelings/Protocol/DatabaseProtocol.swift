//
//  DatabaseProtocol.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 16/10/25.
//

import Foundation
import SwiftData
import Combine

protocol DatabaseProtocol {
    var databaseChangePublisher: AnyPublisher<Void, Never> { get }
    
    func add<T: PersistentModel>(element: T)
    func delete<T: PersistentModel>(element: T)
    func update<T: PersistentModel>(element: T)
    func getAllElements<T: PersistentModel>(predicate: Predicate<T>?, sortBy: [SortDescriptor<T>]) -> [T]
    func getAllElements<T: PersistentModel>() -> [T]
}
