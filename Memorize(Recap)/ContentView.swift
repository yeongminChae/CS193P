//
//  ContentView.swift
//  Memorize(Recap)
//
//  Created by 채영민 on 2023/09/04.
//

import SwiftUI

// 기존 ContentView_Old 캡슐화한 코드로 리팩토링 진행

struct ContentView: View {
    let emojis = ["💀","🎃","👻","😈","🍭","🍬","🕯️","🦇","🙀","😱"]
    @State var cardCount = 4

    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjuster
        }
        .padding()
    }

    var cards: some View {
//        return HStack {
//        이것은 computed property로써 ViewBuilder가 아닙니다. 이와같이 코드가 한 줄만 있는 경우라면 return은 필요로 하지 않습니다. 이러한 구성을 Implicit return (암시적 반환)이라고 합니다.

//        HStack {
//        LazyVGrid(columns: [GridItem(),GridItem(),GridItem()]) {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id:\.self) { emoji in
                CardView(content: emojis[emoji])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }

    var cardCountAdjuster: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }

    var cardRemover: some View {
        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill") Implicit return
    }

    var cardAdder: some View {
        return cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }

    //    Old var cardRemover: some View {
    //    var cardRemover: some View {
    //        Button(action: {
    //            if cardCount > 1 {
    //                cardCount -= 1
    //            }
    //        }, label: {
    //            Image(systemName: "rectangle.stack.badge.minus.fill")
    //        })
    //    }


    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }

}

struct CardView: View {
    let content: String
    @State var isFaceUp = true

    var body: some View {
//        Bug : 이 기존 코드에서는 LazyVGrid를 사용하면 카드를 최대한 작게 만들 수 있고 이모지가 없으면 카드를 표시하는 카드가 정말 작을 수 있기 때문에 UI가 이상해 보이는 에러가 발생한다.
//        ZStack {
//            let base = RoundedRectangle(cornerRadius: 12)
//            if isFaceUp {
//                base.fill(.white)
//                base.strokeBorder(lineWidth:  2)
//                Text(content).font(.largeTitle)
//            } else {
//                base.fill()
//            }
//        }

//      위와 같은 버그를 해결하기 위해 opacity를 사용한다. 이 메커니즘은 모든 상태에 대해 크기 조정과 간격이 필요한 두 상태 사이를 전환하는 좋은 방법이다.
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group { // Group는 일종의 ForEach와 같다.
                base.fill(.white)
                base.strokeBorder(lineWidth:  2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
