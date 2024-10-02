import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                // Ensure there is data and no error
                if let data = data, error == nil, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.image = UIImage.appIcon
                    }
                }
            }
            task.resume() 
        }
}
