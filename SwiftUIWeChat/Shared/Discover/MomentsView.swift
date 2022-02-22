//
//  MomentsView.swift
//  SwiftUIWeChat
//
//  Created by 陈希 on 2022/2/22.
//

import SwiftUI

struct MomentsView: View {
    var body: some View {
        List {
            ForEach(1...20, id: \.self) { number in
                Text("\(number)").padding()
            }
        }
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "camera")
                    .onTapGesture {
                        
                    }
                    .onLongPressGesture {
                        
                    }
            }
        }
    }
}

struct MomentsView_Previews: PreviewProvider {
    static var previews: some View {
        MomentsView()
    }
}
