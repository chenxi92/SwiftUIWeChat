//
//  ExpandableText.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/21.
//

import SwiftUI

struct ExpandableText: View {
    @State private var expanded: Bool = false
    @State private var truncated: Bool = false
    @State private var shrinkText: String
    private var text: String
    let font: UIFont
    let lineLimit: Int
    
    init(_ text: String, lineLimit: Int = 3, font: UIFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)) {
        self.text = text
        self.lineLimit = lineLimit
        _shrinkText =  State(wrappedValue: text)
        self.font = font
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(self.expanded ? text : shrinkText)
                .animation(.easeInOut, value: expanded)
                .lineLimit(expanded ? nil : lineLimit)
                .background(dummyBackground)
            if truncated {
                Button {
                    expanded.toggle()
                } label: {
                    Text(expanded ? "Show Less": "Show More")
                        .font(.callout)
                }
            }
        }
        .font(Font(font)) ///set default font
    }
    
    var dummyBackground: some View {
        // Render the limited text and measure its size
        Text(text)
            .lineLimit(lineLimit)
            .background(
                GeometryReader { visibleTextGeometry in
                    Color.clear.onAppear() {
                        let size = CGSize(width: visibleTextGeometry.size.width, height: .greatestFiniteMagnitude)
                        let attributes:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font: font]
                        /// Binary search until mid == low && mid == high
                        var low  = 0
                        var heigh = shrinkText.count
                        var mid = heigh
                        while ((heigh - low) > 1) {
                            let attributedText = NSAttributedString(string: shrinkText, attributes: attributes)
                            let boundingRect = attributedText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                            if boundingRect.size.height > visibleTextGeometry.size.height {
                                truncated = true
                                heigh = mid
                                mid = (heigh + low)/2
                            } else {
                                if mid == text.count {
                                    break
                                } else {
                                    low = mid
                                    mid = (low + heigh)/2
                                }
                            }
                            shrinkText = String(text.prefix(mid))
                        }
                    }
                }
            )
            .hidden() // Hide the background
    }
}

struct ExpandableText_Previews: PreviewProvider {
  
    static var previews: some View {
    VStack(alignment: .leading, spacing: 10) {
        ExpandableText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut laborum", lineLimit: 6)
            .background(Color.cyan)
        ExpandableText("Small text", lineLimit: 3)
            .background(Color.mint)
        ExpandableText("Render the limited text and measure its size, R", lineLimit: 1)
            .background(Color.pink)
        ExpandableText("Create a ZStack with unbounded height to allow the inner Text as much, Render the limited text and measure its size, Hide the background Indicates whether the text has been truncated in its display.", lineLimit: 3)
            .background(Color.mint)
    }.padding()
  }
}
