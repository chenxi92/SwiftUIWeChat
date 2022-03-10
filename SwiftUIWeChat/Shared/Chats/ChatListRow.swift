//
//  ChatListRow.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import SwiftUI

struct ChatListRow: View {
    let chat: Chat
    
    var body: some View {
        CustomLinkRow {
            content
        } destination: {
            MessageListView(chat: chat)
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
