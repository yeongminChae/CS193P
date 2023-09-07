//
//  EmojiMemoryGameView.swift
//  Memorize(Recap)
//
//  Created by 채영민 on 2023/09/04.
//

import SwiftUI

// 기존 ContentView_Old 캡슐화한 코드로 리팩토링 진행

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame // 항상 진실인 상태로 표시되어야 하기 때문에 항상 사용자에게 전될 되어야 합니다.
    // @StateObject var viewModel: EmojiMemoryGame = EmojiMemoryGame()
    // @StateObject는 @ObservedObject와는 다르게 위에 라인 처럼 작성 가능합니다.

    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id:\.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
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
    }
}

//struct EmojiMemoryGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
//    }
//}
