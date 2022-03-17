//
//  MyProfileView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/10.
//

import SwiftUI

struct MyProfileView: View {
    
    @EnvironmentObject var profileVM: ProfileViewModel
    
    var body: some View {
        List {
            NavigationLink {
                
            } label: {
                HStack {
                    Text("Profile Photo")
                    Spacer()
                    AvatarView(url: URL(string: profileVM.myProfile.icon)!)
                }
            }
                        
            NavigationLink {
                
            } label: {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(profileVM.myProfile.name)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
            }
            
            NavigationLink {
                
            } label: {
                HStack {
                    Text("Tickle")
                    Spacer()
                }
            }
            
            NavigationLink {
                
            } label: {
                HStack {
                    Text("WeChat ID")
                    Spacer()
                    Text(profileVM.myProfile.id)
                        .foregroundColor(.gray)
                }
            }
            
            NavigationLink {
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            AvatarView(url: URL(string: profileVM.myProfile.icon)!)
                        }
                        
                        ZStack {
                            QRView(qrCode: profileVM.myProfile.id)
                            AvatarView(url: URL(string: profileVM.myProfile.icon)!)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .padding(.vertical, 50)
                    .background(Color.white)
                }
                .background(Color.black.opacity(0.7))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } label: {
                HStack {
                    Text("My QR Code")
                    Spacer()
                    Image(systemName: "qrcode")
                        .foregroundColor(.gray)
                }
            }
            
            NavigationLink {
                
            } label: {
                HStack {
                    Text("More")
                    Spacer()
                }
            }
            
            NavigationLink {
                
            } label: {
                HStack {
                    Text("Incoming Call Ringtones")
                    Spacer()
                }
            }
            
            NavigationLink {
                
            } label: {
                HStack {
                    Text("WeBeans")
                    Spacer()
                    Text("8")
                        .foregroundColor(.gray)
                }
            }
            
            NavigationLink {
                
            } label: {
                HStack {
                    Text("My Fapiao Titles")
                    Spacer()
                }
            }

        }
        .listStyle(.plain)
        .padding()
        .foregroundColor(.primary)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigation, content: { BackButton() })
        }
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MyProfileView()
                    .environmentObject(ProfileViewModel())
                    .navigationBarTitleDisplayMode(.inline)
                    .environment(\.locale, .init(identifier: "zh-Hans"))
            }
            
            NavigationView {
                MyProfileView()
                    .environmentObject(ProfileViewModel())
                    .navigationBarTitleDisplayMode(.inline)
                    .environment(\.locale, .init(identifier: "en"))
            }

        }
    }
}
