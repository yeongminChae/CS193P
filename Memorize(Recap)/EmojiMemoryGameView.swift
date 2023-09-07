//
//  EmojiMemoryGameView.swift
//  Memorize(Recap)
//
//  Created by 채영민 on 2023/09/04.
//

import SwiftUI

// 기존 ContentView_Old 캡슐화한 코드로 리팩토링 진행

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
//            Old ForEach
//            ForEach(viewModel.cards.indices, id:\.self) { index in
//                CardView(viewModel.cards[index])
//                    .aspectRatio(2/3, contentMode: .fit)
//                    .padding(4)
//            }
//            여기에서는 cards.animation(.default, value: viewModel.cards)을 적용했을 때 우리가 원했던 것처럼 극적인 효과가 연출이 되지 않았습니다. Old ForEach에서는 카드 배열의 색인에 대해 ForEaching을 수행하고 있습니다. 여기서는 각 카드에 대한 뷰인 CardView를 만드는 것입니다.
//            우리는 카드를 섞을 때 카드 중 하나를 7번에서 0번으로 0번 카드 중 하나를 4번으로 이동 시키고 싶습니다.
//            그러나 ForEach에 관점에서 보면 카드는 여전이 인덱스 0에 표시됩니다. 그렇기에 옮겨진 곳에서 계속 fading-in 되고 있는 겁니다.
//            그러므로 문제는 ForEach가 카드의 색인이 아닌 카드 자체에 대해 ForEach를 수행하도록 하려는 것입니다. 이 보기를 실제 카드와 연결하려고 합니다. 따라서 카드가 배열에서 움직이면 뷰도 움직입니다.

            ForEach(viewModel.cards) { card in // id:\.self는 내가 ForEach라는 뜻입니다.
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card

    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth:  2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
            }
                .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

//struct EmojiMemoryGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
//    }
//}
