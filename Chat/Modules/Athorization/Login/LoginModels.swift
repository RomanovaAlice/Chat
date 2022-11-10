//
//  LoginModels.swift
//  Chat
//
//  Created by Алиса Романова on 03.11.2022.
//

import Foundation

enum LoginModels {
   
    enum ModelType {
        
        struct Request {
            enum RequestType {
                case requestLogin(email: String, password: String)
            }
        }
        
        struct Response {
            enum ResponseType {
                case loginSucssesful
                case loginFalure
            }
        }
        
        struct ViewModel {
            enum ViewModelType {
                case loginSucssesful
                case loginFalure
            }
        }
    }
}
