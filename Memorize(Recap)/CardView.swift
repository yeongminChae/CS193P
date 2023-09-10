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
        TimelineView(.animation) { timeline in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(0.4)
                    .overlay( cardContents
                        .padding(Constants.Pie.inset) // 카드 내용의 일부가 아니라, 전체의 레이아웃의 일부이기에 본문에 적는게 맞습니다.
                    )
                    .padding(Constants.inset)
                    .cardify(isFaceUp: card.isFaceUp)
                    // .opacity(card.isFaceUp || !card.isMatched ? 1 : 0) // 카드가 일치해서 사라질 때 지속적으로 페이드인 아웃 되는 버그 발생.
                    // 이는 view 계층 구조에서 view를 삭제하거나 추가할 때 사용되는 기본 transition이 opacity이기 때문에 발생
                    // default transition : .transition(.opacity)
                    // 이러한 transition 메커니즘은 UI에서 전체적으로 사라지거나, 나타나거나, 날아가능 등 다양한 에니메이션 요소를 적용할 view가 있을 때 정말 멋진 방법입니다.
                     .transition(.opacity)
            } else {
                Color.clear
            }
        }
    }

    private var cardContents: some View {
        Text(card.content)
            .font(.system(size: 200))
            .minimumScaleFactor(0.01)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatched)
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

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
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
