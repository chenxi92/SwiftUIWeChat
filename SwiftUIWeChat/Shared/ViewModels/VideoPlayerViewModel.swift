//
//  VideoPlayerViewModel.swift
//  SwiftUIWeChat
//
//  Created by 陈希 on 2022/3/20.
//

import Foundation
import ARKit

class VideoPlayerViewModel: ObservableObject {
    
    @Published var player: AVPlayer
    @Published var isPlaying: Bool = false
    
    init(urlString: String) {
        self.player = AVPlayer(url: URL(string: urlString)!)
    }
    
    func play() {
        isPlaying = true
        player.play()
    }
    
    func stop() {
        isPlaying = false
        player.pause()
    }
}
