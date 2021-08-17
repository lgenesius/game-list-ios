import SwiftUI
import UIKit

private let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoaderService: ObservableObject {
    @Published var image: UIImage?
    
    var imageCache = _imageCache
    private let urlSession = URLSession.shared
    
    func loadImage(with url: URL) {
        let urlString = url.absoluteString
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        downloadImage(url: url) { [weak self] (data, error) in
            guard let self = self else { return }
            if error == nil {
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
    
    private func downloadImage(url: URL, completion: @escaping (Data?, APIError?) -> Void) {
        
        let task = urlSession.downloadTask(with: url) { [weak self] (localURL, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.executeCompletionInMainThread(data: nil, error: .error, completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                self.executeCompletionInMainThread(data: nil, error: .invalidResponse, completion: completion)
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                self.executeCompletionInMainThread(data: nil, error: .invalidResponse, completion: completion)
                return
            }
            
            guard let localURL = localURL else {
                self.executeCompletionInMainThread(data: nil, error: .invalidEndpoint, completion: completion)
                return
            }
            
            do {
                let data = try Data(contentsOf: localURL)
                self.executeCompletionInMainThread(data: data, error: nil, completion: completion)
            } catch {
                self.executeCompletionInMainThread(data: nil, error: .serializationError, completion: completion)
            }
        }
        
        task.resume()
    }
    
    private func executeCompletionInMainThread(data: Data?, error: APIError?, completion: @escaping (Data?, APIError?) -> Void) {
        completion(data, error)
    }}
