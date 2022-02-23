//
//  ContactsViewModel.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/23.
//

import Foundation
import SwiftUI

class ContactsViewModel: ObservableObject {

    @Published private(set) var myContacts: [Profile] = []
    
}
