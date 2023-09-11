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
            withAnimation(.easeOut(duration: 1 )) {
                viewModel.shuffle()
            }
        }
    }

    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                view(for: card)
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
    }

    private func view(for card: Card) -> some View {
        CardView(card)
            .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
            .transition(.asymmetric(insertion: .identity, removal: .identity))
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
        let (amount, causedByCardId: id) = lastScoreChange
        return card.id == id ? amount : 0
    }

    // MARK: - Dealing from a Deck

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
                view(for: card)
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {
            deal()
        }
    }

    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(.easeInOut(duration: 1).delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealtInterval
        }
    }
}

//struct EmojiMemoryGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
//    }
//}
