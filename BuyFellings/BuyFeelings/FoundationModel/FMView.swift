//
//  FMView.swift
//  BuyFeelings
//
//  Created by israel lacerda gomes santos on 16/10/25.
//

import SwiftUI

struct FMView: View {
    //variables
    let feeling: ProductsIdentifiers
    @State var phrase : String?
    private var response: String {
        "Thinking....."
    }
    @State var didFail: Bool = false
    @State var errorMessage: String = ""
    private let session =  FMSessionConfiguration()
    
    //body
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "quote.bubble.fill")
            if didFail {
               Text(errorMessage)
            } else {
                Text(phrase ?? response)
            }
        }
        .animation(.default, value: phrase)
        .task {
            do {
                phrase = try await session.generatePhrase(
                    feeling: ProductsIdentifiers.feelingsToString(feeling: feeling)
                )
            } catch {
                didFail = true
                errorMessage = "Error: \(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    List{
        Section{
            FMView(feeling: .fun)
        }
    }
}
