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
                .padding(.leading)
            }
            
            Divider().padding(.vertical)
            
            if isShowCommentField {
               commentField
            }
        }
        .padding(.horizontal)
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
            if moment.images.isEmpty {
                EmptyView()
            } else {
                if moment.images.count == 1 {
                    SingleImage(urlString: moment.images[0])
                } else {
                    MultipleImage(urlStrings: moment.images)
                }
            }
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
            if !moment.likes.isEmpty && !moment.comments.isEmpty {
                Divider()
            }
            if moment.comments.count > 0 {
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

extension MomentListRowView {
    
    struct FullScreenImageView: View {
        let urlArray: [String]?
        let urlString: String
        
        @Binding var isShowFullScreen: Bool
        
        var body: some View {
            VStack {
                ZStack {
                    Color.black.ignoresSafeArea()
                    CachedAsyncImage(url: URL(string: urlString) ?? nil)
                }
                .transition(AnyTransition.slide.animation(.spring()))
                .onTapGesture {
                    isShowFullScreen = false
                }
            }
            .onTapGesture {
                isShowFullScreen = false
            }
        }
    }
    struct SingleImage: View {
        let urlString: String
        @State private var isShowFullScreen: Bool = false
        
        var body: some View {
            CachedAsyncImage(url: URL(string: urlString)) { image in
                image
                    .resizable()
                    .frame(maxWidth: 180, minHeight: 180, idealHeight: 180)
                    .aspectRatio(1, contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .fullScreenCover(isPresented: $isShowFullScreen) {
                FullScreenImageView(urlArray: nil, urlString: urlString, isShowFullScreen: $isShowFullScreen)
            }
            .onTapGesture {
                isShowFullScreen.toggle()
            }
        }
    }
    
    struct MultipleImage: View {
        let urlStrings: [String]
        var rows: Int {
            urlStrings.count / cols
        }
        var cols: Int {
            urlStrings.count == 4 ? 2 : min(urlStrings.count, 3)
        }
        var lastRowCols: Int { urlStrings.count % cols }
        var spacing: CGFloat = 8
        @State private var isShowFullScreen: Bool = false
        @State private var selectedUrlString: String = ""
        
        var body: some View {
            VStack(alignment: .leading, spacing: spacing) {
                ForEach(0..<rows, id: \.self) { row in
                    self.rowBody(row: row, isLast: false)
                }
                if lastRowCols > 0 {
                    self.rowBody(row: rows, isLast: true)
                }
            }
            .fullScreenCover(isPresented: $isShowFullScreen) {
                FullScreenImageView(urlArray: nil, urlString: selectedUrlString, isShowFullScreen: $isShowFullScreen)
            }
        }
        
        func rowBody(row: Int, isLast: Bool) -> some View {
            HStack(spacing: spacing) {
                ForEach(0..<(isLast ? self.lastRowCols : self.cols), id: \.self) { col in
                    let url: URL = URL(string: urlStrings[row * self.cols + col])!
                    CachedAsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 60, maxWidth: 80, minHeight: 60, maxHeight: 80)
                            .aspectRatio(1, contentMode: .fill)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    .onTapGesture {
                        selectedUrlString = urlStrings[row * self.cols + col]
                        isShowFullScreen.toggle()
                    }
                }
            }
        }
    }
}

struct MomentListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MomentListRowView(moment: dev.moment3)
            .environmentObject(ProfileViewModel())
            .environmentObject(MomentsViewModel())
    }
}
