//
//  FMPlaygrounds.swift
//  BuyFeelings
//
//  Created by israel lacerda gomes santos on 16/10/25.
//
import Playgrounds
import FoundationModels

#Playground {
    let emotion : ProductsIdentifiers = .fear
    let session = LanguageModelSession()
    let prompt = "You're an expert on human emotions. Your role is to create a short, 10-word sentence about the \(emotion) you're experiencing, reflectively."
    let options = GenerationOptions(temperature: 0)
    try await session.respond(
        to: prompt,
        options: options
    )
}
