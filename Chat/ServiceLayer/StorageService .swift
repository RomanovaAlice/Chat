//
//  StorageService .swift
//  Chat
//
//  Created by Алиса Романова on 17.11.2022.
//

import FirebaseStorage
import FirebaseAuth

final class StorageService {
    
    private var db = Storage.storage().reference()
    
    private var currentUserId = Auth.auth().currentUser!.uid
    
    func loadUserPhoto(photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = db.child("Avatars")
        
        guard let imageData = photo.jpegData(compressionQuality: 0.4) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        reference.child(currentUserId).putData(imageData, metadata: metadata) { (metadata, error) in
            
            if metadata == nil {
                completion(.failure(SystemError.metadataIsNil))
            }
            
            reference.child(self.currentUserId).downloadURL { (url, error) in
                guard error != nil else {
                    completion(.failure(SystemError.failToDownloadAvatarURL))
                    return
                }
                completion(.success(url!))
            }
        }
    }
}
