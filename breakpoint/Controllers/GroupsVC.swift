//
//  SecondViewController.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 4/30/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == Segues.GroupVCSegue.rawValue {
//            guard let groupVC = segue.destination as? GroupVC else {return}
//
//            let group = sender as! Group
//
//            groupVC.setupView(group: group)
//
//
//            present(groupVC, animated: true, completion: nil)
//
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getGroups()
    }

    
    func getGroups() {
        DataService.instance.getAllGroups { (allGroups) in
            if allGroups != nil {
                self.groups = allGroups!
                self.tableView.reloadData()
            }
        }
    }

}


extension GroupsVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = Bundle.main.loadNibNamed(Identifiers.GroupCell.rawValue, owner: self, options: nil)?.first as? GroupCell else {
            return UITableViewCell()
        }
        cell.setupCell(group: groups[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        self.performSegue(withIdentifier: Segues.GroupVCSegue.rawValue, sender: groups[indexPath.row])
        guard let groupVC = storyboard?.instantiateViewController(identifier: Identifiers.GroupVC.rawValue) as? GroupVC else {return}
        groupVC.modalPresentationStyle = .fullScreen
        groupVC.setupView(group: self.groups[indexPath.row])
        
        self.present(groupVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
}




