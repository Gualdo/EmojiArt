//
//  EmojiArtViewModel.swift
//  EmojiArt
//
//  Created by De La Cruz, Eduardo on 25/11/2020.
//

import SwiftUI

class EmojiArtViewModel: ObservableObject {
    
    private static let untitled: String = "EmojiArtDocument.Untitled"
    static let palette: String = "⭐️⛈🍎🌏🥨⚾️"
    
    @Published private (set) var backgroundImage: UIImage?
    @Published private var model: EmojiArtModel = EmojiArtModel() {
        didSet {
            UserDefaults.standard.set(model.json, forKey: EmojiArtViewModel.untitled)
        }
    }
    
    init() {
        model = EmojiArtModel(json: UserDefaults.standard.data(forKey: EmojiArtViewModel.untitled)) ?? EmojiArtModel()
        fetchBackgroundImageData()
    }
    
    var emojis: [EmojiArtModel.Emoji] { model.emojis }
    
    // MARK: - Intent(s)
    
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
        model.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArtModel.Emoji, by offset: CGSize) {
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
    
    func setBackgroundURL(_ url: URL?) {
        model.backgroundURL = url?.imageURL
        fetchBackgroundImageData()
    }
    
    // MARK: - Custom Functions
    
    private func fetchBackgroundImageData() {
        backgroundImage = nil
        if let url = model.backgroundURL {
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async { [weak self] in
                        if url == self?.model.backgroundURL {
                            self?.backgroundImage = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    }
}

extension EmojiArtModel.Emoji {
    // This two vars are created in the viewModel File as an extension in order to prevent violation of the MVVM Achitecture
    var fontSize: CGFloat { CGFloat(size) }
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
}
