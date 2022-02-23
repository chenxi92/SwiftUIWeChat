//
//  Moment.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/23.
//

import Foundation

struct Moment: Identifiable {
    var id: String {
        return profile.id.uuidString + date.debugDescription
    }
    
    let profile: Profile
    let date: Date
    let text: String?
    let images: [String]
    let link: URL?
    let likes: [Profile]
    let comments: [Comment]
}

struct Comment: Identifiable {
    let profile: Profile
    let text: String
    
    var id: String {
        return profile.id.uuidString + text
    }
}
