import SwiftUI

struct BuyEmotionsView: View {
    @ObservedObject var viewModel: BuyEmotionsViewModel
    

    var body: some View {
       
        
        ScrollView {
            CardComponentCarousel(items: viewModel.cards)
        }
    }
}

