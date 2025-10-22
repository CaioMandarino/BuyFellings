import SwiftUI

struct CardSubscriptionComponent: View {
    
    @ObservedObject var viewModel: BuyEmotionsViewModel
    
    let item: CardItem
    
    // MARK: - Computed property para o banner
    var bannerName: String {
        switch item.productID {
        case .season:
            return "SeasonHalloween"
        case .premiumMonthly:
            return "SunflowersHappiness"
        default:
            return "default_banner"
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) { //o alinhamento do botão dentro do card
            
            // Imagem ocupa todo o card
            Image(bannerName)
                .resizable()
                .scaledToFill()
                .frame(width: 340, height: 130) //tamanho da imagem, para ficar exatamente do tamanho do banner
                .clipped()
            
            // Botão no canto inferior esquerdo
            Button("Subscribe now") {
                Task {
                    await viewModel.purchase(product: item.productID)
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.paranoia) // cor do botão


            .padding(10)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
        .padding(.vertical)
    }
}
