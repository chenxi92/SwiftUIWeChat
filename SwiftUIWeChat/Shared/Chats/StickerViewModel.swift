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
        "๐", "๐", "๐", "๐",
        "๐", "๐", "๐", "๐คฃ",
        "๐ฅฒ", "โบ๏ธ", "๐", "๐",
        "๐", "๐", "๐", "๐",
        "๐", "๐ฅฐ", "๐", "๐",
        "๐", "๐", "๐", "๐",
        "๐ถ", "๐ฑ", "๐ญ", "๐น",
        "๐ฐ", "๐ฆ", "๐ป", "๐ผ",
        "๐", "๐", "๐", "๐",
        "โฝ๏ธ", "๐ฅ", "๐ฅ", "๐ธ",
        "๐", "๐", "๐", "๐",
        "๐", "๐", "๐", "โ๏ธ",
        "๐ฅ", "๐ฝ", "โ๏ธ", "๐ฐ",
        "๐ฆ", "๐ก", "๐ช", "โค๏ธ",
        "๐งก", "๐", "๐ค", "๐ค",
        "๐", "โค๏ธโ๐ฅ", "๐", "โฃ๏ธ",
        "๐", "๐", "๐", "๐",
        "๐ฉ", "๐ด", "๐ณ๏ธโ๐", "๐ณ๏ธโโง๏ธ",
        "๐ดโโ ๏ธ", "๐", "๐ฆ๐ท", "๐ฆ๐ซ",
        "๐ฉ๐ฟ", "๐ฆ๐ฑ", "๐ด๐ฒ", "๐ช๐ช",
        "๐ฎ๐ช", "๐ช๐น", "๐ช๐ฌ", "๐ฆ๐ฉ",
        "๐ฆ๐ด", "๐ฆ๐ฎ", "๐ฆ๐ฌ", "๐จ๐ณ"
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
