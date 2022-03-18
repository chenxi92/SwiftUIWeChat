//
//  ContactsViewModel.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/23.
//

import Foundation
import SwiftUI
import Combine

class ContactsViewModel: ObservableObject {

    @Published private var allContacts: [Contact] = []
    @Published var searchText: String = ""
    
    @Published var filterContacts: [Contact] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscription()
        load()
    }
    
    private func load() {
        allContacts.append(contentsOf: Contact.all)
    }
    
    private func addSubscription() {
        $allContacts.combineLatest($searchText)
            .map { (allContacts, searchText) -> [Contact] in
                allContacts
            }
            .sink { filteredContacts in
                self.filterContacts = filteredContacts
            }
            .store(in: &cancellables)
    }
    
    public func contactDelete(profile: Profile) {
        let temp = allContacts
        
        for i in 0..<temp.count {
            var contact = temp[i]
            if let index = contact.contacts.firstIndex(where: { $0.id == profile.id }) {
                contact.contacts.remove(at: index)
                if contact.contacts.isEmpty {
                    allContacts.remove(at: i)
                } else {
                    allContacts[i] = contact
                }
            }
        }
    }
}
