//
//  EmojiArtViewModel.swift
//  EmojiArt
//
//  Created by De La Cruz, Eduardo on 25/11/2020.
//

import SwiftUI

class EmojiArtViewModel: ObservableObject {
    
    static let palette: String = "⭐️⛈🍎🌏🥨⚾️"
    
    @Published private var model: EmojiArtModel = EmojiArtModel()
    
    // MARK: - Intent(s)
    
    func addEmoji(_ emoji: EmojiArtModel.Emoji, by offset: CGSize) {
        if let index = model.emojis.firstIndex(matching: emoji) {
            model.emojis[index].x += Int(offset.width)
            model.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji: EmojiArtModel.Emoji, by scale: CGFloat) {
        if let index = model.emojis.firstIndex(matching: emoji) {
            model.emojis[index].size = Int((CGFloat(model.emojis[index].size) * scale).rounded(.toNearestOrEven))
        }
    }
}
