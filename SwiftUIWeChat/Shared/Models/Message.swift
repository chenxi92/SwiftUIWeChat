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
    let text: String?
    var audioURL: URL?
    let imageURL: URL?
    
    init(id: UUID, type: MessageType, date: Date, text: String?, audioURL: URL?, imageURL: URL?) {
        self.id = id
        self.type = type
        self.date = date
        self.text = text
        self.audioURL = audioURL
        self.imageURL = imageURL
    }
    
    init(text: String) {
        self.init(id: UUID(), type: .receiver, date: .now, text: text, audioURL: nil, imageURL: nil)
    }
    
    init(recording: Recording) {
        self.init(id: recording.messageId, type: .receiver, date: .now, text: nil, audioURL: recording.fileURL, imageURL: nil)
    }
    
    init(imageURL: URL) {
        self.init(id: UUID(), type: .receiver, date: .now, text: nil, audioURL: nil, imageURL: imageURL)
    }
    
    init(type: MessageType, dateString: String, text: String) {
        self.init(id: UUID(), type: type, date: dateString.toDate(), text: text, audioURL: nil, imageURL: nil)
    }
    
    init(type: MessageType, dateString: String, audioURL: URL) {
        self.init(id: UUID(), type: type, date: dateString.toDate(), text: nil, audioURL: audioURL, imageURL: nil)
    }
    
    init(type: MessageType, dateString: String, imageURL: URL) {
        self.init(id: UUID(), type: type, date: dateString.toDate(), text: nil, audioURL: nil, imageURL: imageURL)
    }
}

