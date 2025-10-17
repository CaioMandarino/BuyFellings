//
//  CardItem.swift
//  BuyFeelings
//
//  Created by Larissa Kailane on 17/10/25.
//
import Foundation

struct CardItem: Identifiable, Equatable, Decodable {
    let id: String
    let name: String
    let price: Double
//    let description: String
    let image: String
}

