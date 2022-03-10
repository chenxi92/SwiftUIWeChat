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
                    Text("微信号: \(profileVM.myProfile.id)")
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
            sectionSection
            thirdSection
        }
    }
    
    var firstSection: some View {
        Group {
            NavigationLink {
                List(0 ..< 5) { item in
                    Text("服务")
                }
            } label: {
                rowContent(systemName: "message", foregroundColor: .green, text: "服务")
            }
            spacerRow
        }
    }
    
    var sectionSection: some View {
        Group {
            NavigationLink {
                List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    Text("收藏")
                }
            } label: {
                rowContent(systemName: "cube", foregroundColor: .mint, text: "收藏")
            }
            Divider()
            
            NavigationLink {
                List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    Text("收藏")
                }
            } label: {
                rowContent(systemName: "photo", foregroundColor: .pink, text: "朋友圈")
            }
            Divider()
            
            NavigationLink {
                List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    Text("收藏")
                }
            } label: {
                rowContent(systemName: "play.circle", foregroundColor: .yellow, text: "视频号")
            }
            Divider()
            
            NavigationLink {
                List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    Text("收藏")
                }
            } label: {
                rowContent(systemName: "menucard", foregroundColor: .cyan, text: "卡包")
            }
            Divider()
            
            NavigationLink {
                List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    Text("收藏")
                }
            } label: {
                rowContent(systemName: "face.smiling", foregroundColor: .blue, text: "表情")
            }
            
            spacerRow
        }
    }
    
    var thirdSection: some View {
        Group {
            NavigationLink {
                List(0 ..< 5) { item in
                    Text("收藏")
                }
            } label: {
                rowContent(systemName: "gearshape", foregroundColor: .blue, text: "设置")
            }
        }
    }
    
    func rowContent(systemName: String, foregroundColor: Color, text: String) -> some View {
        HStack(spacing: 0) {
            Image(systemName: systemName)
                .foregroundColor(foregroundColor)
                .padding(.horizontal)
            Text(text)
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.primary)
        }
        .font(.title3)
        .padding(.vertical, 9)
        .padding(.horizontal)
    }
    
    
}

struct MeTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MeTabView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
                .environmentObject(ProfileViewModel())
        }
    }
}
