//
//  ProfileView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/4.
//

import SwiftUI

struct ProfileView: View {
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
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.primary)
                }
            }
        }
    }
    
    var firstSection: some View {
        Group {
            HStack(alignment: .top) {
                AvatarView(url: URL(string: profile.icon)!)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(profile.name)
                            .font(.system(.title2, design: .monospaced))
                            .fontWeight(.bold)
                        Image(systemName: "person.fill")
                            .foregroundColor(profile.gender == .female ? .pink : .blue)
                    }
                    Text("Name: \(profile.name)")
                        .font(.body)
                    Text("WeChat ID: \(profile.id)")
                        .font(.caption)
                    Text("Region: \(profile.region)")
                        .font(.caption)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            Divider()
        }
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
                Button {
                    
                } label: {
                    Label("Messages", systemImage: "message")
                        .font(.system(.headline, design: .rounded))
                }
                Spacer()
            }
            
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
        }
    }
    
    var spacer: some View {
        HStack {
        }
        .frame(height: 8)
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.2))
    }
}

struct MessageProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(profile: dev.profile1)
        }
    }
}
