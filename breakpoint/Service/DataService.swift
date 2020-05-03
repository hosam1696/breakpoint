//
//  DataService.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 4/30/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import Foundation
import Firebase


let DB_REF: DatabaseReference = Database.database().reference()

class DataService {
    
    static let instance = DataService()
    
    private let _REF_BASE = DB_REF
    private let _REF_USERS = DB_REF.child("users")
    private let _REF_GROUPS = DB_REF.child("groups")
    private let _REF_FEEDS = DB_REF.child("feeds")
    
    var DATABASE_REFERENCE: DatabaseReference {
        return _REF_BASE
    }
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    var REF_FEED: DatabaseReference {
        return _REF_FEEDS
    }
    
    
    func createUser(uid: String, userData: [String: String]) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func createNewPost(withMessage message: String, forId uid: String, withGroupKey groupKey: String?, handler: @escaping (_ status: Bool) -> Void) {
        if groupKey != nil {
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues( ["content": message, "senderId": uid, "created_at": Date().description(with: .current)])
            handler(true)
        } else {
            // send to feed
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid, "created_at": Date().description(with: .current)])
            handler(true)
        }
    }
    
    
    func getAllFeeds(handler: @escaping (_ posts: [Post]?) -> Void) {
        
        REF_FEED.observe(.value, with: { feedPostsSnapShot in
            print(feedPostsSnapShot)
            guard let feedPostsSnapShot = feedPostsSnapShot.children.allObjects as? [DataSnapshot] else {
                handler(nil)
                return
            }
            var posts: [Post] = []
            for post in feedPostsSnapShot {
                
                let content = post.childSnapshot(forPath: "content").value as! String
                let senderId = post.childSnapshot(forPath: "senderId").value as! String
                let createdAt = post.childSnapshot(forPath: "created_at").value as! String
                
                posts.append(Post(content: content, senderId: senderId, createdAt: createdAt))
            }
            handler(posts.reversed())
        })
        
    }
    
    
    func getAllGroups(handler: @escaping (_ groups: [Group]?) -> Void) {
        REF_GROUPS.observe(.value, with: { groupsSnapShot in
            print(groupsSnapShot)
            guard let groupsSnapShot = groupsSnapShot.children.allObjects as? [DataSnapshot] else {
                handler(nil)
                return
            }
            var groups: [Group] = []
            for group in groupsSnapShot {
                let members = group.childSnapshot(forPath: "users").value as! [String]
                let title = group.childSnapshot(forPath: "title").value as! String
                let description = group.childSnapshot(forPath: "description").value as! String
                
                groups.append(Group(id: group.key, title: title, description: description, members: members))
            }
            handler(groups.reversed())
        })
    }
    
    func getAllUsers(handler: @escaping (_ users: [[String: String]]?) -> Void) {
        var usersEmails: [[String: String]] = []
        REF_USERS.observeSingleEvent(of: .value) { (usersSnapShot) in
            guard let users = usersSnapShot.children.allObjects as? [DataSnapshot] else {
                handler(nil)
                return
            }
            
            for user in users {
                let email = user.childSnapshot(forPath: "email").value as! String
                usersEmails.append(["email": email])
            }
            
            handler(usersEmails)
        }
    }
    
    func getUserEmail(ofUid uid: String, handler: @escaping (_ email: String?) -> Void) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapShot) in            
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in userSnapShot {
                if user.key == uid {
                    let email = user.childSnapshot(forPath: "email").value as! String
                    handler(email)
                } else {
                    handler(nil)
                }
            }
        }
    }

    
    func createGroup(title: String, description: String, users: [String], handler: @escaping (_ status: Bool) -> ()) {
        
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "users": users, "created_at": Date().description(with: .current)])
        handler(true)
        
    }
    
    
    func getGroupMessages(byId id: String, handler: @escaping (_ messages: [Post]?) -> Void) {
        print("Group Id: \(id)")
        REF_GROUPS.child("\(id)/messages").observe(.value) { (dataSnapShots) in
            guard let messages = dataSnapShots.children.allObjects as? [DataSnapshot] else {
                handler(nil)
                return
            }
            var posts: [Post] = []
            for message in messages {
                
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let createdAt = message.childSnapshot(forPath: "created_at").value as! String
                
                posts.append(Post(content: content, senderId: senderId, createdAt: createdAt))
            }
            
            handler(posts)
        }
    }
}
