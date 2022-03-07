//
//  ContentView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import SwiftUI

fileprivate enum Tab {
    case chat
    case contact
    case discover
    case me
    
    var title: String {
        switch self {
            case .chat: return "微信"
            case .contact: return "通讯录信"
            case .discover: return "发现"
            case .me: return "我"
        }
    }
    var imageName: String {
        switch self {
            case .chat: return "message"
            case .contact: return "book"
            case .discover: return "paperplane"
            case .me: return "person"
        }
    }
}

struct ContentView: View {
    
    @State private var selection: Tab = .chat
    
    @State private var isShowChatMenu: Bool = false
    @State private var isShowContactMenu: Bool = false
    
    var body: some View {
        NavigationView { /// <--- This may cause toolbar disappear in sub views, like: ChatsTabView, ContactsTabView, DiscoverTabView, MeTabView
            TabView(selection: $selection) {
                ChatsTabView(isShowChatMenu: $isShowChatMenu)
                    .customTabItem(.chat)
                    .onAppear {
                        isShowChatMenu = false
                    }
                
                ContactsTabView()
                    .customTabItem(.contact)
                    .onAppear {
                        isShowContactMenu = false
                    }
                
                DiscoverTabView()
                    .customTabItem(.discover)
                
                MeTabView()
                    .customTabItem(.me)
            }
            .environmentObject(ProfileViewModel())
            .accentColor(.green)
            .navigationTitle(selection.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
            .navigationBarHidden(selection == .me ? true : false)
            /// In order to show different toolbars in diffenent sub views,
            .toolbar {
                customToolBars()
            }
        }
    }
    
    @ToolbarContentBuilder
    func customToolBars() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            if selection == .chat {
                Button {
                    isShowChatMenu.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.primary)
                }
            } else if selection == .contact {
                Button {
                    isShowContactMenu.toggle()
                } label: {
                    Image(systemName: "person.badge.plus")
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

fileprivate struct CustomTabItem: ViewModifier {
    let tab: Tab
    
    func body(content: Content) -> some View {
        content
            .tabItem {
                Label {
                    Text(tab.title)
                } icon: {
                    Image(systemName: tab.imageName)
                }
            }
            .tag(tab)
    }
}

private extension View {
    func customTabItem(_ tab: Tab) -> some View {
        modifier(CustomTabItem(tab: tab))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
