//
//  MomentsViewModels.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/7.
//

import SwiftUI

class MomentsViewModel: ObservableObject {
    @Published var moments: [Moment] = []
    
    init() {
        moments.append(contentsOf:  Development.shared.moments)
    }
    
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
}
