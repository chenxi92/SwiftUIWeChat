//
//  Recording.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/23.
//

import Foundation

struct Recording: Codable {
    var fileURL: URL
    var createdAt: Date
    var duration: Int
    var messageId: UUID
    var chatId: UUID
    
    init(fileURL: URL, chatId: UUID) {
        self.fileURL = fileURL
        self.createdAt = Date.now
        self.duration = 0
        self.messageId = UUID()
        self.chatId = chatId
    }
}
