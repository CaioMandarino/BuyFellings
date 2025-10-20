import SwiftUI

struct BuyEmotionsView: View {
    let title: String = ""
    @ObservedObject var viewModel: BuyEmotionsViewModel
    

    var body: some View {
       
        
        ScrollView {
            CardComponentCarousel(title: title, items: viewModel.cards)
        }
    }
}

