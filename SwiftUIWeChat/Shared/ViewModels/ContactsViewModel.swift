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
}
