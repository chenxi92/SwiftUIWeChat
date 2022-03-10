//
//  Profile.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/22.
//

import Foundation

enum Gender: Int, Codable, Hashable {
    case male
    case female
}

struct Profile: Codable, Hashable, Identifiable {
    let id: String
    let icon: String
    let name: String
    let region: String
    let personalSign: String?
    let gender: Gender
}

@resultBuilder
struct ProfileArrayBuilder {
    static func buildBlock(_ components: Profile...) -> [Profile] {
        components
    }
    static func buildOptional(_ component: [Profile]?) -> [Profile] {
        component ?? []
    }
    static func buildEither(first component: [Profile]) -> [Profile] {
        component
    }
    static func buildEither(second component: [Profile]) -> [Profile] {
        component
    }
}

extension Profile {
    static func build(@ProfileArrayBuilder _ content: () -> [Profile]) -> [Profile] {
        return content()
    }
    
    static let all: [Profile] = Profile.build {
        Profile(
            id: "wb_1234567890",
            icon: "https://tvax3.sinaimg.cn/crop.0.0.750.750.180/c67b8c76ly8fgbvbu2cszj20ku0kujsq.jpg",
            name: "吃货少女侃侃",
            region: "北京 西城区",
            personalSign: "世界和平",
            gender: .female
        )
        
        Profile(
            id: "wb_1234567891",
            icon: "https://tvax4.sinaimg.cn/crop.0.0.512.512.180/008pTQgply8gvjddp01qdj60e80e8dg302.jpg",
            name: "Resistu",
            region: "美国",
            personalSign: nil,
            gender: .male
        )
        
        Profile(
            id: "wb_1234567892",
            icon: "https://tvax4.sinaimg.cn/crop.0.0.996.996.180/895773a3ly8go4vm65cxdj20ro0ro76d.jpg",
            name: "董叔",
            region: "南京",
            personalSign: nil,
            gender: .male
        )
        
        Profile(
            id: "wb_1234567893",
            icon: "https://tvax4.sinaimg.cn/crop.0.0.996.996.180/895773a3ly8go4vm65cxdj20ro0ro76d.jpg",
            name: "文艺青年",
            region: "安道尔",
            personalSign: "",
            gender: .male
        )
        
        Profile(
            id: "wb_1234567894",
            icon: "https://tvax2.sinaimg.cn/crop.0.0.512.512.180/ec9ba1e1ly8go9t6knmhnj20e80e8glz.jpg",
            name: "英国报姐",
            region: "伦敦",
            personalSign: "🌞🌞🌞🌞🌞",
            gender: .female
        )
        
        Profile(
            id: "wb_1234567895",
            icon: "https://tvax3.sinaimg.cn/crop.0.0.512.512.180/eb0750cdly8gecc4ntmoqj20e80e8q32.jpg",
            name: "扒圈王子",
            region: "苏州",
            personalSign: nil,
            gender: .male
        )
        
        Profile(
            id: "wb_1234567896",
            icon: "https://tvax1.sinaimg.cn/crop.0.0.1080.1080.180/45815d3aly8gmo7ghzz4ij20u00u0djl.jpg",
            name: "知名夺笋少年",
            region: "天津",
            personalSign: "好好学习，天天向上",
            gender: .male
        )
        
        Profile(
            id: "wb_1234567897",
            icon: "https://tvax3.sinaimg.cn/crop.0.0.1080.1080.180/006pz9M8ly8gsenc2ndeoj30u00u0tbc.jpg",
            name: "饭圈安利娘",
            region: "北京",
            personalSign: "哈哈哈哈😄",
            gender: .female
        )
        
        Profile(
            id: "wb_1234567898",
            icon: "https://tvax3.sinaimg.cn/crop.0.0.995.995.180/005zSWdkly8ggjo9480bnj30rn0rnwgt.jpg",
            name: "资深吃瓜姐妹",
            region: "广州",
            personalSign: "吃瓜群众。。。",
            gender: .female
        )
        
        Profile(
            id: "wb_1234567899",
            icon: "https://tvax3.sinaimg.cn/crop.0.0.663.663.180/006VsWdVly8gyp42jhd58j30if0if0tc.jpg",
            name: "美食",
            region: "广州",
            personalSign: "探索地道美食",
            gender: .male
        )
    }
    
}
