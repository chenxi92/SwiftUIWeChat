//
//  MomentLikesView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/7.
//

import SwiftUI

struct MomentLikesView: View {
    let moment: Moment
        
    var body: some View {
        FlexibleView(data: moment.likes) { profile in
            item(profile: profile)
        }
        .padding(.horizontal, 3)
        .padding(.vertical, 3)
    }
    
    func isLast(profile: Profile) -> Bool {
        guard let last = moment.likes.last else {
            return false
        }
        return last.id == profile.id
    }
    
    func item(profile: Profile) -> some View {
        HStack(spacing: 2) {
            Image(systemName: "heart")
            
            NavigationLink {
                ProfileView(profile: profile)
            } label: {
                Text(profile.name)
                    .font(.system(.body, design: .monospaced))
                    .fontWeight(.bold)
            }

            if !isLast(profile: profile) {
                Text(",")
                    .foregroundColor(.primary)
            }
        }
        .foregroundColor(.blue)
    }
}

struct MomentLikesView_Previews: PreviewProvider {
    static var previews: some View {
        MomentLikesView(moment: dev.moment1)
            .environmentObject(MomentsViewModel())
    }
}
