//
//  CardView.swift
//  Memorize(Recap)
//
//  Created by 채영민 on 2023/09/09.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card

    let card: Card

    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }

    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(0.4)
            .overlay(
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
            )
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }

    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }
}

//struct CardView_Previews: PreviewProvider {
//    typealias Card = CardView.Card
//    static var previews: some View {
//        CardView(Card(content: "X", id: "test1"))
//          .padding()
//          .foregroundColor(.green)
//    }
//}
