//
//  MemorizeGame_Model.swift
//  Memorize(Recap)
//
//  Created by 채영민 on 2023/09/05.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>

    func choose(card: Card) {

    }

    struct Card { // nested struct(중첩 struct) 
        var isFaceUp: Bool
        var isMatched: Bool
        var contents: CardContent
    }
}
