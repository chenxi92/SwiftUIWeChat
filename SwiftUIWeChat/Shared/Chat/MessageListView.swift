//
//  MessageView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import SwiftUI

struct MessageListView: View {
    @EnvironmentObject var chatVM: ChatViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    
    let chat: Chat
    
    @State private var text: String = ""
    @FocusState private var isFocused
    @State private var messageIDToScroll: UUID?
    @State private var tapedMessage: DoubleTapedMessage?
    
    var body: some View {
        VStack(spacing: 0) {
            messageList()
            toolBarView()
        }
        .toolbar {
            toolbarButtons()
        }
        .navigationTitle(chat.profile.name)
    }
    
    private func messageList() -> some View {
        GeometryReader {reader in
            ScrollView {
                ScrollViewReader { scrollReader in
                    getMessageView(viewWidth: reader.size.width)
                        .onChange(of: messageIDToScroll) { newValue in
                            if let messageIDToScroll = messageIDToScroll {
                                scrollTo(messageID: messageIDToScroll, shouldAnimate: true, scrollReader: scrollReader)
                            }
                        }
                        .onAppear {
                            if let messageID = chat.messages.last?.id {
                                scrollTo(messageID: messageID, shouldAnimate: false, scrollReader: scrollReader)
                            }
                        }
                }
            }
            .background(.black.opacity(0.1))
            .onTapGesture {
                isFocused = false
            }
            // Double tap message text
            .fullScreenCover(item: $tapedMessage, onDismiss: { tapedMessage = nil }) { messageObject  in
                MessageDoubleTapView(messageObject: messageObject)
            }
        }
    }
    
    private func toolBarView() -> some View {
        VStack {
            let height: CGFloat = 37
            HStack {
                TextField("Message", text: $text)
                    .padding(.horizontal, 10)
                    .frame(height: height)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                    .focused($isFocused)
                
                Button {
                    sendMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .frame(width: height, height: height)
                        .background(
                            Circle()
                                .foregroundColor(text.isEmpty ? .gray : .blue)
                        )
                }
                .disabled(text.isEmpty)
            }
        }
        .padding(.vertical)
        .padding(.horizontal)
        .background(.thickMaterial)
    }
    
    private func toolbarButtons() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink {
                MessageDetailView()
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.primary)
            }
        }
    }
    
    private let columns = [GridItem(.flexible(minimum: 10))]
    private func getMessageView(viewWidth: CGFloat) -> some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(chat.messages) { message in
                MessageListRow(
                    iconURLString: message.type == .receiver ? profileVM.myProfile.icon : chat.profile.icon,
                    text: message.text,
                    edge: message.type == .receiver ? .trailing : .leading,
                    width: viewWidth,
                    tapedMessage: $tapedMessage
                )
            }
        }
    }
}

extension MessageListView {
    private func scrollTo(messageID: UUID, shouldAnimate: Bool, scrollReader: ScrollViewProxy) {
        DispatchQueue.main.async {
            withAnimation(shouldAnimate ? Animation.easeIn: nil) {
                scrollReader.scrollTo(messageID, anchor: .bottom)
            }
        }
    }
    
    private func sendMessage() {
        if let message = chatVM.sendMessage(text, chat: chat) {
            text = ""
            messageIDToScroll = message.id
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MessageListView(chat: dev.chats[0])
                .environmentObject(ChatViewModel())
                .environmentObject(ProfileViewModel())
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
