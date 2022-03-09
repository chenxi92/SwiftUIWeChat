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
    @State private var isShowCommentField = false
    @State private var comment: String = ""
    @FocusState private var isFocused
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5) {
            HStack(alignment: .top) {
                AvatarView(url: URL(string: moment.profile.icon)!)
                
                VStack(alignment: .leading) {
                    name
                    content
                    dateRow
                    likesAndCommentsContent
                }
                .padding(.horizontal)
            }
            
            Divider().padding(.horizontal)
            
            if isShowCommentField {
               commentField
            }
        }
        .onTapGesture {
            withAnimation {
                isShowCommentView = false
            }
        }
    }

    func onLikeButtonPress() {
        isShowCommentView = false
        isShowCommentField = false
        momentsVM.toogleLike(profile: profileVM.myProfile, in: moment)
    }
    
    func onCommentButtonPress() {
        isShowCommentView = false
        isShowCommentField = true
        isFocused = true
    }
    
    func sendComment() {
        momentsVM.addComment(text: comment, moment: moment, profile: profileVM.myProfile)
        isFocused = false
        isShowCommentField = false
        comment = ""
    }
}

extension MomentListRowView {
    
    var name: some View {
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
    
    var dateRow: some View {
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
        }
    }
    
    var likesAndCommentsButton: some View {
        HStack(spacing: 0) {
            Button {
                onLikeButtonPress()
            } label: {
                Label("赞", systemImage: "heart")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.5))
            }
            
            Button {
                onCommentButtonPress()
            } label: {
                Label("评论", systemImage: "message")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.5))
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .transition(
            AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .scale)
        )
    }
    
    var likesAndCommentsContent: some View {
        VStack(spacing: 5) {
            if moment.likes.count > 0 {
                MomentLikesView(moment: moment)
            }
            if moment.comments.count > 0 {
                Divider().padding(.horizontal)
                MomentCommentsView(comments: moment.comments)
            }
        }
        .padding(5)
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
    var commentField: some View {
        HStack(spacing: 5) {
            TextField("", text: $comment, prompt: Text("Comment"))
                .frame(maxWidth: .infinity)
                .padding(5)
                .textFieldStyle(.roundedBorder)
                .focused($isFocused)
                .onSubmit {
                    sendComment()
                }
            
            Image(systemName: "face.smiling")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 5)
        .background(Color.black.opacity(0.15))
    }
}

struct MomentListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MomentListRowView(moment: dev.momment1)
            .environmentObject(ProfileViewModel())
            .environmentObject(MomentsViewModel())
    }
}
