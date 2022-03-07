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
    var likes: [Profile]
    var comments: [Comment]
}

extension Moment {
    mutating func toggleLike(profile: Profile) {
        if let index = likes.firstIndex(where: { $0.id == profile.id }) {
            self.likes.remove(at: index)
        } else {
            self.likes.insert(profile, at: 0)
        }
    }
}

struct Comment: Identifiable {
    let profile: Profile
    let text: String
    
    var id: String {
        return profile.id.uuidString + text
    }
}
