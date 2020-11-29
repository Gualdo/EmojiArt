//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by De La Cruz, Eduardo on 28/11/2020.
//

import SwiftUI

struct OptionalImage: View {
    
    var uiImage: UIImage?
    
    var body: some View {
        Group {
            if let image = uiImage {
                Image(uiImage: image)
            }
        }
    }
}
