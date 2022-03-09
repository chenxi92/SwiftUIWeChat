//
//  StickerViewModel.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/4.
//

import Foundation
import SwiftUI

class StickerViewModel: ObservableObject {
    
    @LocalCache("recentUsedStickers", wrappedValue: [])
    var recentUsedStickers: [String]
    
    let allStickers: [String] = [
        "😀", "😃", "😄", "😁",
        "😆", "😅", "😂", "🤣",
        "🥲", "☺️", "😊", "😇",
        "🙂", "🙃", "😉", "😌",
        "😍", "🥰", "😘", "😗",
        "😙", "😚", "😋", "😛",
        "🐶", "🐱", "🐭", "🐹",
        "🐰", "🦊", "🐻", "🐼",
        "🍏", "🍋", "🍓", "🍑",
        "⚽️", "🥎", "🥏", "🏸",
        "🚒", "🚛", "🚜", "🏍",
        "🚍", "🚟", "🚃", "⌚️",
        "🖥", "📽", "☎️", "🕰",
        "🔦", "💡", "🪙", "❤️",
        "🧡", "💚", "🤍", "🤎",
        "💔", "❤️‍🔥", "💞", "❣️",
        "💗", "💖", "💘", "💝",
        "🚩", "🏴", "🏳️‍🌈", "🏳️‍⚧️",
        "🏴‍☠️", "🏁", "🇦🇷", "🇦🇫",
        "🇩🇿", "🇦🇱", "🇴🇲", "🇪🇪",
        "🇮🇪", "🇪🇹", "🇪🇬", "🇦🇩",
        "🇦🇴", "🇦🇮", "🇦🇬", "🇨🇳"
    ]
    
    let maxRecentSticker: Int = 8
    
    func onTapSticker(sticker: String) {
        if let index = recentUsedStickers.firstIndex(of: sticker) {
            recentUsedStickers.swapAt(0, index)
            return
        }
        if recentUsedStickers.count >= maxRecentSticker {
            var remainStickers = recentUsedStickers.dropLast()
            remainStickers.insert(sticker, at: 0)
            recentUsedStickers = Array(remainStickers)
        } else {
            recentUsedStickers.insert(sticker, at: 0)
        }
    }
}
