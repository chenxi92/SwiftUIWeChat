//
//  ChatsTabView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import SwiftUI

struct ChatsTabView: View {
    
    @EnvironmentObject var chatVM: ChatViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    
    @Binding var isShowChatMenu: Bool
    
    var sortedChats: [Chat] {
        chatVM.chats.sorted { $0.lastUpdateTime > $1.lastUpdateTime }
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            List {
                ForEach(sortedChats) { chat in
                    listRow(chat: chat)
                }
            }
            .listStyle(.plain)
            .background(.thinMaterial)
            .searchable(text: $chatVM.searchText) {
                searchView()
            }
            
            if isShowChatMenu {
                Color.black.opacity(0.1)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowChatMenu.toggle()
                    }
                
                menuView()
                    .offset(y: 1)
            }
        }
    }
    
    func menuLabel(title: LocalizedStringKey, imageName: String) -> some View {
        HStack {
            Image(systemName: imageName)
                .padding(.leading, 10)
                .padding(.trailing)
            Text(title)
                .padding(.trailing)
        }
        .padding(.vertical, 5)
    }
    
    @ViewBuilder
    func menuView() -> some View {
        VStack(alignment: .leading) {
            Button {
                withAnimation {
                    isShowChatMenu.toggle()
                }
            } label: {
                menuLabel(title: "New Chat", imageName: "message")
            }
            
            Button {
                withAnimation {
                    isShowChatMenu.toggle()
                }
            } label: {
                menuLabel(title: "Add Contacts", imageName: "person.fill.badge.plus")
            }
            
            Button {
                withAnimation {
                    isShowChatMenu.toggle()
                }
            } label: {
                menuLabel(title: "Scan", imageName: "qrcode.viewfinder")
            }
            
            Button {
                withAnimation {
                    isShowChatMenu.toggle()
                }
            } label: {
                menuLabel(title: "Money", imageName: "dollarsign.circle")
            }
        }
        .foregroundColor(.white)
        .background(Color.black.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .padding(.trailing)
    }
    
    func listRow(chat: Chat) -> some View {
        ChatListRow(chat: chat)
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button(role: .destructive) {
                    chatVM.chatDelete(chat: chat)
                } label: {
                    Text("Delete")
                }
    
                Button {
                    chatVM.chatToggleVisible(chat: chat)
                } label: {
                    Text(chat.isVisiable ? "Show" : "Hide")
                }
                .tint(.orange)
                
                Button {
                    chatVM.chatToggleRead(chat: chat)
                } label: {
                    Text(chat.isRead ? "Mark as Unread" : "Mark as Read")
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
            ChatsTabView(isShowChatMenu: .constant(true))
                .environmentObject(ChatViewModel())
                .environmentObject(ProfileViewModel())
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
