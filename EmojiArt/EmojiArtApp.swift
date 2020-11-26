//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by De La Cruz, Eduardo on 25/11/2020.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiArtView(viewModel: EmojiArtViewModel())
        }
    }
}
