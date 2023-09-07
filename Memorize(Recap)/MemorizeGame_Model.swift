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
        get {
//            Old Code
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    faceUpCardIndices.append(index)
//                }
//            }
//            if faceUpCardIndices.count == 1 {
//                return faceUpCardIndices.first
//            } else {
//                return nil
//            }

//            New Code With Functional Programming
//            part 1 before Extension
//            let faceUpCardIndices = cards.indices.filter { index in cards[index].isFaceUp}
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil

//            part 2 after Extension
            return cards.indices.filter { index in cards[index].isFaceUp}.only
        }
        set {
//            Old Code
//            for index in cards.indices {
//                if index == newValue {
//                    cards[index].isFaceUp = true
//                } else {
//                    cards[index].isFaceUp = false
//                }
//            }

//          New Code With Functional Programming
            return cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }
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
//        index 함수 제거 이전 함수.
//        if let chosenIndex = index(of: card) {
//            cards[chosenIndex].isFaceUp.toggle()
//        }
    }

//    기존 index 함수를 제거하고 choose함수에 합치는 과정 진행
//    Old Index function
//    private func index(of card: Card) -> Int? {
//        for index in cards.indices {
//            return index
//        }
//        return nil
//    }

    mutating func shuffle() { 
        cards.shuffle()
    }

    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        // CustomDebugStringConvertible : 디버깅시에, 복잡한 string을 간단하게 콘솔에 표시해주는 프로토콜.
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
