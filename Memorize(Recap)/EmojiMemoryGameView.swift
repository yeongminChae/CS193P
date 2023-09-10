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
    
    var body: some View {
        VStack {
            cards
            // .animation(.default, value: viewModel.cards)
            // Shuffling은 사용자 의도, viewModel 의도에 대한 응답이기 때문에 결코 그런 Shuffling을 수행하지 않습니다.
            // .animation(.default, value: viewModel.cards)을 클릭하면 카드는 페이드인아웃 되었습니다.
            // 이유는 이 에니메이션 효과는 Shuffling뿐만 아니라 모든 변경 사항에 적용되기 때문입니다.
            HStack {
                score
                Spacer()
                shuffle
            }.font(.largeTitle )
        }
        .padding()
    }
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil) // implicit animation 효과가 적용되어, score가 페이드인아웃 되는 버그 픽스
    }

    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation(.easeOut(duration: 3 )) {
                // withAnimation(.interactiveSpring(response: 1, dampingFraction:  0.5)) { // 재미있는 효과
                viewModel.shuffle()
            }
        }
    }

    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(.orange)
    }

    private func scoreChange(causedBy card: Card) -> Int {
        return 0
    }
}

//struct EmojiMemoryGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
//    }
//}
