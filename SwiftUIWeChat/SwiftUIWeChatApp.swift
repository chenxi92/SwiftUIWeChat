//
//  SwiftUIWeChatApp.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import SwiftUI

@main
struct SwiftUIWeChatApp: App {
    @StateObject var chatVM = ChatViewModel()
    @StateObject var contactsVM = ContactsViewModel()
    @StateObject var momentsVM = MomentsViewModel()
    @StateObject var profileVM = ProfileViewModel()
    
    init() {
        if #available(iOS 15.0, *) {
            // 避免 iOS15 的默认行为导致 NavigationBar 没有背景色
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithDefaultBackground()
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            
            // 避免 iOS15 的默认行为导致 TabBar 没有背景色
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            
            // 避免 iOS15 增加的列表顶部空白
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(chatVM)
                .environmentObject(contactsVM)
                .environmentObject(momentsVM)
                .environmentObject(profileVM)
        }
    }
}
