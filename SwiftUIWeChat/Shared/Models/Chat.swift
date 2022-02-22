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
    
    mutating func readToggle() {
        isRead.toggle()
    }
    
    mutating func visiableToggle() {
        isVisiable.toggle()
    }
}

