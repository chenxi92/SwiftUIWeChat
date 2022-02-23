//
//  Profile.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/22.
//

import Foundation

enum Gender: Int, Codable, Hashable {
    case male
    case female
}

struct Profile: Codable, Hashable {
    let id: UUID
    let icon: String
    let name: String
    let region: String
    let personalSign: String?
    let gender: Gender
}
