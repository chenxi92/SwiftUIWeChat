//
//  BackButton.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/23.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dissmiss
    // @Environment(\.presentationMode) var presentationMode
    
    let foregroundColor: Color
    
    init(foregroundColor: Color = .primary) {
        self.foregroundColor = foregroundColor
    }
    
    var body: some View {
        Button {
            onButtonPress()
        } label: {
            Image(systemName: "chevron.left")
                .padding()
                .foregroundColor(foregroundColor)
        }
    }
    
    func onButtonPress() {
//      presentationMode.wrappedValue.dismiss()
        dissmiss()
    }
}
struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
            .previewLayout(.sizeThatFits)
    }
}
