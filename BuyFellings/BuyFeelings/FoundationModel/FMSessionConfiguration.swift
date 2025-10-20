//
//  FMSessionConfiguration.swift
//  BuyFeelings
//
//  Created by israel lacerda gomes santos on 16/10/25.
//

import Foundation
import FoundationModels

class FMSessionConfiguration {
    func generatePhrase (feeling: String) async throws -> String {
        if #available(iOS 26.0, *) {
            let prompt = "You're an expert on human emotions. Your role is to create a short, 10-word sentence about the \(feeling) you're experiencing, reflectively."
            let session = LanguageModelSession()
            let options = GenerationOptions(temperature: 1)
            let response =  try await session.respond(
                to: prompt,
                options: options
            )
            return response.content
        } else {
            return ""
        }
    }
    
    func generatePhrase(feeling: ProductsIdentifiers) async throws -> String {
        try await generatePhrase(feeling: ProductsIdentifiers.feelingsToString(feeling: feeling))
    }
}

