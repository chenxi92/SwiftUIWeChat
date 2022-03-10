//
//  MessageListRow.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/22.
//

import SwiftUI

struct MessageListRow: View {
    
    let scale: CGFloat = 0.85
    let message: Message
    let chatProfile: Profile
    let width: CGFloat
    @Binding var tapedMessage: DoubleTapedMessage?
    
    @EnvironmentObject var profileVM: ProfileViewModel
    
    var iconURLString: String {
        return (message.type == .receiver ? profileVM.myProfile.icon : chatProfile.icon)
    }
    
    var text: String {
        return message.text
    }
    
    var edge: Edge {
        return (message.type == .receiver ? .trailing : .leading)
    }
    
    
    var body: some View {
        if edge == .leading {
            HStack(alignment: .top, spacing: 0) {
                content
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.vertical, 5)
            .padding(.trailing, width * (1 - scale))
        } else {
            HStack(alignment: .top) {
                Spacer()
                content
            }
            .padding(.trailing, 10)
            .padding(.vertical, 5)
            .padding(.leading, width * (1 - scale))
        }
    }
    
    var content: some View {
        HStack(alignment: .top, spacing: 0) {
            if edge == .leading {
                NavigationLink {
                    ProfileView(profile: chatProfile)
                } label: {
                    AvatarView(url: URL(string: iconURLString)!)
                }
            }
            
            Text(text)
                .padding(.vertical, 5)
                .padding(.leading, edge == .leading ? 20 : 10)
                .padding(.trailing, edge == .leading ? 10 : 20)
                .frame(minHeight: 40)
                .background(edge == .leading ? Color.white : Color.green)
                .clipShape(
                    ChatBubbleShape(arrowEdge: edge)
                )
                .padding(.horizontal, 10)
                .onTapGesture(count: 2) {
                    tapedMessage = DoubleTapedMessage(text: text)
                }
            
            if edge == .trailing {
                NavigationLink {
                    ProfileView(profile: profileVM.myProfile)
                } label: {
                    AvatarView(url: URL(string: iconURLString)!)
                }
            }
        }
    }
}


struct MessageListRow_Previews: PreviewProvider {
    
    static let chat = dev.chats[0]
    
    static var previews: some View {
        GeometryReader { reader in
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(chat.messages.indices) { index in
                        let message = chat.messages[index]
                        MessageListRow(message: message, chatProfile: chat.profile, width: reader.size.width, tapedMessage: .constant(nil))
                    }
                }
            }
            .environmentObject(ProfileViewModel())
            .background(
                .black.opacity(0.1)
            )
            .padding(.vertical)
            .ignoresSafeArea()
        }
    }
}
