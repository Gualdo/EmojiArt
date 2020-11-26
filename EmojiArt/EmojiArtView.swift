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
            ScrollView(.horizontal) {
                HStack {
                    ForEach(EmojiArtViewModel.palette.map { String($0) }, id: \.self) { emoji in
                        Text(emoji)
                            .font(.system(size: defaultEmojiSize))
                    }
                }
            }
            .padding(.horizontal)
            Rectangle()
                .foregroundColor(.yellow)
                .edgesIgnoringSafeArea([.horizontal, .bottom])
        }
    }
    
    // Mark: - Drawing constants
    
    private let defaultEmojiSize: CGFloat = 40
}

struct EmojiArtView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmojiArtView(viewModel: EmojiArtViewModel())
        }
    }
}
