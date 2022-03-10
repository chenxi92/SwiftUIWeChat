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
        ScrollView {
            NavigationLink {
                
            } label: {
                HStack {
                    Text("Profile Photo")
                    Spacer()
                    AvatarView(url: URL(string: profileVM.myProfile.icon)!)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
            }
            .padding()

            
            Divider()
            
            NavigationLink {
                
            } label: {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(profileVM.myProfile.name)
                        .font(.title3)
                        .foregroundColor(.secondary)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            
            Divider()
        }
        .foregroundColor(.primary)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigation, content: { BackButton() })
        }
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MyProfileView()
                .environmentObject(ProfileViewModel())
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
