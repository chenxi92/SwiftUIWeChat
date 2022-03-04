//
//  MessageDetailView.swift
//  SwiftUIWeChat
//
//  Created by 陈希 on 2022/2/20.
//

import SwiftUI

struct MessageDetailView: View {
    let chat: Chat
    
    @State private var isMuteNotification: Bool = true
    @State private var isStickToTop: Bool = false
    @State private var isShowAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                group1
                group2
                group3
                group4
                group5
                group6
            }
            .background(Color.white)
            .frame(maxWidth: .infinity)
        }
        .background(.thickMaterial)
        .navigationTitle("聊天详情")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
        }
    }
    
    var group1: some View {
        Group {
            HStack {
                VStack {
                    AvatarView(url: URL(string: chat.profile.icon)!)
                        .padding(.horizontal)
                        .padding(.top)
                    Text(chat.profile.name)
                        .font(.caption)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [12]))
                        )
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            spacer
        }
    }
    
    
    var group2: some View {
        Group {
            linkRow(title: "Search Chat History", imageName: "chevron.right") {
                VStack {
                    Text("search chat history view.")
                }
            }
                        
            spacer
        }
    }
    
    var group3: some View {
        VStack {
            togleRow(title: "Mute Notifications", isOn: $isMuteNotification)
            Divider()
            togleRow(title: "Sticky on Top", isOn: $isStickToTop)
            Divider()
            togleRow(title: "Alert", isOn: $isShowAlert)
            spacer
        }
    }
    
    var group4: some View {
        Group {
            linkRow(title: "Background", imageName: "chevron.right") {
                VStack {
                    Text("Background view.")
                }
            }
            
            spacer
        }
    }
    
    var group5: some View {
        Group {
            linkRow(title: "Clear Chat History", imageName: "chevron.right") {
                VStack {
                    Text("Clear Chat History view.")
                }
            }
            
            spacer
        }
    }
    
    var group6: some View {
        Group {
            linkRow(title: "Report", imageName: "chevron.right") {
                VStack {
                    Text("Report view.")
                }
            }
        }
    }
    
    private func togleRow(title: String, isOn: Binding<Bool>) -> some View {
        HStack {
            Text(title)
            Spacer()
            Toggle("", isOn: isOn)
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
    
    private func linkRow<Destination: View>(title: String, imageName: String, destination: () -> Destination) -> some View {
        NavigationLink {
            destination()
        } label: {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: imageName)
            }
            .foregroundColor(.primary)
            .padding()
        }
    }
    
    var spacer: some View {
        HStack {
            Color.black
                .opacity(0.15)
        }
        .frame(height: 10)
    }
}

struct MessageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MessageDetailView(chat: Development.shared.chats.first!)
        }
    }
}
