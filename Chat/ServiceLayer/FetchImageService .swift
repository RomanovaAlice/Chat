//
//  FetchImageService .swift
//  Chat
//
//  Created by Алиса Романова on 14.11.2022.
//

import SDWebImage

final class FetchImageService {
    
    func fetchImage(URLString: String, imageView: inout UIImageView) {
        let url = URL(string: URLString)
        
        imageView.sd_setImage(with: url)
    }
}
