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
    
    init() {
        getData()

        addSubscriptions()
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
            let message = Message(id: UUID(), type: .receiver, date: Date(), text: text)
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
    
}
