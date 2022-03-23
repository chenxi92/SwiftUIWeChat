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
    @EnvironmentObject var chatVM: ChatViewModel
    
    @StateObject var audioPlayer = AudioPlayer()
    
    var iconURLString: String {
        return (message.type == .receiver ? profileVM.myProfile.icon : chatProfile.icon)
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
            
            messageContent
            
            if edge == .trailing {
                NavigationLink {
                    ProfileView(profile: profileVM.myProfile)
                } label: {
                    AvatarView(url: URL(string: iconURLString)!)
                }
            }
        }
    }
    
    @ViewBuilder
    var messageContent: some View {
        if let text = message.text {
            Text(text)
                .backgroundStyle(edge: edge)
                .onTapGesture(count: 2) {
                    tapedMessage = DoubleTapedMessage(text: text)
                }
        } else if let audioURL = message.audioURL {
            HStack {
                Image(systemName: "dot.radiowaves.forward")
                Text("\(getAudioDuration(audioURL:audioURL))\"")
                Spacer()
                    .frame(maxWidth: 30)
            }
            .backgroundStyle(edge: edge)
            .onTapGesture {
                audioPlayer.startPlayback(audioFileURL: audioURL)
            }
        } else {
            EmptyView()
        }
    }
    
    func getAudioDuration(audioURL: URL) -> Int {
        if let recording = chatVM.getRocording(from: audioURL) {
            return recording.duration
        }
        return 0
    }
}

struct MessageBackgroundViewModifier: ViewModifier {
    let edge: Edge
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 5)
            .padding(.leading, edge == .leading ? 20 : 10)
            .padding(.trailing, edge == .leading ? 10 : 20)
            .frame(minHeight: 40)
            .background(edge == .leading ? Color.white : Color.green)
            .clipShape(
                ChatBubbleShape(arrowEdge: edge)
            )
            .padding(.horizontal, 10)
    }
}

extension View {
    func backgroundStyle(edge: Edge) -> some View {
        self.modifier(MessageBackgroundViewModifier(edge: edge))
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
            .environmentObject(ChatViewModel())
            .background(
                .black.opacity(0.1)
            )
            .padding(.vertical)
            .ignoresSafeArea()
        }
    }
}
