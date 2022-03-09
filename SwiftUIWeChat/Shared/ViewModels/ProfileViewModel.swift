//
//  ProfileViewModel.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/22.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published private(set) var myProfile: Profile
    
    init() {
        myProfile = Profile(
            id: "wxs_1234567x",
            icon: "https://tvax3.sinaimg.cn/crop.0.0.996.996.180/007bF1bmly8gw5muzf5y6j30ro0rodh0.jpg",
            name: "陈希",
            region: "中国 北京",
            personalSign: "已婚",
            gender: .male
        )
    }
    
    
}
