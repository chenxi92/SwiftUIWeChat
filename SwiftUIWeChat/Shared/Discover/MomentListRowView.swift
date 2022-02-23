//
//  MomentListRowView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/23.
//

import SwiftUI

struct MomentListRowView: View {
    let moment: Moment
    @State private var isShowCommentView = false
    
    var body: some View {
        HStack(alignment: .top) {
            HStack {
                AvatarView(url: URL(string: moment.profile.icon)!)
            }
                
            HStack {
                VStack(alignment: .leading) {
                    nameLabel
                    content
                    bottomView
                }
                .padding(.horizontal)
            }
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
            dateLabel
            Spacer()

            HStack(spacing: 2) {
                Spacer()
                if isShowCommentView {
                    commentsView
                }
                commentButton
            }
            .frame(maxWidth: .infinity)
        }
        
    }
    
    var dateLabel: some View {
        Text(moment.date.asChatString())
            .font(.callout)
            .foregroundColor(.secondary)
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
    
    var commentsView: some View {
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
    
    func addLike() {
        
    }
    
    func addComment() {
        
    }
}

struct MomentListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MomentListRowView(moment: dev.momment1)
            .frame(maxWidth: .infinity)
    }
}
