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
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            List {
                ForEach(chatVM.sortedChats) { chat in
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
    
    func menuLabel(title: String, imageName: String) -> some View {
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
                menuLabel(title: "发起群聊", imageName: "message")
            }
            
            Button {
                withAnimation {
                    isShowChatMenu.toggle()
                }
            } label: {
                menuLabel(title: "添加朋友", imageName: "person.fill.badge.plus")
            }
            
            Button {
                withAnimation {
                    isShowChatMenu.toggle()
                }
            } label: {
                menuLabel(title: "扫一扫", imageName: "qrcode.viewfinder")
            }
            
            Button {
                withAnimation {
                    isShowChatMenu.toggle()
                }
            } label: {
                menuLabel(title: "收付款", imageName: "dollarsign.circle")
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
            ChatsTabView(isShowChatMenu: .constant(true))
                .environmentObject(ChatViewModel())
                .environmentObject(ProfileViewModel())
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
