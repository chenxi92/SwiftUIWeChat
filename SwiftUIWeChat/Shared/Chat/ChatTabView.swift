//
//  ChatTabView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import SwiftUI

struct ChatTabView: View {
    
    @StateObject var chatVM = ChatViewModel()
    @StateObject var profileVM = ProfileViewModel()
    
    @State private var showMenu = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(chatVM.chats) { chat in
                    listRow(chat: chat)
                }
            }
            .listStyle(.plain)
            .searchable(text: $chatVM.searchText) {
                searchView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        menuView()
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.primary)
                    }
                }
            }
            .navigationTitle("微信")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    func menuView() -> some View {
        Button {
            
        } label: {
            Label("发起群聊", systemImage: "message")
        }
        
        Button {
            
        } label: {
            Label("添加朋友", systemImage: "person.fill.badge.plus")
        }
        Button {
            
        } label: {
            Label("扫一扫", systemImage: "qrcode.viewfinder")
        }
        
        Button {
            
        } label: {
            Label("收付款", systemImage: "dollarsign.circle")
        }
    }
    
    func listRow(chat: Chat) -> some View {
        ChatListRow(chat: chat)
            .environmentObject(chatVM)
            .environmentObject(profileVM)
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button(role: .destructive) {
                    chatVM.chatDelete(chat: chat)
                } label: {
                    Text("删除")
                }
    
                Button {
                    chatVM.chatToggleVisible(chat: chat)
                } label: {
                    Text(chat.isVisiable ? "不显示" : "显示")
                }
                .tint(.orange)
                
                Button {
                    chatVM.chatToggleRead(chat: chat)
                } label: {
                    Text(chat.isRead ? "标为未读" : "标为已读")
                }
                .tint(.blue)
            }
    }
    
    func searchView() -> some View {
        VStack {
            ScrollView {
                ForEach(chatVM.suggestedSearches) { chat in
                    Text(chat.profile.name)
                        .searchCompletion(chat.profile.name)
                }
            }
            Spacer()
        }
        .frame(maxHeight: .infinity)
    }
    
    
}

struct ChatTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatTabView(chatVM: ChatViewModel(), profileVM: ProfileViewModel())
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
