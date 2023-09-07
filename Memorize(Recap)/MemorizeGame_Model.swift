//
//  MemorizeGame_Model.swift
//  Memorize(Recap)
//
//  Created by 채영민 on 2023/09/05.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    // private(set) : private과 같지만 이 변수 설정만 비공개라는 뜻입니다.

    init(numberOfFairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfFairsOfCards * 2 cards
        for pairIndex in 0..<max(2, numberOfFairsOfCards) { // max(2, numberOfFairsOfCards) 카드 쌍의 수가 2개 이하가 되는것을 방지하기 위한 코드
            let content = cardContentFactory(pairIndex)
            cards.append(Card(contents: content))
            cards.append(Card(contents: content))
        }
    }

    func choose(_ card: Card) {
      
    }

    mutating func shuffle() { // 모델을 수정할 수 있는 모든 함수는 mutating이라고 표시되어야 합니다.
        cards.shuffle()
    }

    struct Card {
        var isFaceUp = false
        var isMatched = false
        let contents: CardContent
    }
}
