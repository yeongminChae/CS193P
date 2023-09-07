//
//  EmojiMemoryGame_ViewModel.swift
//  Memorize(Recap)
//
//  Created by 채영민 on 2023/09/05.
//

import SwiftUI // ViewModel은 UI의 일부여야 함

// A Function Before using Closure for New Code
//func createCardContent(forPairAtIndex index: Int) -> String {
//    return ["💀","🎃","👻","😈","🍭","🍬","🕯️","🦇","🙀","😱"][index]
//}

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["💀","🎃","👻","😈","🍭","🍬","🕯️","🦇","🙀","😱"]
    // Old Code1
    // private var model: MemoryGame<String> = MemoryGame<String>(numberOfFairsOfCards: 4)
    // model은 우리가 여기서 만들고 있는 것이 무엇인지 알고있기 때문에, 자동으로 타입을 추론해 줄 것입니다.
    // 또한 MemoryGame<String>에 제네릭 또한 cardContentFactory가 문자열인 것을 반환하는한 적지 않아도 된다는 것입니다.
    // 즉 내가 전달한 함수의 리턴 타입을 통해 그것의 타입을 추론할 수도 있다는 것입니다.

    // New Code
//    private var model = MemoryGame(numberOfFairsOfCards: 4, cardContentFactory: createCardContent(forPairAtIndex:))

    // New Code by using Closure
//    private var model = MemoryGame( numberOfFairsOfCards: 4) { pairIndex in
//            return emojis[pairIndex]
//        }
//    private var model = MemoryGame( numberOfFairsOfCards: 4) { index in -> index 대신 $0 사용가능, $0는 첫번째 인수라는 뜻이므로, in을 명시하지 않아도 됨.
//    private var model = MemoryGame( numberOfFairsOfCards: 4) { $0
//            return ["💀","🎃","👻","😈","🍭","🍬","🕯️","🦇","🙀","😱"][$0]
//        }

    // 클로저 적용전
    // private var model = MemoryGame(
    // numberOfFairsOfCards: 4,
    // cardContentFactory: {(index: Int) -> String in
    // return ["💀","🎃","👻","😈","🍭","🍬","🕯️","🦇","🙀","😱"][index]
    //     }
    // )
    // cardContentFactory가 Int를 취하고 문자열을 만환하는 함수라는 것을 알고 있기에 명시적으로 문자열을 반환함을 나타내지 않아도 됩니다.
    // 또한 index가 Int임을 알고 있기에 적어줄 필요가 없습니다.
    // 그리고 마지막 인수가 함수 또는 생성에 대한 것인 경우 이를 사용하여 우리는 이를 후행 클로저 구문 외부에 던질 수 있습니다.

    private static func createMemoryGame() -> MemoryGame<String> { // 반환 유형을 추론할 수 없는 이유 : 반환 유형은 항상 명시적이어야 합니다. Swift가 유일하게 추론할수 없는 것은 반환유형 입니다.
        return MemoryGame( numberOfFairsOfCards: 6) { pairIndex in
            if emojis.indices.contains(pairIndex) { // 배열 인덱스가 결코 범위를 벗어나지 않도록 하기 위하여 이 코드 줄을 보호하는 것.
                return emojis[pairIndex]
            } else {
                return "😬"
            }
        }
    }

    @Published private var model = EmojiMemoryGame.createMemoryGame()

    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }

    // MARK: - Intents

    func shuffle() {
        model.shuffle()
    }

    func choose(_ card: MemoryGame<String>.Card) { // intent function
        model.choose(card)
    }
}

