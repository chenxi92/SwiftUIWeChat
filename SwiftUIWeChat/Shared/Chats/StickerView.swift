//
//  StickerView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/3.
//

import SwiftUI

struct StickerView: View {
    
    @Binding var selectedSticker: String
    
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
    
    @State var recentUsedStickers: [String] = []
    
    let columns: [GridItem] = Array(
        repeating: GridItem(.flexible()),
        count: 8
    )
    
    let sendMessage: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 3) {
                Text("Recently Used")
                    .foregroundColor(.primary.opacity(0.7))
                    .font(.callout)
                
                HStack {
                    if recentUsedStickers.count == 0 {
                        StickerText(sticker: "🇨🇳")
                            .opacity(0)
                    } else {
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(recentUsedStickers, id: \.self) { sticker in
                                StickerText(sticker: sticker)
                            }
                        }
                    }
                }
                
                Text("All Stickers")
                    .foregroundColor(.primary.opacity(0.7))
                    .font(.callout)
                
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(allStickers, id: \.self) { sticker in
                        StickerText(sticker: sticker)
                    }
                }
            }
            
            overlayButtons()
                .padding([.bottom, .trailing], 5)
        }
        .padding(.horizontal)
    }
    
    func StickerText(sticker: String) -> some View {
        Text(sticker)
            .font(.title)
            .onTapGesture {
                onTapSticker(sticker)
            }
    }
    
    func overlayButtons() -> some View {
        HStack {
            Spacer()
            
            Button {
                selectedSticker = String(selectedSticker.dropLast())
            } label: {
                Image(systemName: "xmark.app")
                    .foregroundColor(selectedSticker.isEmpty ? .gray : .primary)
                    .font(.callout)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(.thinMaterial)
            .border(Color.white, width: 1)
            .clipShape(RoundedRectangle(cornerRadius: 5))

            Button {
                sendMessage()
            } label: {
                Text("Send")
                    .foregroundColor(selectedSticker.isEmpty ? .gray.opacity(0.8) : .white)
                    .font(.callout)
            }
            .padding(5)
            .background(Color.green)
            .border(Color.green, width: 1)
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
        .disabled(selectedSticker.isEmpty)
    }
    
    func onTapSticker(_ sticker: String) {
        selectedSticker += sticker
        if let index = recentUsedStickers.firstIndex(of: sticker) {
            recentUsedStickers.swapAt(0, index)
            return
        }
        if recentUsedStickers.count >= 8 {
            var leadingStickers = recentUsedStickers.dropLast()
            leadingStickers.insert(sticker, at: 0)
            recentUsedStickers = Array(leadingStickers)
        } else {
            recentUsedStickers.insert(sticker, at: 0)
        }
    }
}

struct StickerView_Previews: PreviewProvider {
    static var previews: some View {
        StickerView(selectedSticker: .constant("")) {
            
        }
        .frame(maxHeight: 250)
    }
}
