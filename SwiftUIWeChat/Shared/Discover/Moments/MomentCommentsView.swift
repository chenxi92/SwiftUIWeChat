//
//  MomentCommentView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/7.
//

import SwiftUI

struct MomentCommentsView: View {
    let comments: [Comment]
    
    var body: some View {
        ForEach(comments) { comment in
            HStack {
                NavigationLink {
                    ProfileView(profile: comment.profile)
                } label: {
                    Text("\(comment.profile.name):")
                        .font(.system(.body, design: .monospaced))
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.leading, 5)
                }

                Text(comment.text)
                Spacer()
            }
            .padding(.vertical, 8)
        }
    }
}

struct MomentCommentView_Previews: PreviewProvider {
    static var previews: some View {
        MomentCommentsView(comments: dev.momment1.comments)
    }
}
