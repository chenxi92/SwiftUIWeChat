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
    
    var body: some View {
        VStack {
            List {
                ForEach(moments) { moment in
                    MomentListRowView(moment: moment)
                    MomentListRowView(moment: moment)
                    MomentListRowView(moment: moment)
                }
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
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

                }
                .onLongPressGesture {

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
