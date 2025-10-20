import SwiftUI

struct BuyEmotionsView: View {
    let title: String
    let items: [CardItem]

    var body: some View {
        ScrollView {
            CardComponentCarousel(title: title, items: items)
        }
    }
}

