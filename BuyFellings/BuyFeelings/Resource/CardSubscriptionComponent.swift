import SwiftUI

struct CardSubscriptionComponent: View {
    
    let item: CardItem
    
    // MARK: - Computed property para o banner
    var bannerName: String {
        switch item.category {
        case .subscription:
            return "SeasonHalloween"
        case .sessionGoodFeelings:
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
                .frame(width: 340, height: 130)
                .clipped()
            
            // Botão no canto inferior esquerdo
            Button {
                // ação da assinatura
            } label: {
                Text("Subscribe Now")
                    .font(.caption.bold()) //tamanho da fonte
                    .padding(.horizontal, 10) //padding na horizontal
                    .padding(.vertical, 6) //padding na vertical
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(color: .white.opacity(0.2), radius: 2, x: 0, y: 2)
            }
            .padding(10)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
        .padding(.vertical)
    }
}

