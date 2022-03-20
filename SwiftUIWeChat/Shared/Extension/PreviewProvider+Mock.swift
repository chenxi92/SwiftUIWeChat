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
    
    let profile1: Profile = Profile.all[0]
    let profile2: Profile = Profile.all[1]
    let profile3: Profile = Profile.all[2]
    let profile4: Profile = Profile.all[3]
    let profile5: Profile = Profile.all[4]
    let profile6: Profile = Profile.all[5]
    
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
    
    var likes1: [Profile]  {
        [
            profile1
        ]
    }
    
    var comment1: Comment {
        Comment(profile: profile1, text: "加油⛽️！！！")
    }
    
    var comment2: Comment {
        Comment(profile: profile2, text: "Hello world")
    }
    
    var moment1: Moment {
        Moment(
            profile: profile1,
            date: Date(timeIntervalSinceNow: 3600 * 5),
            text: "Connect with Apple experts through online sessions February 15 to March 29 to learn about the latest App Store features and get your questions answered. Find out how to create product pages that resonate best with the people you’d like to reach, provide great subscription experiences, distribute custom offer codes, and promote your in-app events. Register today if you’re a member of the Apple Developer Program.",
            images: [],
            link: nil,
            likes: [profile2, profile3, profile4, profile5],
            comments: [comment1],
            videoUrl: nil
        )
    }
    
    var moment2: Moment {
        Moment(
            profile: profile2,
            date: Date(timeIntervalSinceNow: 3600 * 4),
            text: "Apple Developer 🍎",
            images: [],
            link: nil,
            likes: [],
            comments: [],
            videoUrl: nil
        )
    }
    
    var moment3: Moment {
        Moment(
            profile: profile3,
            date: Date(timeIntervalSince1970: 3600 * 3),
            text: nil,
            images: [
                "https://wx4.sinaimg.cn/orj960/007IClG0ly1h0cngmv2x2j30970cq42p.jpg",
            ],
            link: nil,
            likes: [profile1],
            comments: [],
            videoUrl: nil
        )
    }
    
    var moment4: Moment {
        Moment(
            profile: profile4,
            date: Date(timeIntervalSince1970: 3600 * 2),
            text: nil,
            images: [
                "https://wx4.sinaimg.cn/orj960/bf137d83gy1h0avq4jyytj20j60pkq5s.jpg",
                "https://wx4.sinaimg.cn/orj960/004iBqFSly1h0d2hgykm7j60u01uowtn02.jpg"
            ],
            link: nil,
            likes: [profile1],
            comments: [],
            videoUrl: nil
        )
    }
    
    var moment5: Moment {
        Moment(
            profile: profile5,
            date: Date(timeIntervalSince1970: 3600 * 1),
            text: nil,
            images: [
                "https://wx4.sinaimg.cn/orj960/007IClG0ly1h0cngmv2x2j30970cq42p.jpg",
                "https://wx4.sinaimg.cn/orj960/bf137d83gy1h0avq4jyytj20j60pkq5s.jpg",
                "https://wx4.sinaimg.cn/orj960/004iBqFSly1h0d2hgykm7j60u01uowtn02.jpg",
                "https://pic1.zhimg.com/80/v2-ef69b1d331bea5477d138ca0b8f4ba61_720w.jpg",
                "https://pic1.zhimg.com/v2-d41c2ceaed8f51999522f903672a521f_l.jpg",
                "https://wx1.sinaimg.cn/wap720/006YgNWKly1h0bv7k6fqpj30qy0d9q4h.jpg",
                "https://wx2.sinaimg.cn/wap720/006YgNWKly1h0bv7ktdspj30qy0evmy3.jpg",
                "https://wx2.sinaimg.cn/wap720/001iT7gJly3h04n3bvhetj60zg1b91iq02.jpg",
                "https://wx3.sinaimg.cn/wap720/62a39907ly1h09orw8wz0j20n90r0dix.jpg"
            ],
            link: nil,
            likes: [profile1, profile2],
            comments: [],
            videoUrl: nil
        )
    }
    
    var moment6: Moment {
        Moment(
            profile: profile6,
            date: Date(timeIntervalSince1970: 3600 * 1.2),
            text: nil,
            images: [],
            link: nil,
            likes: [profile3, profile4],
            comments: [],
            videoUrl: "https://bit.ly/swswift"
        )
    }
    
    var moments: [Moment] {
        [
            moment1, moment2, moment3, moment4, moment5, moment6
        ]
    }
    
}
