//
//  ProfileView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/4.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var chatVM: ChatViewModel
    let profile: Profile
    
    var body: some View {
        ScrollView {
            firstSection
            sectionSection
            thirdSection
            fourthSection
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar { toolbarItmes }
    }
}

extension ProfileView {
    
    @ToolbarContentBuilder
    var toolbarItmes: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            BackButton()
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink {
                EditContact(profile: profile)
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.primary)
            }
        }
    }
    
    var firstSection: some View {
        Group {
            HStack(alignment: .top) {
                AvatarView(url: URL(string: profile.icon)!)
                    .padding(.trailing)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(profile.name)
                            .font(.system(.title3, design: .monospaced))
                            .fontWeight(.bold)
                        Image(systemName: "person.fill")
                            .foregroundColor(profile.gender == .female ? .pink : .blue)
                    }
                    Text("Name: \(profile.name)")
                        .font(.body)
                    Text("WeChat ID: \(profile.id)")
                        .font(.callout)
                    Text("Region: \(profile.region)")
                        .font(.callout)
                }
                
                Spacer()
            }
            .padding(.top)
            .frame(maxWidth: .infinity)
            
            Divider()
        }
        .padding(.horizontal)
    }
    
    var sectionSection: some View {
        Group {
            NavigationLink {
                
            } label: {
                HStack {
                    Text("Tags")
                        .padding(.trailing)
                        .padding(.trailing)
                    
                    Text("朋友")
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.primary)
                .padding()
            }
            
            Divider()
            
            NavigationLink {
                
            } label: {
                HStack {
                    Text("Privacy")
                        .padding(.trailing)
                        .padding(.trailing)
                    
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.primary)
                .padding()
            }
            
            spacer
        }
    }
    
    var thirdSection: some View {
        Group {
            NavigationLink {
                
            } label: {
                HStack {
                    Text("Moments")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.primary)
                .padding()
            }
            
            Divider()
            
            NavigationLink {
                
            } label: {
                HStack {
                    Text("Channel")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.primary)
                .padding()
            }
            
            Divider()
            
            NavigationLink {
                
            } label: {
                HStack {
                    Text("More")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.primary)
                .padding()
            }
            
            spacer
        }
    }
    
    var fourthSection: some View {
        Group {
            HStack {
                Spacer()
                NavigationLink {
                    MessageListView(chat: chatVM.chat(for: profile))
                } label: {
                    Label("Messages", systemImage: "message")
                        .font(.system(.headline, design: .rounded))
                }
                
                Spacer()
            }
            .padding(.vertical)
            
            Divider()
            
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Label("Voice or Video Call", systemImage: "video")
                        .font(.system(.headline, design: .rounded))
                }
                Spacer()
            }
            .padding(.vertical)
        }
        .padding(.horizontal)
    }
    
    var spacer: some View {
        Color.clear
            .frame(height: 15)
            .frame(maxWidth: .infinity)
            .background(.ultraThickMaterial)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(profile: dev.profile1)
                .environmentObject(ChatViewModel())
        }
    }
}
