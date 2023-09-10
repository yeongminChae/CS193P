//
//  Cardify.swift
//  Memorize(Recap)
//
//  Created by 채영민 on 2023/09/09.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    // Animatable 사용 이유 : 아래 base.opacity도 에니메이션화 되고 있음.
    // Animatable을 구현하면 모든 작업이 자동으로 수행되지 않고 우리가 수행하기 때문.
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }

    var isFaceUp: Bool {
        rotation < 90
    }

    var rotation: Double

    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }

    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.strokeBorder(lineWidth:  Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0,1,0))
    }

    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
