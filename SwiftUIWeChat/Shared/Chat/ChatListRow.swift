//
//  ChatListRow.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import SwiftUI

struct ChatListRow: View {
    let chat: Chat
    
    @EnvironmentObject var chatVM: ChatViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    
    var body: some View {
        ZStack {
            content
            
            NavigationLink(destination: MessageListView(chat: chat).environmentObject(chatVM).environmentObject(profileVM)) {
            }
            // hiden navation link arrow
            .buttonStyle(PlainButtonStyle())
            .frame(width:0)
            .opacity(0)
        }
    }
    
    var content: some View {
        HStack(alignment: .center) {
            ZStack(alignment: .topTrailing) {
                AvatarView(url: URL(string: chat.profile.icon)!)
                    .padding(5)
                
                if !chat.isRead {
                    Image(systemName: "circle.fill")
                        .scaleEffect(0.7)
                        .foregroundColor(.red)
                        .offset(x: 5, y: -5)
                }
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(chat.profile.name)
                        .font(.body)
                    
                    Spacer()
                    
                    Text(chat.messages.last?.date.asChatString() ?? "")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 3)
                
                HStack {
                    Text(chat.messages.last?.text ?? "")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    if !chat.isVisiable {
                        Image(systemName: "bell.slash")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct ChatListRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ChatListRow(chat: dev.chats[0])
                    .previewLayout(.sizeThatFits)
                
                ChatListRow(chat: dev.chats[1])
                    .previewLayout(.sizeThatFits)
            }
            .listStyle(.plain)
            .environmentObject(ChatViewModel())
            .environmentObject(ProfileViewModel())
        }
    }
}
