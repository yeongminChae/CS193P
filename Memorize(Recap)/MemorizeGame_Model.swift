//
//  MemorizeGame_Model.swift
//  Memorize(Recap)
//
//  Created by 채영민 on 2023/09/05.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>

    init(numberOfFairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfFairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(contents: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(contents: content, id: "\(pairIndex + 1)b"))
        }
    }

    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp}.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }
        }
    }

    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    cards[chosenIndex].isFaceUp = true
                    cards[potentialMatchIndex].isMatched = true
                }
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp = true
        }
    }

    mutating func shuffle() { 
        cards.shuffle()
    }

    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        let contents: CardContent
        var id: String
        var debugDescription: String {
            "\(id) : \(contents) \(isFaceUp ? "Up" : "Down")\(isMatched ? "matched" : "")"
        }
    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
