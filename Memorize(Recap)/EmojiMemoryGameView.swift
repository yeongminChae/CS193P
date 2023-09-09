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

    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            // GridItem(.adaptive(minimum: 95)를 이렇게 설정하면, 화면 레이아웃이 딱 맞기 때문에 더이상 scrollView가 필요로 하지 않습니다.
            // VStack은 모든 것을 맞추려고 했지만 최소 너비에 맞지 않았습니다.
            // 따라서 상황의 유연성을 부여하기 위해 GeometryReader를 사용해야 합니다.
            cards
                .animation(.default, value: viewModel.cards)
            Button("Shuffle") {
                viewModel.shuffle()
            }
            .background(.blue)
        }
        .padding()
    }

    // @ViewBuilder let aspectRatio: CGFloat을 아래 cards변수에 선언시 나타나는 에러 해결을 위한 코드.
    // var body: 는 @ViewBuilder를 가지고 있습니다.
    private var cards: some View {

        // let aspectRatio: CGFloat = 2/3
        // Error : Function declares an opaque return type, but has no return statements in its body from which to infer an underlying type
        // Fix : @ViewBuilder 선언

        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize ), spacing: 0)], spacing: 0) {
                // GridItem은 각 열을 정의합니다. GridItem의 개수가 실제로 제가 갖게될 열의 갯수입니다.
                // spacing은 플랫폼에(iOS, MacOS, WatchOS...) 따라 간격이 다르기 때문에, 완벽하게 올바른 크기의 카드를 선택해야 하기 때문에 0으로 설정해야 합니다.
                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }

            // AspectVGrid로 대체되어질 코드.
            AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio) { card in
                CardView(card)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }

        }
        .foregroundColor(.orange)
    }

}

//struct EmojiMemoryGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
//    }
//}
