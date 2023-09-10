//
//  FlyingNumber.swift
//  Memorize(Recap)
//
//  Created by 채영민 on 2023/09/10.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int

    @State private var offset: CGFloat = -50

    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundColor(number < 0 ? .red : .green)
                .shadow(color: .black, radius: 1.5, x: 1, y: 1)
                .offset(x: 0, y: offset)
                .opacity(offset != 0 ? 0 : 1)
                .onAppear() {
                    withAnimation(.easeIn(duration: 1.5)) {
                        offset = number < 0 ? 200 : -200
                    } // 이 에니메이션이후로 설정된 offset은 그 위치에 계속 머무르고 있을 것입니다. 다시 기존의 위치로 돌아오지 않습니다.
                }
                .onDisappear() {
                    offset = 0
                }
        }
    }
}

//struct FlyingNumber_Previews: PreviewProvider {
//    static var previews: some View {
//        FlyingNumber(number: 5)
//    }
//}
