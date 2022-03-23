# SwiftUIWeChat
A demo to simulate WeChat, only use SwiftUI.




# Features

- Audio record/play
- Video play
- QR Code
- Image browser
- Async image with cache
- Gesture: Drag, LongPress, Mangification, Tap
- Expandable Text View
- Custom Shape
- Loading Animation


# References

## Reduceing space between sections for grouped list

- [Reduce spacing between sections SwiftUI](https://stackoverflow.com/a/62186463/5972156)

- [Globally Reduce spacing between sections SwiftUI](https://stackoverflow.com/a/68396510/5972156)



## Hiden navigation link Arrow

```swift
ZStack(alignment: .leading) {
    content
    
    NavigationLink(destination: DestinationView() ) {
    
    }
    .opacity(0)
}
```



## FlexibleView

- [Flexible layout in SwiftUI](https://www.fivestars.blog/articles/flexible-swiftui/)

- [How to read a view size in SwiftUI](https://www.fivestars.blog/articles/swiftui-share-layout-information/)
