//
//  Chat.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import Foundation

struct Chat: Identifiable, Codable {
    let id: UUID
    var isRead: Bool
    var isVisiable: Bool
    let profile: Profile
    var messages: [Message]
    
    var lastUpdateTime: Int {
        if let last = messages.last {
            return Int(last.date.timeIntervalSince1970)
        }
        return 0
    }
}

extension Chat {
    mutating func readToggle() {
        isRead.toggle()
    }
    
    mutating func visiableToggle() {
        isVisiable.toggle()
    }
    
}

extension Chat {
    static func create(profile: Profile) -> Chat {
        return Chat(id: UUID(), isRead: true, isVisiable: true, profile: profile, messages: [])
    }
}

