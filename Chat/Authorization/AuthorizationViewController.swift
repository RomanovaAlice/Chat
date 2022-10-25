//
//  AuthorizationViewController.swift
//  Chat
//
//  Created by Алиса Романова on 25.10.2022.
//

import SnapKit

protocol AuthorizationDisplayLogic: AnyObject {
    
}


class AuthorizationViewController: UIViewController {
    
    var interactor: AuthorizationBuisnessLogic?
    var router: AuthorizationRoutingLogic?

    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}





//MARK: - AuthorizationDisplayLogic

extension AuthorizationViewController: AuthorizationDisplayLogic {
    
}
