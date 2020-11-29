//
//  EmojiArtModel.swift
//  EmojiArt
//
//  Created by De La Cruz, Eduardo on 25/11/2020.
//

import Foundation

struct EmojiArtModel: Codable {
    
    struct Emoji: Identifiable, Codable {
        
        let id: Int
        let text: String
        var x: Int // Offset from the center
        var y: Int // Offset from the center
        var size: Int
        
        fileprivate init(id: Int, text: String, x: Int, y: Int, size: Int) {
            self.id = id
            self.text = text
            self.x = x
            self.y = y
            self.size = size
        }
    }
    
    var backgroundURL: URL?
    var emojis = [Emoji]()
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    private var uniqueEmojiId = 0
    
    init?(json: Data?) {
        guard let json = json, let newEmojiArt = try? JSONDecoder().decode(EmojiArtModel.self, from: json) else {
            return nil
        }
        self = newEmojiArt
    }
    
    init() { }
    
    mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(id: uniqueEmojiId, text: text, x: x, y: y, size: size))
    }
}
