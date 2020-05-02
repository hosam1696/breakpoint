//
//  AddGroupVC.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 5/1/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import UIKit

class AddGroupVC: UIViewController {

    @IBOutlet weak var groupTitle: InsetTextField!
    @IBOutlet weak var groupDescription: InsetTextField!
    @IBOutlet weak var usersSearch: InsetTextField!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    var selectedUsers: [String] = []
    var userEmails: [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        groupTitle.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddGroupVC.onUserSelect), name: .OnUserSelect, object: nil)
        getUsers()
    }
    
    
    private func getUsers() {
        DataService.instance.getAllUsers { (users) in
            if users != nil {
                self.userEmails = users!
                self.tableView.reloadData()
            }
        }
    }
    
    
    @objc func onUserSelect(_ notification: Notification) {
        
        if let data = notification.userInfo as? [String: String] {
            if data["operation"] == "append" {
                selectedUsers.append(data["email"]!)
            } else {
                if let index = selectedUsers.firstIndex(of: data["email"]!) {
                    selectedUsers.remove(at: index)
                }
            }
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

    // MARK: - Actions
    @IBAction func onCreateBtnPressed(_ sender: Any) {
        
        if groupTitle.text != nil && groupTitle.text != "" && groupDescription.text != nil && groupDescription.text != "" {
            DataService.instance.createGroup(title: groupTitle.text!, description: groupDescription.text!, users: selectedUsers) { (status) in
                print(status)
                if status == true {
                    let alert = Helpers.presentBasicAlert(title: "Success", message: "You have Created Group Successfully.", actionCb:{
                        self.dismiss(animated: true, completion: nil)
                    })
                    
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @IBAction func onCloseBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    
    }
}


extension AddGroupVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = Bundle.main.loadNibNamed(Identifiers.UserCell.rawValue, owner: self, options: nil)?.first as? UserCellTableViewCell  else {
            return UITableViewCell()
        }
    
        print(userEmails[indexPath.row]["email"]!)
        cell.setupCell(email: userEmails[indexPath.row]["email"]!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    
}


extension AddGroupVC: UITextFieldDelegate {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
