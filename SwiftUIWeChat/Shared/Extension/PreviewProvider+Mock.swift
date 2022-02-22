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
    
    var chats: [Chat] {
        [
            Chat(
                id: UUID(),
                isRead: true,
                isVisiable: true,
                profile: Profile(
                    id: UUID(),
                    icon: "https://tvax3.sinaimg.cn/crop.0.0.750.750.180/c67b8c76ly8fgbvbu2cszj20ku0kujsq.jpg",
                    name: "吃货少女侃侃",
                    region: "北京 西城区",
                    personalSign: nil,
                    gender: .female
                ),
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
                profile: Profile(
                    id: UUID(),
                    icon: "https://tvax4.sinaimg.cn/crop.0.0.996.996.180/895773a3ly8go4vm65cxdj20ro0ro76d.jpg",
                    name: "文艺青年",
                    region: "安道尔",
                    personalSign: "", gender: .male
                ),
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
}
