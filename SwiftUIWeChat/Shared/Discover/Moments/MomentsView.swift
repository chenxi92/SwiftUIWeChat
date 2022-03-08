//
//  MomentsView.swift
//  SwiftUIWeChat
//
//  Created by 陈希 on 2022/2/22.
//

import SwiftUI

struct MomentsView: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var momentsVM: MomentsViewModel
    
    @State private var isShowMomentEditorView = false
    @State private var isShowConfirmDialog = false
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(momentsVM.moments) { moment in
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
            MomentsView()
                .environmentObject(MomentsViewModel())
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
