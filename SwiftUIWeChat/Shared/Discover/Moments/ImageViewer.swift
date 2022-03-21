//
//  ImageViewer.swift
//  SwiftUIWeChat
//
//  Created by 陈希 on 2022/3/19.
//

import SwiftUI

/// An wrapper to view images
/// Inspire by: https://www.youtube.com/watch?v=XDH1KmI86b0&t=171s
///
struct ImageViewer: View {
    @EnvironmentObject var momentsVM: MomentsViewModel
    var body: some View {
        ZStack {
            if !momentsVM.browseImages.isEmpty {
                backgroundView
                pageTabView
            }
        }
        .gesture(dragGesture)
        .transition(.move(edge: .bottom))
    }
    
    var backgroundView: some View {
        Color
            .black
            .opacity(momentsVM.opaticy)
            .ignoresSafeArea()
    }
    
    var pageTabView: some View {
        TabView(selection: $momentsVM.selectedImageID) {
            ForEach(momentsVM.browseImages, id: \.self) { urlString in
                CachedAsyncImage(url: URL(string: urlString)!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .tag(urlString)
                        .scaleEffect(imageScale(for: urlString))
                        .offset(y: momentsVM.dragOffset.height)
                        .gesture(magnificationAndDoubleTapGesture)
                } placeholder: {
                    ProgressView()
                }
            }
        }
        .tabViewStyle(.page)
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                momentsVM.dragOffset = gesture.translation
                let progress = abs(gesture.translation.height) / (UIScreen.main.bounds.height * 0.5)
                withAnimation {
                    momentsVM.opaticy = Double(1 - progress)
                }
            }
            .onEnded { gestue in
                withAnimation(.easeInOut) {
                    let height = abs(gestue.translation.height)
                    if height > 250 {
                        momentsVM.browseImages = []
                    }
                    momentsVM.dragOffset = .zero
                    momentsVM.opaticy = 1
                }
            }
    }
    
    var magnificationAndDoubleTapGesture: some Gesture {
        MagnificationGesture()
            .onChanged { gesture in
                momentsVM.imageScale = gesture
            }
            .onEnded { _ in
                momentsVM.imageScale = 1
            }
            .simultaneously(with: doubleTapGesture)
    }
    
    var doubleTapGesture: some Gesture {
        TapGesture(count: 2)
            .onEnded { _ in
                withAnimation(.easeInOut) {
                    momentsVM.imageScale = (momentsVM.imageScale > 1) ? 1 : 4
                }
            }
    }
    
    private func imageScale(for urlString: String) -> CGFloat {
        if momentsVM.selectedImageID == urlString {
            return momentsVM.imageScale
        }
        return 1
    }
}

struct ImageViewer_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewer()
            .environmentObject(MomentsViewModel())
    }
}
