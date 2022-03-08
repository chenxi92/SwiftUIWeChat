//
//  MomentListRowView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/23.
//

import SwiftUI

struct MomentListRowView: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var momentsVM: MomentsViewModel
    
    let moment: Moment
    @State private var isShowCommentView = false
    
    var body: some View {
        HStack(alignment: .top) {
            AvatarView(url: URL(string: moment.profile.icon)!)
            
            VStack(alignment: .leading) {
                nameLabel
                content
                bottomView
                likesAndCommentsContent
            }
            .padding(.horizontal)
        }
        .onTapGesture {
            withAnimation {
                isShowCommentView = false
            }
        }
    }
    
    var nameLabel: some View {
        Text(moment.profile.name)
            .font(.system(size: 18, weight: .heavy))
            .foregroundColor(.blue)
            .padding(.bottom, 2)
    }
    
    @ViewBuilder
    var content: some View {
        if let text = moment.text {
            Text(text)
                .foregroundColor(.primary)
        } else {
            EmptyView()
        }
    }
    
    var bottomView: some View {
        HStack {
            Text(moment.date.asChatString())
                .font(.callout)
                .foregroundColor(.secondary)
            
            Spacer()

            HStack(spacing: 2) {
                Spacer()
                if isShowCommentView {
                    likesAndCommentsButton
                }
                commentButton
            }
        }
    }
    
    var commentButton: some View {
        Button {
            withAnimation {
                isShowCommentView.toggle()
            }
        } label: {
            Image(systemName: "ellipsis")
                .foregroundColor(.primary)
                .padding(10)
                .background(Color.black.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.vertical)
        }
    }
    
    var likesAndCommentsButton: some View {
        HStack(spacing: 0) {
            Button {
                addLike()
            } label: {
                Label("赞", systemImage: "heart")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.5))
            }
            
            Button {
                addComment()
            } label: {
                Label("评论", systemImage: "message")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.5))
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .transition(
            AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .opacity)
        )
    }
    
    var likesAndCommentsContent: some View {
        VStack(spacing: 0) {
            if moment.likes.count > 0 {
                MomentLikesView(moment: moment)
            }
            
            Divider()
                .padding(.horizontal)
            
            if moment.comments.count > 0 {
                MomentCommentsView(comments: moment.comments)
            }
        }
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
    func addLike() {
        isShowCommentView = false
        momentsVM.toogleLike(profile: profileVM.myProfile, in: moment)
    }
    
    func addComment() {
        isShowCommentView = false
    }
}

struct MomentListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MomentListRowView(moment: dev.momment1)
            .environmentObject(ProfileViewModel())
            .environmentObject(MomentsViewModel())
    }
}
