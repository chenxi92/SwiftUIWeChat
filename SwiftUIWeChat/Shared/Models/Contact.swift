//
//  Contact.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/10.
//

import Foundation

struct Contact: Codable {
    let title: String
    var contacts: [Profile]
}

extension Contact: Identifiable {
    var id: String {
        title
    }
}

extension Contact {
    static func build(title: String, @ProfileArrayBuilder _ profiles: () -> [Profile]) -> Contact {
        return Contact(title: title, profiles)
    }
    
    init(title: String, @ProfileArrayBuilder _ profiles: () -> [Profile]) {
        self.title = title
        self.contacts = profiles()
    }
    
    static var all: [Contact] {
        var map: [String: [Profile]] = [:]
        
        for profile in Profile.all {
            let key = profile.name.firstString()
            if map[key] != nil {
                map[key]!.append(profile)
            } else {
                map[key] = [profile]
            }
        }
        
        var contacts: [Contact] = []
        for pair in map {
            let title = pair.key
            let value = pair.value
            let contact = Contact(title: title, contacts: value)
            contacts.append(contact)
        }
        return contacts.sorted { $0.title < $1.title }
    }
}
