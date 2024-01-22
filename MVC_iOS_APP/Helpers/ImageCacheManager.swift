import Foundation
import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSString, UIImage>()

    private init() {
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 
    }

    func cacheImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    func loadImageFromCache(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func imageExistsInCache(forKey key: String) -> Bool {
        return loadImageFromCache(forKey: key) != nil
    }
}
