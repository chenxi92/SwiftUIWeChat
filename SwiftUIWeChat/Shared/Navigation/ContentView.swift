//
//  ContentView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import SwiftUI

struct ContentView: View {
    
    enum Tab {
        case chat
        case contact
        case discover
        case profile
        
        var title: String {
            switch self {
                case .chat: return "微信"
                case .contact: return "通讯录信"
                case .discover: return "发现"
                case .profile: return "我"
            }
        }
        var imageName: String {
            switch self {
                case .chat: return "message"
                case .contact: return "book"
                case .discover: return "paperplane"
                case .profile: return "person"
            }
        }
    }
    
    @State private var selection: Tab = .chat
    
    var body: some View {
        TabView(selection: $selection) {
            chatTab
            contactTab
            discoverTab
            profileTab
        }
        .accentColor(.green)
//        .navigationBarTitleDisplayMode(.inline)
    }
    
    var chatTab: some View {
        ChatsTabView()
            .tabItem {
                Label {
                    Text(Tab.chat.title)
                } icon: {
                    Image(systemName: Tab.chat.imageName)
                }
            }
            .tag(Tab.chat)
    }
    
    var contactTab: some View {
        ContactsTabView()
            .tabItem({
                Label {
                    Text(Tab.contact.title)
                } icon: {
                    Image(systemName: Tab.contact.imageName)
                }
            })
            .tag(Tab.contact)
    }
    
    var discoverTab: some View {
        DiscoverTabView()
            .tabItem({
                Label {
                    Text(Tab.discover.title)
                } icon: {
                    Image(systemName: Tab.discover.imageName)
                }
            })
            .tag(Tab.discover)
    }
    
    var profileTab: some View {
        MeTabView()
            .tabItem({
                Label {
                    Text(Tab.profile.title)
                } icon: {
                    Image(systemName: Tab.profile.imageName)
                }
            })
            .tag(Tab.profile)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
