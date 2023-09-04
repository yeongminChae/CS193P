//
//  ContentView.swift
//  Memorize(Recap)
//
//  Created by 채영민 on 2023/09/04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.orange)
        .padding() // 외부 주위에 패딩을 원할 경우, 크기가 커지기 시작할 것을 대비해 장치 가장자리에 부딪히기 않기를 원할 것입니다.
    }
}

struct CardView: View {
    var isFaceUp: Bool = false

    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth:  2)
                Text("👻").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
