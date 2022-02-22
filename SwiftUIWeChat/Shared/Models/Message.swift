//
//  Message.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/22.
//

import Foundation

struct Message: Identifiable, Codable {
    let id: UUID
    
    enum MessageType: Int, Codable {
        case sender
        case receiver
    }
    let type: MessageType
    let date: Date
    let text: String
}
