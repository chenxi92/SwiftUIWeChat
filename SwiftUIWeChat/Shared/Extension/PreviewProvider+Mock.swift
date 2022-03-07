//
//  PreviewProvider+Mock.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import SwiftUI
import Foundation

extension PreviewProvider {
    static var dev: Development {
        return Development.shared
    }
}

struct Development {
    static let shared =  Development()
    private init() {}
    
    let profile1: Profile = Profile(
        id: UUID(),
        icon: "https://tvax3.sinaimg.cn/crop.0.0.750.750.180/c67b8c76ly8fgbvbu2cszj20ku0kujsq.jpg",
        name: "吃货少女",
        region: "北京 西城区",
        personalSign: nil,
        gender: .female
    )
    
    let profile2: Profile = Profile(
        id: UUID(),
        icon: "https://tvax4.sinaimg.cn/crop.0.0.996.996.180/895773a3ly8go4vm65cxdj20ro0ro76d.jpg",
        name: "文艺青年",
        region: "安道尔",
        personalSign: "", gender: .male
    )
    
    let profile3: Profile = Profile(
        id: UUID(),
        icon: "https://tvax4.sinaimg.cn/crop.0.0.996.996.180/895773a3ly8go4vm65cxdj20ro0ro76d.jpg",
        name: "无名氏",
        region: "安道尔",
        personalSign: "", gender: .male
    )
    
    var chats: [Chat] {
        [
            Chat(
                id: UUID(),
                isRead: true,
                isVisiable: true,
                profile: profile1,
                messages: [
                    Message(
                        id: UUID(),
                        type: .receiver,
                        date: Date(timeIntervalSince1970: 1582266033),
                        text: "I'm a student at Peking University. I was wondering whether I could be an intern here."
                    ),
                    Message(
                        id: UUID(),
                        type: .sender,
                        date: Date(timeIntervalSince1970: 1582266431),
                        text: "Are you good at writing?"
                    ),
                    Message(
                        id: UUID(),
                        type: .receiver,
                        date: Date(timeIntervalSince1970: 1582266501),
                        text: "Yes, I believe that I am. Here are some samples of my writings. Some of them were published in magazines."
                    ),
                    Message(
                        id: UUID(),
                        type: .sender,
                        date: Date(timeIntervalSince1970: 1586431713),
                        text: "Good. Would you like to be an assistant for one of our editors?"
                    ),
                    Message(
                        id: UUID(),
                        type: .receiver,
                        date: Date(timeIntervalSince1970: 1597836513),
                        text: "Yes, I would love to. Thank you."
                    )
                ]
            ),
            Chat(
                id: UUID(),
                isRead: false,
                isVisiable: false,
                profile: profile2,
                messages: [
                    Message(
                        id: UUID(),
                        type: .sender,
                        date: Date(timeIntervalSince1970: 1644791300),
                        text: "听说中国人的名字都有讲究，是吗?"
                    ),
                    Message(
                        id: UUID(),
                        type: .receiver,
                        date: Date(timeIntervalSince1970: 1644791275),
                        text: "是啊，很多人的名字都有一定的含义，表示一定的愿望。比如男人的名字用“强”表示坚强，女人的名字用“丽”表示美丽。不过现在的名字变化很大。"
                    ),
                    Message(
                        id: UUID(),
                        type: .sender,
                        date: Date(timeIntervalSince1970: 1645144304),
                        text: "梅，你的这个“梅”字有什么含义吗?"
                    ),
                    Message(
                        id: UUID(),
                        type: .receiver,
                        date: Date(timeIntervalSince1970: 1645144882),
                        text: "我是梅花盛开的时候生的，爸爸希望我能像梅花那么漂亮。"
                    ),
                ]
            )
        ]
    }
    
    let contacts: [Profile] = [
        Profile(id: UUID(), icon: "emoji-1", name: "ATest1", region: "中国", personalSign: nil, gender: .male),
        Profile(id: UUID(), icon: "emoji-3", name: "ATest2", region: "北京", personalSign: "xxx", gender: .female),
        Profile(id: UUID(), icon: "emoji-5", name: "CTest", region: "美国", personalSign: nil, gender: .male),
        Profile(id: UUID(), icon: "emoji-7", name: "DTest1", region: "朝鲜", personalSign: nil, gender: .female)
    ]
    
    var likes1: [Profile]  {
        [
            profile2
        ]
    }
    
    var comment1: Comment {
        Comment(profile: profile2, text: "加油⛽️！！！")
    }
    
    var momment1: Moment {
        Moment(
            profile: profile1,
            date: Date(timeIntervalSinceNow: -3600*1),
            text: "Connect with Apple experts through online sessions February 15 to March 29 to learn about the latest App Store features and get your questions answered. Find out how to create product pages that resonate best with the people you’d like to reach, provide great subscription experiences, distribute custom offer codes, and promote your in-app events. Register today if you’re a member of the Apple Developer Program.",
            images: [],
            link: nil,
            likes: [profile1, profile2, profile3],
            comments: [comment1]
        )
    }
    
    var moments: [Moment] {
        [
            momment1
        ]
    }
    
}
