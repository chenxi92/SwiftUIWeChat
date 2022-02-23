//
//  CustomLinkRow.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/23.
//

import SwiftUI

struct CustomLinkRow<Content: View, Destination: View>: View {
    let content: () -> Content
    let destination: () -> Destination

    var body: some View {
        ZStack(alignment: .leading) {
            content()
            
            NavigationLink(destination: destination()) {
            }
            .opacity(0)
        }
    }
}

struct CustomLink_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                CustomLinkRow {
                    Text("row content")
                } destination: {
                    Text("row destination")
                }
            }
        }
    }
}
