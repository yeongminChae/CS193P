//
//  EmojiMemoryGameView.swift
//  Memorize(Recap)
//
//  Created by 채영민 on 2023/09/04.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame

    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    private let dealtInterval: TimeInterval = 0.15
    private let deckWidth: CGFloat  = 50
    
    var body: some View {
        VStack {
            cards.foregroundColor(viewModel.color)
            HStack {
                score
                Spacer()
                deck.foregroundColor(viewModel.color)
                Spacer()
                shuffle
            }.font(.largeTitle )
        }
        .padding()
    }

    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }

    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation(.easeOut(duration: 3 )) {
                viewModel.shuffle()
            }
        }
    }

    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 1 : 0)
                    .onTapGesture {
                        choose(card)
                    }
//                    .transition(.offset(
//                        x: CGFloat.random(in: -1000...1000),
//                        y: CGFloat.random(in: -1000...1000)
//                    )) // 재밌는 이펙트
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
    }

    @State private var dealt = Set<Card.ID>()

    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }

    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }

    @Namespace private var dealingNameSpace

    private var deck : some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {
            // 컨테이너가 이미 화면에 나타난 후에 이 카드가 나타나도록 하는 것, 카드 컨테이너가 아직 화면에 표시되지 않은 경우 컨테이너와 함께 화면에 표시되므로 화면에 표시되는 에니메이션이 표시되지 않습니다.
            // 카드 컨테이너는 LazyVGrid를 가지고 있는 AspectVRid입니다.
            deal()
        }
    }

    private func deal() { // deal the cards.
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(.easeInOut(duration: 2).delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealtInterval
        }
    }

    @State private var lastScoreChange: (Int, causedByCardId: Card.ID) = (amount: 0, causedByCardId: "")

    private func choose(_ card: Card) {
        withAnimation() {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }

    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, causedByCardId: id) = lastScoreChange // 튜플에서 값을 가져올 때 let이라 선언한 후 원하는 변수 이름을 선언합니다.
        return card.id == id ? amount : 0
    }
}

//struct EmojiMemoryGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
//    }
//}
