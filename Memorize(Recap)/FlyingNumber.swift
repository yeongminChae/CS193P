//
//  FlyingNumber.swift
//  Memorize(Recap)
//
//  Created by 채영민 on 2023/09/10.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int

    var body: some View {
        if number != 0 {
            Text(number, format: .number)
        }
    }
}

//struct FlyingNumber_Previews: PreviewProvider {
//    static var previews: some View {
//        FlyingNumber(number: 5)
//    }
//}
