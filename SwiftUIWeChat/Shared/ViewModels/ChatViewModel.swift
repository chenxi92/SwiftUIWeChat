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
    @Published var chats: [Chat] = []
    
    @Published var searchText: String = ""
    @Published private(set) var suggestedSearches: [Chat] = []
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        /// use mock data
        loadChatData()

        addSubscriptions()
    }
    
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
}

// MARK: - Chat

extension ChatViewModel {
    func chatDelete(chat: Chat) {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            chats.remove(at: index)
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
}
