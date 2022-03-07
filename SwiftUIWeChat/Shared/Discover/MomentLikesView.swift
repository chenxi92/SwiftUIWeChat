//
//  MomentLikesView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/7.
//

import SwiftUI

struct MomentLikesView: View {
    let moment: Moment
    @EnvironmentObject var momentVM: MomentsViewModel
    
    @State private var totalHeight = CGFloat.infinity
    
    var body: some View {
        Self._printChanges()
        return VStack {
            GeometryReader { geometry in
                generateContent(in: geometry)
                    .background(viewHeightReader($totalHeight))
            }
        }
        .frame(maxHeight: totalHeight)
        .frame(maxWidth: .infinity)
    }
    
    var likes: [Profile] {
        momentVM.likes(moment: moment)
    }
    
    func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(likes.indices) { index in
                let isLast = (index ==  moment.likes.count - 1)
                let profile = moment.likes[index]
                item(profile: profile, isLast: true)
                    .alignmentGuide(.leading) { hd in
                        if abs(width - hd.width) > geometry.size.width {
                            width = 0
                            height -= hd.height
                        }
                        let result = width
                        if isLast {
                            width = 0
                        } else {
                            width -= hd.width
                        }
                        return result
                    }
                    .alignmentGuide(.top) { vd in
                        let result = height
                        if isLast {
                            height = 0
                        }
                        return result
                    }
            }
        }
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
    
    func item(profile: Profile, isLast: Bool) -> some View {
        HStack(spacing: 2) {
            Image(systemName: "heart")
            
            NavigationLink {
                ProfileView(profile: profile)
            } label: {
                Text(profile.name)
                    .font(.system(.body, design: .monospaced))
                    .fontWeight(.bold)
            }

            Text(",")
                .foregroundColor(.primary)
                .opacity(isLast ? 0 : 1)
        }
        .foregroundColor(.blue)
        .padding(.horizontal, 3)
        .padding(.vertical, 3)
    }
}

struct MomentLikesView_Previews: PreviewProvider {
    static var previews: some View {
        MomentLikesView(moment: dev.momment1)
            .environmentObject(MomentsViewModel())
    }
}
