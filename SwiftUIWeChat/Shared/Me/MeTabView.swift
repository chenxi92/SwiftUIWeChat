//
//  MeTabView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import SwiftUI

struct MeTabView: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    
    var body: some View {
        ScrollView {
            header
            spacerRow
            listContent
        }
    }
}

extension MeTabView {
    
    var header: some View {
        NavigationLink {
            MyProfileView()
        } label: {
            headContent
                .foregroundColor(.primary)
        }
    }
    
    var headContent: some View {
        HStack(alignment: .bottom) {
            AvatarView(url: URL(string: profileVM.myProfile.icon)!, height: 70, width: 70)
                .padding(.trailing, 10)

            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(profileVM.myProfile.name)
                        .font(.title3)
                    Spacer()
                }
                HStack(spacing: 0) {
                    Text("WeChat ID: \(profileVM.myProfile.id)")
                        .font(.body)
                    Spacer()
                    Image(systemName: "qrcode")
                        .padding(.trailing, 8)

                    Image(systemName: "chevron.right")
                        .offset(x: 7)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
        .padding(.top)
    }
    
    var spacerRow: some View {
        Color.clear
            .background(.ultraThickMaterial)
            .frame(maxWidth: .infinity)
            .frame(height: 15)
    }
    
    var listContent: some View {
        Group {
            firstSection
            secondSection
            thirdSection
        }
    }
    
    var firstSection: some View {
        Group {
            NavigationLink {
                List(0 ..< 5) { item in
                    Text("Services")
                }
            } label: {
                rowContent(systemName: "message", foregroundColor: .green, text: "Services")
            }
            spacerRow
        }
    }
    
    var secondSection: some View {
        Group {
            NavigationLink {
                List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    Text("Favorites")
                }
            } label: {
                rowContent(systemName: "cube", foregroundColor: .mint, text: "Favorites")
            }
            Divider()
            
            NavigationLink {
                List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    Text("Moments")
                }
            } label: {
                rowContent(systemName: "photo", foregroundColor: .pink, text: "Moments")
            }
            Divider()
            
            NavigationLink {
                List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    Text("Channel")
                }
            } label: {
                rowContent(systemName: "play.circle", foregroundColor: .yellow, text: "Channel")
            }
            Divider()
            
            NavigationLink {
                List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    Text("Cards & Offers")
                }
            } label: {
                rowContent(systemName: "menucard", foregroundColor: .cyan, text: "Cards & Offers")
            }
            Divider()
            
            NavigationLink {
                List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    Text("Sticker Gallery")
                }
            } label: {
                rowContent(systemName: "face.smiling", foregroundColor: .blue, text: "Sticker Gallery")
            }
            
            spacerRow
        }
    }
    
    var thirdSection: some View {
        Group {
            NavigationLink {
                List(0 ..< 5) { item in
                    Text("Settings")
                }
            } label: {
                rowContent(systemName: "gearshape", foregroundColor: .blue, text: "Settings")
            }
        }
    }
    
    func rowContent(systemName: String, foregroundColor: Color, text: LocalizedStringKey) -> some View {
        HStack(spacing: 0) {
            Image(systemName: systemName)
                .foregroundColor(foregroundColor)
                .padding(.horizontal)
            Text(text)
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .font(.title3)
        .padding(.vertical, 7)
        .padding(.horizontal, 5)
    }
    
    
}

struct MeTabView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MeTabView()
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
                    .environmentObject(ProfileViewModel())
                    .environment(\.locale, .init(identifier: "en"))
            }
            
            NavigationView {
                MeTabView()
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
                    .environmentObject(ProfileViewModel())
                    .environment(\.locale, .init(identifier: "zh-hans"))
            }
        }
    }
}
