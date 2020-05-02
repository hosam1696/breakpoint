//
//  SignupVC.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 4/30/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var emailText: InsetTextField!
    @IBOutlet weak var passwordText: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    
    // MARK: - Actions
    
    @IBAction func onCloseBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onLoginBtnPressed(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            AuthService.instance.registerUser(byEmail: emailText.text!, password: passwordText.text!) { (status, err) in
                print(status)
                if status == true {
                    self.performSegue(withIdentifier: Segues.TabBar.rawValue, sender: nil)
                } else {
                        AuthService.instance.loginUser(byEmail: self.emailText.text!, password: self.passwordText.text!) { (status, err) in
                            if status == true {
                                self.performSegue(withIdentifier: Segues.TabBar.rawValue, sender: nil)
                            } else {
                                
                                let alert = Helpers.presentBasicAlert(title: "Error!", message: err.debugDescription, actionCb: { })
                                self.present(alert, animated: true)
                            }
                        }
                    
                  
                }
            }
            
        } else {
            
            print("email not filled")
            let alert = Helpers.presentBasicAlert(title: "Hint!", message: "You have to fill your email and password ", actionCb: {})
            
            self.present(alert, animated: true)
        }
        
    }
    
}
