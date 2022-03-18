//
//  MyQRCodeView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/18.
//

import SwiftUI

struct MyQRCodeView: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            
            VStack {
                HStack(alignment: .top) {
                    AvatarView(url: URL(string: profileVM.myProfile.icon)!, height: 80, width: 80)
                    VStack {
                        HStack {
                            Text(profileVM.myProfile.name)
                            Image(systemName: "person.fill")
                                .foregroundColor(profileVM.myProfile.gender == .male ? .blue : .pink)
                        }
                        Text(profileVM.myProfile.region)
                    }
                    
                    Spacer()
                }
                .padding(.vertical)
                
                ZStack {
                    QRView(qrCode: "https://github.com/chenxi92/SwiftUIWeChat", size: CGSize(width: screenWidth - 100, height: screenWidth - 100))
                    
                    AvatarView(url: URL(string: profileVM.myProfile.icon)!, height: 80, width: 80)
                }
                
                Text("Scan the QR code to add me on WeChat")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding()
                    .padding(.top)
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(maxWidth: screenWidth - 40)
        }
        .navigationTitle(Text("My QR Code"))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigation, content: { BackButton() })
        }
    }
    
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
}

struct MyQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MyQRCodeView()
                    .navigationBarTitleDisplayMode(.inline)
                    .environmentObject(ProfileViewModel())
                    .environment(\.locale, .init(identifier: "zh-Hans"))
            }
            
            NavigationView {
                MyQRCodeView()
                    .navigationBarTitleDisplayMode(.inline)
                    .environmentObject(ProfileViewModel())
                    .environment(\.locale, .init(identifier: "en"))
            }
        }
    }
}
