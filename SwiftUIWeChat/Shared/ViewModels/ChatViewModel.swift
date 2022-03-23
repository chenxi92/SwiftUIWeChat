//
//  ChatViewModel.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import Foundation
import SwiftUI
import Combine

class ChatViewModel: ObservableObject {
    @Published var chats: [Chat] = [] { didSet { saveData() } }
    
//    public var sortedChats: [Chat] {
//        return chats.sorted { $0.lastUpdateTime > $1.lastUpdateTime }
//    }
    
    @Published var searchText: String = ""
    @Published private(set) var suggestedSearches: [Chat] = []
    private var cancelables = Set<AnyCancellable>()
    
    private let fileName: String = "list"
    private let folderName: String = "chat"
    private let fileManager: LocalFileManager = LocalFileManager.instance
    
    @Published var recordTime: Int = 0
    private var audioRecordTimer: Timer? = nil
    
    @Published var isRecording: Bool = false
    @Published var isDragLeading: Bool = false
    @Published var isDragTrailing: Bool = false
    @Published var isDragRelease: Bool = true
    
    private var currentRecordingChat: Chat? = nil
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    init() {
        audioRecorder = AudioRecorder()
        
        getData()

        addSubscriptions()
        
        applyAudioChange()
    }
    
    /// In sandbox audio file may chages when relaunch the app
    private func applyAudioChange() {
        for recording in audioRecorder.recordingList {
            if let i = chats.firstIndex(where: { $0.id == recording.chatId }) {
                if let j = chats[i].messages.firstIndex(where: { $0.id == recording.messageId }) {
                    print("begin chage audio url from:\n\(chats[i].messages[j].audioURL!)\nto->\n\(recording.fileURL)")
                    chats[i].messages[j].audioURL = recording.fileURL
                }
            }
        }
    }
    
    private func getData() {
        if let data = fileManager.getData(fileName: fileName, folderName: folderName) {
            do {
                let chats = try JSONDecoder().decode([Chat].self, from: data)
                self.chats.append(contentsOf: chats)
            } catch {
                print("Get Chat Data Error: \(error)")
            }
        }
        
        if self.chats.isEmpty {
            self.loadChatData()
        }
    }
    
    /// use mock data
    private func loadChatData() {
        guard let url = Bundle.main.url(forResource: "chat", withExtension: "json") else {
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            chats = try decoder.decode([Chat].self, from: data)
        } catch {
            print("Parse Chats Error: \(error)")
        }
    }
    
    private func saveData() {
        do {
            let data = try JSONEncoder().encode(self.chats)
            fileManager.saveData(data: data, fileName: fileName, folderName: folderName)
        } catch {
            print("Save Chats Data Error: \(error)")
        }
    }
    
    private func addSubscriptions() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] returnedValue in
                self?.doSearch(text: returnedValue)
            }
            .store(in: &cancelables)
    }
    
    private func doSearch(text: String) {
        suggestedSearches = chats.filter { chat in
            let contain = chat.profile.name.contains(text)
            return contain
        }
    }
    
    func chatDelete(chat: Chat) {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            chats.remove(at: index)
            print("delete chat in \(index)")
        }
    }
    
    func chatDelete(profile: Profile) {
        if let index = chats.firstIndex(where: { $0.profile.id == profile.id }) {
            chatDelete(chat: chats[index])
        }
    }
    
    func chatToggleRead(chat: Chat) {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            chats[index].readToggle()
        }
    }
    
    func chatToggleVisible(chat: Chat) {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            chats[index].visiableToggle()
        }
    }
    
    func sendMessage(_ text: String, chat: Chat) -> Message? {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            let message = Message(text: text)
            chats[index].messages.append(message)
            return message
        }
        return nil
    }
    
    @discardableResult
    func sendAudio(_ recording: Recording, chat: Chat) -> Message? {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            let message = Message(recording: recording)
            chats[index].messages.append(message)
            return message
        }
        return nil
    }
    
    func sendImage(_ imageURL: URL, chat: Chat) -> Message? {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            let message = Message(imageURL: imageURL)
            chats[index].messages.append(message)
            return message
        }
        return nil
    }
    
    func chat(for profile: Profile) -> Chat {
        guard let index = chats.firstIndex(where: { $0.profile.id == profile.id }) else {
            let chat = Chat.create(profile: profile)
            chats.insert(chat, at: 0)
            return chat
        }
        return chats[index]
    }
}

// MARK: - Chat

extension ChatViewModel {
    
    func startRecord(chat: Chat) {
        currentRecordingChat = chat
        isRecording = true
        
        audioRecorder.startRecording(chat: chat)
        
        audioRecordTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.recordTime += 1
        }
    }
    
    func stopRecord() {
        isRecording = false
        
        resetRecord()
        
        if let recording = audioRecorder.stopRecording(), let chat = currentRecordingChat {
            sendAudio(recording, chat: chat)
        }
    }
    
    func deleteRecord() {
        isRecording = false
        
        audioRecorder.deleteRecording()
        
        resetRecord()
    }
    
    func updateCurrentLocaltion(location: CGPoint) {
        let height = UIScreen.main.bounds.size.height
        if height - location.y < 250 {
            isDragRelease = true
            isDragLeading = false
            isDragTrailing = false
            return
        }
        
        isDragRelease = false
        let width = UIScreen.main.bounds.size.width * 0.5
        isDragLeading = location.x < width
        isDragTrailing = location.x > width
    }
    
    func getRocording(from audioFile: URL) -> Recording? {
        audioRecorder.recordingList.first(where: { $0.fileURL == audioFile })
    }
    
    private func resetRecord() {
        audioRecordTimer?.invalidate()
        recordTime = 0
        
        isDragRelease = true
        isDragLeading = false
        isDragTrailing = false
    }
    
}
