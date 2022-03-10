//
//  ContactsTabView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import SwiftUI

struct ContactsTabView: View {
    
    @State private var isAddContacts: Bool = false
    @EnvironmentObject var contactsVM: ContactsViewModel
    
    var body: some View {
        VStack {            
            List {
                ForEach(contactsVM.filterContacts) { contact in
                    Section(header: ContactSectionHeader(title: contact.title)) {
                        ForEach(contact.contacts) { profile in
                            contactRow(profile: profile)
                        }
                    }
                }
                .listRowInsets(.none)
                .listSectionSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func contactRow(profile: Profile) -> some View {
        CustomLinkRow {
            HStack {
                AvatarView(url: URL(string: profile.icon)!, height: 40, width: 40)
                
                Text(profile.name)
                    .font(.system(size: 16))
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)

        } destination: {
            ProfileView(profile: profile)
        }
    }
}

struct ContactSectionHeader: View {
    let title: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.clear.background(.ultraThinMaterial)
                .frame(maxWidth: .infinity)
            
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .padding(5)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ContactTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactsTabView()
                .navigationBarTitleDisplayMode(.inline)
        }
        .environmentObject(ContactsViewModel())
    }
}
