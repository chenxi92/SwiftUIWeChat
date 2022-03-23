//
//  AudioPlayer.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/23.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    
    var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    var audioPlayer: AVAudioPlayer!
    
    func startPlayback(audioFileURL: URL) {
        print("begin play: \(audioFileURL)")
        if FileManager.default.fileExists(atPath: audioFileURL.path) == false {
            print("file not exist: \(audioFileURL.path)")
        }
        
        let playbackSession = AVAudioSession.sharedInstance()
        do {
            try playbackSession.overrideOutputAudioPort(.speaker)
        } catch {
            print("playing over the device's speakers failed: \(error.localizedDescription)")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFileURL)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            isPlaying = true
        } catch {
            print("playback failed: \(error.localizedDescription)")
        }
    }
    
    func stopPlayback() {
        audioPlayer.stop()
        isPlaying = false
    }
}

// MARK: AVAudioPlayerDelegate

extension AudioPlayer {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
            print("did finished playing")
        }
    }
}
