//
//  EmojiMemoryGameView.swift
//  Memorize(Recap)
//
//  Created by 채영민 on 2023/09/04.
//

import SwiftUI

struct ContentView_Old: View {
    let emojis = ["💀","🎃","👻","😈","🍭","🍬","🕯️","🦇","🙀","😱"]

    // Array is generic type
    // 좋은 프로그래밍 기법은 상수/변수들을 사용하는 곳 근처에 선언하는 것이지만 이 배열은 최상단에 위치시켜 각각 뷰들이 접근하게끔 선언.
    @State var cardCount = 4 // State는 실제 코드에서는 그렇게 많이 사용하지는 않지만 데모용으로는 좋습니다.
    var body: some View {
        VStack{
            HStack {
                ForEach(0..<cardCount, id:\.self) { emoji in
                    //            ForEach(emojis.indices, id:\.self) { emoji in
                    CardView_Old(content: emojis[emoji])
                }
                //                Old Way
                //                CardView(content: "💀",isFaceUp: false)
                //                CardView(content: "🎃",isFaceUp: true)
                //                CardView(content: "😈",isFaceUp: true)
            }
            .foregroundColor(.orange)

            HStack {
//                Button("Remove Card") {
//                    cardCount -= 1
//                }
                Button(action: {
                    if cardCount > 1 {
                        cardCount -= 1
                    }
                }, label: {
                    // 이 클로저는 ViewBuilder이다.
                    Image(systemName: "rectangle.stack.badge.minus.fill")
                })
                Spacer()
                Button(action: {
                    if cardCount < emojis.count {
                        cardCount += 1
                    }
                }, label: {
                    Image(systemName: "rectangle.stack.badge.plus.fill")
                })
            }
            .imageScale(.large)
            .font(.largeTitle)
                // 시스템 이미지는 근처에 있는 사물의 글꼴을 추적하려고 하는 것입니다. 그들은 인라인으로 작업하려고 시도하므로 어떤 글꼴로 설정하든 그에 맞춰 일치하게 되고 이미지 크기는 그에 비례하게 됩니다.

        }
        .padding()
        // 이 VStack에 패딩을 적용한다면, foregroundColor와 같이 VStack 내부에 모든 것에 적용되지 않고,
        // VStack 자체가 패딩되고 전체 주위에 패딩을 두는 것이 합리적입니다.
    }
}

struct CardView_Old: View {
//  old case =  var isFaceUp = true
    let content: String
    @State var isFaceUp = true

    var body: some View {
        ZStack {
//            var base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            let base = RoundedRectangle(cornerRadius: 12) // Type Inference
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth:  2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()

            // old case
            // isFaceUp.toggle()
            // Error : Cannot use mutating member on immutable value: 'self' is immutable
            // 이 self는 뷰 그 자체이고, 바뀔수 없습니다.
            // 해결법 : @State var isFaceUp = true
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiMemoryGameView()
//    }
//}
