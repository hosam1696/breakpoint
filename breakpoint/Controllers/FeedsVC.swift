//
//  FirstViewController.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 4/30/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import UIKit
import Firebase

class FeedsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let dataService = DataService.instance
    var feedPosts: [Post] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle  {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        dataService.getAllFeeds { (posts) in
            guard let posts = posts else {
                return
            }
            self.feedPosts = posts
            self.tableView.reloadData()
        }
        
        if Auth.auth().currentUser == nil {
            let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
             let authVC = storyBoard.instantiateViewController(identifier: Identifiers.SignupMethodVC.rawValue)
         
            self.present(authVC, animated: true, completion: nil)
            
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    func checkLogging() {
        
    }
    
    


}


extension FeedsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tableCell = Bundle.main.loadNibNamed(Identifiers.FeedsPostTableViewCell.rawValue, owner: self, options: nil)?.first as? FeedsPostTableViewCell else {
            return UITableViewCell()
        }
        
        tableCell.setupData(post: feedPosts[indexPath.row])
        return tableCell
    }
    
    
}

