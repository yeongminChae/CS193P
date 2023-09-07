//
//  Memorize_Recap_App.swift
//  Memorize(Recap)
//
//  Created by 채영민 on 2023/09/04.
//

import SwiftUI

@main
struct Memorize_Recap_App: App {
    @StateObject var game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
