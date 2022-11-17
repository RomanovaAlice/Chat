//
//  StorageService .swift
//  Chat
//
//  Created by Алиса Романова on 17.11.2022.
//

import FirebaseStorage
import FirebaseAuth

final class StorageService {
    
    private var avatarsReference: StorageReference {
        return Storage.storage().reference().child("Avatars")
    }
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    func loadUserPhoto(photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = photo.jpegData(compressionQuality: 0.4) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        avatarsReference.child(currentUserId).putData(imageData, metadata: metadata) { (metadata, error) in
            
            if metadata == nil {
                completion(.failure(error!))
            }
            
            self.avatarsReference.child(self.currentUserId).downloadURL { (url, error) in
                guard let downloadURL = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(downloadURL))
            }
        }
    }

}
