//
//  EditContact.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/17.
//

import SwiftUI

struct EditContact: View {
    @State private var isStared: Bool = true
    @State private var isBlock: Bool = false
    
    var body: some View {
        List {
            Section {
                NavigationLink {
                    
                } label: {
                    HStack {
                        Text("Settings.Privacy")
                        Spacer()
                    }
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
                NavigationLink {
                    
                } label: {
                    HStack {
                        Text("Stared")
                        Spacer()
                        Toggle("", isOn: $isStared)
                    }
                }
            }
            
            Section {
                NavigationLink {
                    
                } label: {
                    HStack {
                        Text("Block")
                        Spacer()
                        Toggle("", isOn: $isBlock)
                    }
                }
                
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
                EditContact()
                    .environment(\.locale, .init(identifier: "en"))
            }
            NavigationView {
                EditContact()
                    .environment(\.locale, .init(identifier: "zh-Hans"))
            }
        }
    }
}
