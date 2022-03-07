//
//  MeTabView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import SwiftUI

struct MeTabView: View {
    @EnvironmentObject var profileVM:ProfileViewModel
    
    var body: some View {
        GeometryReader { reader in
            Color(UIColor.systemGroupedBackground)
            
            VStack {
                NavigationLink {
                    Text("xx")
                } label: {
                    header
                        .frame(maxWidth: reader.size.width)
                }

               listContent
            }
            .foregroundColor(.primary)
        }
    }
    
    var header: some View {
        HStack(alignment: .center) {
            AvatarView(url: URL(string: profileVM.myProfile.icon)!)
                .padding(.horizontal)

            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(profileVM.myProfile.name)
                        .font(.title2)
                    Spacer()
                }
                
                HStack {
                    Text("微信号: chenxi11111")
                        .font(.caption)
                    
                    Spacer()
                    
                    Image(systemName: "qrcode")
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 8, height: 10)
                        .foregroundColor(.secondary)
                        .padding(.leading)
                }
            }
            .padding()
            
            Spacer()
        }
        .padding(.vertical)
        .padding(.top)
        .background(Color.white)
    }
    
    var listContent: some View {
        List {
            Section {
                staticRow(systemName: "message", foregroundColor: .green, text: "服务") {
                    List(0 ..< 5) { item in
                        Text("服务")
                    }
                }
            }
            
            Section {
                staticRow(systemName: "cube", foregroundColor: .mint, text: "收藏") {
                    List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                        Text("收藏")
                    }
                }
                staticRow(systemName: "photo", foregroundColor: .pink, text: "朋友圈") {
                    Text("朋友圈")
                }
                staticRow(systemName: "play.circle", foregroundColor: .yellow, text: "视频号") {
                    Text("视频号")
                }
                staticRow(systemName: "menucard", foregroundColor: .cyan, text: "卡包") {
                    Text("卡包")
                }
                staticRow(systemName: "face.smiling", foregroundColor: .blue, text: "表情") {
                    Text("表情")
                }
            }
            
            Section {
                staticRow(systemName: "gearshape", foregroundColor: .blue, text: "设置") {
                    Text("设置")
                }
            }
        }
        .listStyle(.grouped)
    }

    func staticRow<T: View>(
        systemName: String,
        foregroundColor: Color,
        text: String,
        destination: () -> T) -> some View {
        
        return NavigationLink {
            destination()
        } label: {
            HStack(spacing: 0) {
                Image(systemName: systemName)
                    .foregroundColor(foregroundColor)
                    .padding(.horizontal)
                
                Text(text)
                    .foregroundColor(.primary)
                
                Spacer()
            }
        }

    }
}

struct ProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        MeTabView()
            .environmentObject(ProfileViewModel())
    }
}
