//
//  AvatarView.swift
//  SwiftUIWeChat
//
//  Created by 陈希 on 2022/2/20.
//

import SwiftUI

struct AvatarView: View {
    let url: URL
    var height: CGFloat = 44
    var width: CGFloat = 44
    
    var body: some View {
        
        CachedAsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .transition(.scale(scale: 0.4, anchor: .center))
            case .failure:
                Image(systemName: "wifi.slash")
            @unknown default:
                EmptyView()
            }
        }
        
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(url: URL(string: "https://tvax1.sinaimg.cn/crop.0.0.1080.1080.180/45815d3aly8gmo7ghzz4ij20u00u0djl.jpg")!)
    }
}
