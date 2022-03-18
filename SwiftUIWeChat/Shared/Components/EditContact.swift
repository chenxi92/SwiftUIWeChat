//
//  EditContact.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/17.
//

import SwiftUI

struct EditContact: View {
    @EnvironmentObject var chatVM: ChatViewModel
    @EnvironmentObject var contactsVM: ContactsViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var isStared: Bool = true
    @State private var isBlock: Bool = false
    let profile: Profile
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Edit Contact")
                    Spacer()
                    Text(profile.name)
                        .foregroundColor(.gray)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary.opacity(0.5))
                }
                
                NavigationLink {
                    
                } label: {
                    HStack {
                        Text("Privacy")
                        Spacer()
                    }
                }
            }
            
            Section {
                NavigationLink {
                    
                } label: {
                    HStack {
                        Text("Share Contact")
                        Spacer()
                    }
                }
            }
            
            Section {
                Toggle("Stared", isOn: $isStared)
            }
            
            Section {
                Toggle("Block", isOn: $isBlock)
               
                NavigationLink {
                    
                } label: {
                    HStack {
                        Text("Report")
                        Spacer()
                    }
                }
            }
            
            HStack {
                Spacer()
                Button("Delete", role: .destructive) {
                    onDelete()
                }
                Spacer()
            }
        }
        .listStyle(.grouped)
        .navigationTitle(Text("Edit Contact"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar { toolbarItmes }
    }
    
    private func onDelete() {
        chatVM.chatDelete(profile: profile)
        contactsVM.contactDelete(profile: profile)
        dismiss()
    }
}

extension EditContact {
    @ToolbarContentBuilder
    var toolbarItmes: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            BackButton()
        }
    }
}

struct EditContact_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                EditContact(profile: ProfileViewModel().myProfile)
                    .environmentObject(ChatViewModel())
                    .environmentObject(ContactsViewModel())
                    .environment(\.locale, .init(identifier: "en"))
            }
            NavigationView {
                EditContact(profile: ProfileViewModel().myProfile)
                    .environmentObject(ChatViewModel())
                    .environmentObject(ContactsViewModel())
                    .environment(\.locale, .init(identifier: "zh-Hans"))
            }
        }
    }
}
