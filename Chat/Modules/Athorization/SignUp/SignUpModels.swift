//
//  SignUpModels.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import Foundation

enum SignUpModels {
   
    enum ModelType {
        
        struct Request {
            enum RequestType {
                case requestRegistration(email: String, password: String)
            }
        }
        
        struct Response {
            enum ResponseType {
                case registerationSucssesful
                case registerationFalure
            }
        }
        
        struct ViewModel {
            enum ViewModelType {
                case registerationSucssesful
                case registerationFalure
            }
        }
    }
}
