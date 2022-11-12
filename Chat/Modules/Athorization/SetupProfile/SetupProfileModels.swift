//
//  SetupProfileModels.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import UIKit

enum SetupProfileModels {
   
    enum ModelType {
        
        struct Request {
            enum RequestType {
                case getUserData(id: String, email: String)
                case createUser(username: String, description: String, sex: String, avatar: UIImage)
            }
        }
        
        struct Response {
            enum ResponseType {

            }
        }
        
        struct ViewModel {
            enum ViewModelType {

            }
        }
    }
}
