//
//  MomentsView.swift
//  SwiftUIWeChat
//
//  Created by 陈希 on 2022/2/22.
//

import SwiftUI

struct MomentsView: View {
    let moments: [Moment]
    
    init(moments: [Moment]) {
        self.moments = Development.shared.moments
    }
    
    @State private var isShowMomentEditorView = false
    @State private var isShowConfirmDialog = false
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(moments) { moment in
                    MomentListRowView(moment: moment)
                    MomentListRowView(moment: moment)
                    MomentListRowView(moment: moment)
                }
            }
            .fullScreenCover(isPresented: $isShowMomentEditorView, onDismiss: { isShowConfirmDialog = false }) {
                MomentEditorView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            toolbars()
        }
    }
    
    @ToolbarContentBuilder
    func toolbars() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            BackButton()
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Image(systemName: "camera.fill")
                .foregroundColor(.primary)
                .onTapGesture {
                    isShowConfirmDialog = true
                }
                .onLongPressGesture {
                    isShowMomentEditorView = true
                }
        }
    }
}

struct MomentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MomentsView(moments: dev.moments)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
