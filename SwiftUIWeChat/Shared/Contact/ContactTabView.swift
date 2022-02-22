//
//  ContactTabView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import SwiftUI

struct ContactTabView: View {
    var body: some View {
        NavigationLink {
            Text("second")
        } label: {
            Text("Hello, Contact!")
        }

    }
}

struct ContactTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContactTabView()
    }
}
