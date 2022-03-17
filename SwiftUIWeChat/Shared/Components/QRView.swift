//
//  QRView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/17.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRView: View {
    let qrCode: String
    var size: CGSize = CGSize(width: 200, height: 200)
    
    @State private var image: UIImage?
    
    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .interpolation(.none)
                    .frame(width: size.width, height: size.height)
            }
        }
        .onAppear {
            generateImage()
        }
    }
    
    private func generateImage() {
        guard image == nil else { return }
        
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(qrCode.utf8)
        
        guard let outputImage = filter.outputImage, let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return
        }
        
        self.image = UIImage(cgImage: cgImage)
    }
}

struct QRView_Previews: PreviewProvider {
    static var previews: some View {
        QRView(qrCode: "https://google.com")
    }
}
