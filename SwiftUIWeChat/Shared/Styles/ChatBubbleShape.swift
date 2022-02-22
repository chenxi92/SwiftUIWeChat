//
//  ChatBubbleShape.swift
//  SwiftUIWeChat
//
//  Created by 陈希 on 2022/2/20.
//

import SwiftUI

/// Reference URL:
///
/// https://prafullkumar77.medium.com/swiftui-creating-a-chat-bubble-like-imessage-using-path-and-shape-67cf23ccbf62
///
/// https://betterprogramming.pub/cgaffinetransforms-arcs-and-quad-curves-in-swiftui-41e1dbfe6161


struct ChatBubbleShape: Shape {
    let cornerRadius: CGFloat
    let arrowHeight: CGFloat
    let arrowEdge: Edge
    
    init(cornerRadius: CGFloat = 8, arrowEdge: Edge = .trailing, arrowHeight: CGFloat = 8) {
        self.cornerRadius = cornerRadius
        self.arrowEdge = arrowEdge
        self.arrowHeight = arrowHeight
    }
    
    func path(in rect: CGRect) -> Path {
        var rect = rect
        var fit: ((CGPoint) -> (CGPoint)) = { point in return point }
        let arrow: CGSize = CGSize(width: (arrowHeight/811)*2000, height: arrowHeight)
        
        var clockwise = false
        var arc1 = (start: Angle.radians(-.pi*0.5), end: Angle.radians(.pi*0.0))
        var arc2 = (start: Angle.radians(.pi*0.0),  end: Angle.radians(.pi*0.5))
        var arc3 = (start: Angle.radians(.pi*0.5),  end: Angle.radians(.pi*1.0))
        var arc4 = (start: Angle.radians(.pi*1.0),  end: Angle.radians(-.pi*0.5))
        
        if arrowEdge == .leading || arrowEdge == .trailing {
            clockwise = true
            rect = CGRect(x: rect.origin.y, y: rect.origin.x, width: rect.height, height: rect.width)
            fit = { point in return CGPoint(x: point.y, y: point.x)}
            let newArc1 = (arc3.end, arc3.start)
            let newArc2 = (arc2.end, arc2.start)
            let newArc3 = (arc1.end, arc1.start)
            let newArc4 = (arc4.end, arc4.start)
            arc1 = newArc1; arc2 = newArc2; arc3 = newArc3; arc4 = newArc4
        }
        
        let arrowStartX = cornerRadius * 3
        let startX = arrowStartX + arrow.width * 0.5;
        
        var path = Path()
        
        // Move to beginning of Arc 1
        path.move(to: fit(CGPoint(x: startX, y: arrow.height)) )

        // Step 1 (arc1)
        path.addArc(center: fit(CGPoint(x: rect.width - cornerRadius, y: cornerRadius + arrow.height)),
                    radius: cornerRadius,
                    startAngle: arc1.start,
                    endAngle: arc1.end,
                    clockwise: clockwise )
        // Step 2 (arc2)
        path.addArc(center: fit(CGPoint(x: rect.width - cornerRadius, y: rect.height - cornerRadius)),
                    radius: cornerRadius,
                    startAngle: arc2.start,
                    endAngle: arc2.end,
                    clockwise: clockwise )
        // Step 3 (arc3)
        path.addArc(center: fit(CGPoint(x: cornerRadius, y: rect.height - cornerRadius)),
                    radius: cornerRadius,
                    startAngle: arc3.start,
                    endAngle: arc3.end,
                    clockwise: clockwise )
        // Step 4 (arc4)
        path.addArc(center: fit(CGPoint(x: cornerRadius, y: cornerRadius + arrow.height)),
                    radius: cornerRadius,
                    startAngle: arc4.start,
                    endAngle: arc4.end,
                    clockwise: clockwise )

        
        // arrow points where x = distance from arrow center, y = distance from top of rect
        let apex = CGPoint(x: arrow.width*0.5*0.000, y: -arrow.height*0.1456)
        let peak = CGPoint(x: arrow.width*0.5*0.149, y: arrow.height*0.0864)
        let curv = CGPoint(x: arrow.width*0.5*0.600, y: arrow.height*0.7500)
        let ctrl = CGPoint(x: arrow.width*0.5*0.750, y: arrow.height*1.0000)
        let base = CGPoint(x: arrow.width*0.5*1.000, y: arrow.height*1.0000)
        
       
        // Step 5
        path.addLine(to: fit(CGPoint(x: arrowStartX - base.x, y: base.y)))

        // Step 6
        path.addQuadCurve(to: fit(CGPoint(x: arrowStartX - curv.x, y: curv.y)),
                          control: fit(CGPoint(x: arrowStartX - ctrl.x, y: ctrl.y)))

        // Step 7
        path.addLine(to: fit(CGPoint(x: arrowStartX - peak.x, y: peak.y)))

        // Step 8
        path.addQuadCurve(to: fit(CGPoint(x: arrowStartX + peak.x, y: peak.y)),
                          control: fit(CGPoint(x: rect.midX + apex.x, y: apex.y)))

        // Step 9
        path.addLine(to: fit(CGPoint(x: arrowStartX + curv.x, y: curv.y)))

        // Step 10
        path.addQuadCurve(to: fit(CGPoint(x: arrowStartX + base.x, y: base.y)),
                          control: fit(CGPoint(x: rect.midX + ctrl.x, y: ctrl.y)))

        var transform = CGAffineTransform(scaleX: 1, y: 1)
        let bounds = path.boundingRect
        if arrowEdge == .trailing {
            // flip horizontally
            transform = CGAffineTransform(scaleX: -1, y: 1)
            transform = transform.translatedBy(x: -bounds.width, y: 0)
        }
        if arrowEdge == .bottom {
            // flip vertically
            transform = CGAffineTransform(scaleX: 1, y: -1)
            transform = transform.translatedBy(x: 0, y: -bounds.height)
        }
        return path.applying(transform)
    }
}


struct TestMessageView: View {
    let text: String
    let edge: Edge
    let width: CGFloat
    let scale: CGFloat = 0.85
    
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
                AvatarView(url: URL(string: "https://tvax4.sinaimg.cn/crop.0.0.996.996.180/895773a3ly8go4vm65cxdj20ro0ro76d.jpg")!)
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
            
            if edge == .trailing {
                AvatarView(url: URL(string: "https://tvax4.sinaimg.cn/crop.0.0.996.996.180/895773a3ly8go4vm65cxdj20ro0ro76d.jpg")!)
            } else {
                EmptyView()
            }
        }
    }
}


let texts: [String] = [
    "TabView is a container view.",
    "This week we will talk about creating tabs and pager views in SwiftUI.",
    "TabView is a container view that puts children views into separated tabs. Let’s start with a quick example.",
    "TabView gained superpower during WWDC20. We can now use it across all the Apple platforms to build tabbed and paged user experiences with SwiftUI out of the box.",
    "TabView is a container view.",
    "This week we will talk about creating tabs .",
    "TabView is a container view that puts children views into separated tabs. Let’s start with a quick example.",
    "TabView gained superpower during WWDC20. We can now use it across all the Apple platforms to build tabbed and paged user experiences with SwiftUI out of the box."
]
struct ChatBubbleShape_Previews: PreviewProvider {
    static var previews: some View {
        
        GeometryReader { reader in
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(texts, id: \.self) { text in
                        TestMessageView(text: text, edge: .leading, width: reader.size.width)
                        
                        TestMessageView(text: text, edge: .trailing, width: reader.size.width)
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
