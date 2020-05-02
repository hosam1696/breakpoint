//
//  AddPostVCViewController.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 5/1/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import UIKit
import Firebase

class AddPostVC: UIViewController {

    
    @IBOutlet weak var postTextArea: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        postTextArea.inputAccessoryView = sendBtn
        
        postTextArea.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.userEmail.text = Auth.auth().currentUser?.email
   
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func onCloseBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func onSendPressed(_ sender: Any) {
        
        if postTextArea.text != "Type Any thing you want.." && postTextArea.text != "" {
            sendBtn.isEnabled = false
            
            DataService.instance.createNewPost(withMessage: postTextArea.text, forId: Auth.auth().currentUser?.uid ?? "uid", withGroupKey: nil) { (status) in
                if status == true {
                    self.sendBtn.isEnabled = true
                    self.onCloseBtnPressed("")
                } else {
                    self.sendBtn.isEnabled = true
                    print("Something Error")
                }
            }
        } else {
            print("You have to enter a post body")
            let alert = Helpers.presentBasicAlert(title: "Hint", message: "You have to enter post body", actionCb: {})
            
            self.present(alert, animated: true)
        }
        
    }
}


extension AddPostVC: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        postTextArea.text = ""
    }
        
    
}

