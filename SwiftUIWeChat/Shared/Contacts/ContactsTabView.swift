//
//  ContactsTabView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import SwiftUI

struct ContactsTabView: View {
    
    @State private var isAddContacts: Bool = false
    
    var body: some View {
        List {
            ForEach(Development.shared.contacts, id: \.self) { profile in
                contactListRow(profile: profile)
            }
        }
        .listStyle(.plain)
    }
    
    func contactListRow(profile: Profile) -> some View {
        CustomLinkRow {
            HStack {
                Image(profile.icon)
                    .resizable()
                    .frame(width: 44, height: 44, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal, 10)
                
                Text(profile.name)
                    .font(.body)
            }
        } destination: {
            Text("xxx")
        }
    }
}


struct ContactTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsTabView()
    }
}
