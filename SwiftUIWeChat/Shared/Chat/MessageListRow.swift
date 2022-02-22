//
//  MessageListRow.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/22.
//

import SwiftUI

struct MessageListRow: View {
    let iconURLString: String
    let text: String
    let edge: Edge
    let width: CGFloat
    let scale: CGFloat = 0.85
    @Binding var tapedMessage: DoubleTapedMessage?
    
    var body: some View {
        if edge == .leading {
            HStack(alignment: .top, spacing: 0) {
                content
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.vertical, 5)
            .padding(.trailing, width * (1 - scale))
        } else {
            HStack(alignment: .top) {
                Spacer()
                content
            }
            .padding(.trailing, 10)
            .padding(.vertical, 5)
            .padding(.leading, width * (1 - scale))
        }
    }
    
    var content: some View {
        HStack(alignment: .top, spacing: 0) {
            if edge == .leading {
                NavigationLink {
                    MessageDetailView()
                } label: {
                    AvatarView(url: URL(string: iconURLString)!)
                }
            }
            
            Text(text)
                .padding(.vertical, 5)
                .padding(.leading, edge == .leading ? 20 : 10)
                .padding(.trailing, edge == .leading ? 10 : 20)
                .frame(minHeight: 40)
                .background(edge == .leading ? Color.white : Color.green)
                .clipShape(
                    ChatBubbleShape(arrowEdge: edge)
                )
                .padding(.horizontal, 10)
                .onTapGesture(count: 2) {
                    tapedMessage = DoubleTapedMessage(text: text)
                }
            
            if edge == .trailing {
                NavigationLink {
                    MessageDetailView()
                } label: {
                    AvatarView(url: URL(string: iconURLString)!)
                }
            }
        }
    }
}



struct MessageListRow_Previews: PreviewProvider {
    
    static let texts: [String] = [
        "TabView is a container view.",
        "This week we will talk about creating tabs and pager views in SwiftUI.",
        "TabView is a container view that puts children views into separated tabs. Let’s start with a quick example.",
        "TabView gained superpower during WWDC20. We can now use it across all the Apple platforms to build tabbed and paged user experiences with SwiftUI out of the box.",
        "TabView is a container view.",
        "This week we will talk about creating tabs .",
        "TabView is a container view that puts children views into separated tabs. Let’s start with a quick example.",
        "TabView gained superpower during WWDC20. We can now use it across all the Apple platforms to build tabbed and paged user experiences with SwiftUI out of the box."
    ]

    static let iconURLString = ""
    
    static var previews: some View {
        GeometryReader { reader in
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(texts, id: \.self) { text in
                        MessageListRow(
                            iconURLString: iconURLString,
                            text: text,
                            edge: .leading,
                            width: reader.size.width,
                            tapedMessage: .constant(nil)
                        )
                        
                        MessageListRow(
                            iconURLString: iconURLString,
                            text: text,
                            edge: .trailing,
                            width: reader.size.width,
                            tapedMessage: .constant(nil)
                        )
                    }
                }
            }
            .background(
                .black.opacity(0.1)
            )
            .padding(.vertical)
            .ignoresSafeArea()
        }
    }
}
