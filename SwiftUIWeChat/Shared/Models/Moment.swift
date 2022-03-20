//
//  Moment.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/23.
//

import Foundation

struct Moment: Identifiable, Codable {
    var id: String {
        return profile.id + date.debugDescription
    }
    
    let profile: Profile
    let date: Date
    let text: String?
    let images: [String]
    let link: URL?
    var likes: [Profile]
    var comments: [Comment]
    let videoUrl: String?
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

extension Moment {
    static func createMoment(text: String, profile: Profile) -> Moment {
        return Moment(
            profile: profile,
            date: .now,
            text: text,
            images: [],
            link: nil,
            likes: [],
            comments: [],
            videoUrl: nil
        )
    }
}

struct Comment: Identifiable, Codable {
    let profile: Profile
    let text: String
    
    var id: String {
        return profile.id + text
    }
}
