//
//  DatabaseProtocol.swift
//  BuyFeelings
//
//  Created by Caio Mandarino on 16/10/25.
//

import Foundation
import SwiftData

protocol DatabaseProtocol {
    func add<T: PersistentModel>(element: T)
    func delete<T: PersistentModel>(element: T)
    func update<T: PersistentModel>(element: T)
    func getAllElements<T: PersistentModel>(fetchDescriptor: FetchDescriptor<T>) -> [T]
}
