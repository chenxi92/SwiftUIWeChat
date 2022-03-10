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
        GeometryReader { proxy in
            ZStack {
                VStack {
                    Color.black.frame(height: 300)
                    Spacer()
                }
                
                ScrollView {
                    LazyVStack {
                        /// Header style is copy from:
                        /// https://github.com/wxxsw/SwiftUI-WeChat
                        Header()
                            .anchorPreference(key: NavigationPreferenceKey.self, value: .bottom) { [$0] }
                        
                        ForEach(momentsVM.moments) { moment in
                            MomentListRowView(moment: moment)
                        }
                    }
                    .background(Color.white)
                }
            }
            .overlayPreferenceValue(NavigationPreferenceKey.self) { value in
                VStack {
                    GenerateNavigationView(proxy: proxy, value: value)
                    Spacer()
                }
            }
            .ignoresSafeArea(.all, edges: .top)
        }
        .fullScreenCover(isPresented: $isShowMomentEditorView, onDismiss: { isShowConfirmDialog = false }) {
            MomentEditorView()
        }
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("朋友圈")
    }
    
    func GenerateNavigationView(proxy: GeometryProxy, value: [Anchor<CGPoint>]) -> some View {
        let height = proxy.safeAreaInsets.top + 44
        let progress: CGFloat
        
        if let anchor = value.first {
            // proxy[anchor] 作用是得到 anchor 在 proxy 中的相对位置
            // -proxy[anchor].y 为 0 时代表 Header 底部正好在界面顶部的位置
            // 为了与导航栏高度配合，+ height + 20，过渡位置更缓和
            // 最后 / 44 即在 44px 距离内完成隐藏到显示
            progress = max(0, min(1, (-proxy[anchor].y + height + 20) / 44))
        } else {
            // 这种情况是 Header 完全不在界面中，一般也就是滑出屏幕外了
            progress = 1
        }
        
        return CustomNavigationBarView(
            progress: Double(progress),
            isShowConfirmDialog: $isShowConfirmDialog,
            isShowMomentEditorView: $isShowMomentEditorView
        ).frame(height: height)
    }
}

struct Header: View {
    @EnvironmentObject var profileVM: ProfileViewModel

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                Image("moments_background")
                    .resizable()
                    .frame(height: 300)
                    .clipped()
                    .background(Color.purple)
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 20)
            }
            
            HStack(spacing: 5) {
                Spacer()
                
                Text(profileVM.myProfile.name)
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.bold)
                    .shadow(radius: 2)
                
                NavigationLink {
                    ProfileView(profile: profileVM.myProfile)
                } label: {
                    AvatarView(url: URL(string: profileVM.myProfile.icon)!, height: 65, width: 65)
                }
            }
            .padding(.trailing)
            .padding(.bottom, 12)
        }
    }
}

struct CustomNavigationBarView: View {
    let progress: Double
    @Binding var isShowConfirmDialog: Bool
    @Binding var isShowMomentEditorView: Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Rectangle()
                .background(.regularMaterial)
                .opacity(progress)
                .foregroundColor(Color.gray.opacity(0.5).opacity(progress))
            
            HStack {
                BackButton()
                Spacer()
                Image(systemName: progress > 0.4 ? "camera" : "camera.fill")
                    .foregroundColor( progress > 0.4 ? .primary : .white)
                    .onTapGesture {
                        isShowConfirmDialog = true
                    }
                    .onLongPressGesture {
                        isShowMomentEditorView = true
                    }
            }
            .accentColor(Color(white: colorScheme == .light ? 1 - progress : 1))
            .frame(height: 44)
            .padding(.horizontal)
            
            Text("朋友圈")
                .font(.system(size: 16, weight: .semibold))
                .opacity(progress)
                .frame(height: 44, alignment: .center)
        }
        .frame(maxWidth: .infinity)
    }
}

struct NavigationPreferenceKey: PreferenceKey {
    static var defaultValue: [Anchor<CGPoint>] = []
    static func reduce(value: inout [Anchor<CGPoint>], nextValue: () -> [Anchor<CGPoint>]) {
        value.append(contentsOf: nextValue())
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
