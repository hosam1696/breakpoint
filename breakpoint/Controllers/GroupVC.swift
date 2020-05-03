//
//  GroupVC.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 5/2/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import UIKit
import Firebase

class GroupVC: UIViewController {
    
    @IBOutlet weak var groupTitle: UILabel?
    @IBOutlet weak var emails: UILabel?
    
    @IBOutlet weak var footer: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageInput: UITextField!
    var group: Group?
    
    var groupMessages: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if group != nil {
            groupTitle?.text = group?.title
            emails?.text = group?.members.joined(separator: ", ")
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(GroupVC.onTapOnTableView)))
        messageInput.inputAccessoryView = footer
        messageInput.delegate = self
        getMessages()
        
    }
    
    func setupView(group: Group) {
        self.group = group
    }
    
    @objc func onTapOnTableView() {
        print("On Tap on table")
        self.view.endEditing(true)
//        messageInput.resignFirstResponder()
    }
 
    func getMessages() {
        if group != nil {
            DataService.instance.getGroupMessages(byId: (group?.id)!) { (messages) in
                if messages != nil {
                    self.groupMessages = messages!
                    self.tableView.reloadData()
                    
                    if self.groupMessages.count > 3 {
                        self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .top, animated: true)
                    }
                    
                }
            }
        }
    }
    
    @IBAction func onBackBtnPressed(_ sender: Any) {

        messageInput.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
    }

    @IBAction func onSendBtnPressed(_ sender: Any) {
        
        if !messageInput.text!.isEmpty && messageInput.text != nil {
            DataService.instance.createNewPost(withMessage: messageInput.text!, forId: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.id, handler: { status in
                print(status)
                if status == true {
                    self.messageInput.text = ""
//                    self.messageInput.resignFirstResponder()
                    if self.groupMessages.count > 3 {
                        self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .top, animated: true)
                    }
                }
            })
        } else {
            print("message is empty")
        }
        
    }
    
}



extension GroupVC: UITextFieldDelegate {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch ended")
        self.view.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}


extension GroupVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tableCell = Bundle.main.loadNibNamed(Identifiers.FeedsPostTableViewCell.rawValue, owner: self, options: nil)?.first as? FeedsPostTableViewCell else {
            return UITableViewCell()
        }
        
        tableCell.setupData(post: groupMessages[indexPath.row])
        return tableCell
    }
    
    
}
