//
//  MessageDoubleTapView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/22.
//

import SwiftUI

struct DoubleTapedMessage: Identifiable {
    var id: String {
        return text
    }
    
    let text: String
}


struct MessageDoubleTapView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let messageObject: DoubleTapedMessage
    
    var body: some View {
        ZStack {
            Color.primary
                .opacity(0.08)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                Text(messageObject.text)
                    .font(.title)
                    .padding()
                    .padding()
            }
        }
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct MessageDoubleTapView_Previews: PreviewProvider {
    static var previews: some View {
        MessageDoubleTapView(messageObject: DoubleTapedMessage(text: "test message"))
    }
}
