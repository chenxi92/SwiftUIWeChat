//
//  MomentsViewModels.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/7.
//

import SwiftUI

class MomentsViewModel: ObservableObject {
    @Published var moments: [Moment] = [] { didSet { saveData() } }
    
    private let fileName: String = "list"
    private let folderName: String = "moments"
    private let fileManager: LocalFileManager = LocalFileManager.instance
    
    init() {
        self.getData()
    }
    
    // MARK: - Public
    
    public func toogleLike(profile: Profile, in moment: Moment) {
        guard let index = self.moments.firstIndex(where: { $0.id == moment.id }) else {
            return
        }
        self.moments[index].toggleLike(profile: profile)
    }
    
    public func likes(moment: Moment) -> [Profile] {
        guard let index = self.moments.firstIndex(where: { $0.id == moment.id }) else {
            return []
        }
        return self.moments[index].likes
    }
    
    public func addPost(text: String, profile: Profile) {
        let moment = Moment.createMoment(text: text, profile: profile)
        self.moments.insert(moment, at: 0)
    }
    
    public func addComment(text: String, moment: Moment, profile: Profile) {
        if text.isEmpty { return }
        guard let index = self.moments.firstIndex(where: { $0.id == moment.id }) else {
            return
        }
        
        let comment = Comment(profile: profile, text: text)
        self.moments[index].comments.append(comment)
    }
    
    private func getData() {
        if let data = fileManager.getData(fileName: fileName, folderName: folderName) {
            do {
                let moments = try JSONDecoder().decode([Moment].self, from: data)
                self.moments.append(contentsOf: moments)
            } catch {
                print("Get Data Error: \(error)")
            }
        }
        if self.moments.isEmpty {
            moments.append(contentsOf:  Development.shared.moments)
        }
    }
    
    private func saveData() {
        do {
            let data = try JSONEncoder().encode(self.moments)
            fileManager.saveData(data: data, fileName: fileName, folderName: folderName)
        } catch {
            print("Save Data Error: \(error)")
        }
    }
}
