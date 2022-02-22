//
//  ImageLoaderService.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/21.
//

import Foundation
import Combine
import UIKit

enum NetworkingError: LocalizedError {
    case badeURLResponse(url: URL)
    case unknow
    
    var errorDescription: String? {
        switch self {
        case .badeURLResponse(let url):
            return "Bad response form url: \(url)"
        case .unknow:
            return "Unknow error occured"
        }
    }
}

class ImageLoaderService: ObservableObject {
    @Published var image = UIImage()
    
    private var subscription: AnyCancellable?
    private let fileManager = LocalFileManager.instance
    private let folderName = "wechat_icons"
    private let url: URL
    
    init(url: URL) {
        self.url = url
        
        loadImage()
    }
    
    private func loadImage() {
        if let savedImage = fileManager.getImage(imageName: url.absoluteString, folderName: folderName) {
            image = savedImage
        } else {
            downloadImage()
        }
    }
    
    private func downloadImage() {
        subscription = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data: Data, response: URLResponse) -> UIImage? in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                          throw NetworkingError.badeURLResponse(url: self.url)
                      }
                return UIImage(data: data)
            }
            .retry(2)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error download image: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloaded = returnedImage else { return }
                
                self.image = downloaded
                self.subscription?.cancel()
                self.fileManager.saveImage(image: downloaded, imageName: self.url.absoluteString, folderName: self.folderName)
            })
    }
}
