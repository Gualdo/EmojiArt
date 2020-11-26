//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by De La Cruz, Eduardo on 25/11/2020.
//

import SwiftUI

struct EmojiArtView: View {
    
    @ObservedObject var viewModel: EmojiArtViewModel
    
    var body: some View {
        VStack {
            // MARK: - Emojis scrollview
            ScrollView(.horizontal) {
                HStack {
                    ForEach(EmojiArtViewModel.palette.map { String($0) }, id: \.self) { emoji in
                        Text(emoji)
                            .font(.system(size: defaultEmojiSize))
                            .onDrag { NSItemProvider(object: emoji as NSString) }
                    }
                }
            }
            .padding(.horizontal)
            // MARK: - Image space
            GeometryReader { geometry in
                ZStack {
                    // MARK: Image
                    Color.white
                        .overlay(
                            Group {
                                if let image = viewModel.backgroundImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                            }
                        )
                        .edgesIgnoringSafeArea([.horizontal, .bottom])
                        .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { providers, location in
                            var location = geometry.convert(location, from: .global)
                            location = CGPoint(x: location.x - geometry.size.width / 2, y: location.y - geometry.size.height / 2)
                            return drop(providers: providers, at: location)
                        }
                    // MARK: Emojis
                    ForEach(viewModel.emojis) { emoji in
                        Text(emoji.text)
                            .font(font(for: emoji))
                            .position(position(for: emoji, in: geometry.size))
                    }
                }
            }
        }
    }
    
    // MARK: - Custom functions
    
    private func drop(providers: [NSItemProvider], at location: CGPoint) -> Bool {
        var found = providers.loadFirstObject(ofType: URL.self) { url in
            print("dropped \(url)")
            self.viewModel.setBackgroundURL(url)
        }
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                self.viewModel.addEmoji(string, at: location, size: defaultEmojiSize)
            }
        }
        return found
    }
    
    private func font(for emoji: EmojiArtModel.Emoji) -> Font {
        Font.system(size: emoji.fontSize)
    }
    
    private func position(for emoji: EmojiArtModel.Emoji, in size: CGSize) -> CGPoint {
        return CGPoint(
            x: emoji.location.x + (size.width / 2),
            y: emoji.location.y + (size.height / 2)
        )
    }
    
    // MARK: - Drawing constants
    
    private let defaultEmojiSize: CGFloat = 40
}

// MARK: - Preview

struct EmojiArtView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmojiArtView(viewModel: EmojiArtViewModel())
        }
    }
}
