import MapleBacon
import RxSwift
import UIKit


/**
 Responsible for downloading images.
 */
public class ImageService {

    /** The `MapleBacon` image manager instance which we're using for image fetching and caching. */
    private let imageManager = MapleBacon.shared

    /**
     Designated initializer.

     - Parameters:
        - maximumCacheTime:   The maximum storage time of the cached images. (Default: 1 Day)
     */
    public init(maximumCacheTime: TimeInterval = 60 * 60 * 24) {
        imageManager.maxCacheAgeSeconds = maximumCacheTime
    }

    /**
     Get an image for the given `URL`.

     - Parameter url: The image resource url.

     - Returns: An observable `UIImage` instance.
     */
    public func getImage(url: URL) -> Observable<UIImage> {
        return Observable.create { [imageManager] observer in
            let download = imageManager.image(with: url) { (result) in
                switch result {
                case .failure(let error):
                     observer.onError(error)
                case .success(let image):
                    observer.onNext(image)
                }
            }
            return Disposables.create(with: download?.cancel ?? {})
        }
    }
}
