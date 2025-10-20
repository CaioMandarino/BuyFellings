//
//  DataProvider.swift
//  BuyFeelings
//
//  Created by Raquel Souza on 20/10/25.
//

import Foundation

class CardItemData {
    static func loadItems() -> [CardItem] {
        guard let url = Bundle.main.url(forResource: "FeelingsData", withExtension: "json") else {
            print("Arquivo JSON não encontrado.")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let items = try JSONDecoder().decode([CardItem].self, from: data)
            return items
        } catch {
            print("Erro ao decodificar JSON: \(error)")
            return []
        }
    }
}
