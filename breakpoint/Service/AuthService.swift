//
//  AuthService.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 5/1/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
    
    static let instance = AuthService()
    
    
    
    func registerUser(byEmail email: String, password: String, handler: @escaping (_ status: Bool, _ err: Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, err) in
//            debugPrint(authResult)
//            debugPrint(err)
            guard authResult == authResult, let user = authResult?.user else {
                handler(false, err)
                return
            }
            
            let userData = ["provider": user.providerID, "email": user.email!]
            
            DataService.instance.createUser(uid:user.uid, userData: userData)
            
            handler(true, nil)
        }
        
    }
    
    
    func loginUser(byEmail email: String, password: String, handler: @escaping (_ status: Bool, _ err: Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, err) in
            guard authResult == authResult else {
                handler(false, nil)
                return
            }
            
            handler(true, nil)
        }
        
    }
}
