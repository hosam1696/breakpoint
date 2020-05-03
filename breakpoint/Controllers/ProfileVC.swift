//
//  ThirdViewController.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 4/30/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import UIKit
import Firebase


class ProfileVC: UIViewController {

    @IBOutlet weak var userEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            userEmail.text = currentUser?.email
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onLogout(_ sender: Any) {
        
        let alert = Helpers.presentBasicActionSheet(title: "Notice!", message: "Are you Sure you want to logout from the app?", actionCb: {
            
            do {
                try Auth.auth().signOut()
                let signUpMethodsVc = self.storyboard?.instantiateViewController(identifier: Identifiers.SignupMethodVC.rawValue) as? SignupMethodVC
                signUpMethodsVc?.modalPresentationStyle = .fullScreen
                self.present(signUpMethodsVc!, animated: true)
            } catch {
                    print(error)
            }
            
            
        })
            
        present(alert, animated: true)
        
        
    }
}
