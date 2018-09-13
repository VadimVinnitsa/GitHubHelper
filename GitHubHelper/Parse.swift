//
//  Parse.swift
//  GitHubHelper
//
//  Created by Admin on 03.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

//        https://api.github.com/users?since=10000000
//        https://api.github.com/users/VadimVinnitsa
//      abrn
//       bianyujiyi
//      emin002


import UIKit

class Parse: NSObject {
    
}
struct UserFromFollowers : Codable {
    var login: String
    var id: Int
    //  var node_id: String
    var avatar_url: String
    // var  gravatar_id: "",
    // var url: String
    //  var html_url: String
    var followers_url: String
    var following_url: String
    //  var gists_url: String
    //  var starred_url: String
    //  var subscriptions_url: String
    //  var organizations_url: String
    //  var repos_url: String
    //  var events_url: String
    //   var received_events_url: String
    //   var type: String
    //  var site_admin: Bool
    
    init(login: String = "-", id: Int = -1, avatar_url: String = "-", followers_url: String = "-", following_url: String = "-" ) {
        self.login = login
        self.id = id
        self.avatar_url = avatar_url
        self.followers_url = followers_url
        self.following_url = following_url
        
    }
}


struct UserFromId : Codable {
    var login: String
    var  id: Int
    
    
    init(login: String = "-", id: Int = -1) {
        self.id = id
        self.login = login
    }
}


struct User : Codable{
    
    var login : String
    var  id : Int
    var node_id : String
    var avatar_url : String
    //   var gravatar_id : String
    //   var url : String
    //   var html_url : String
    var followers_url: String
    var following_url: String
    
    //   var gists_url: String
    //   var starred_url: String
    //   var subscriptions_url: String
    //   var organizations_url: String
    //   var repos_url: String
    //   var events_url: String
    //   var received_events_url: String
    //   var type: String
    //   var site_admin: Bool
    //   var name: String
    //   var company: String
    //  var  blog: String
    
    //   var location": null,
    // var email": null,
    //var hireable": null,
    //var bio": null,
    
    var   public_repos: Int
    var  public_gists: Int
    var followers: Int
    var following: Int
    var created_at: String
    var updated_at: String
    
    init(login: String = "-", id: Int = -1, node_id: String = "-", avatar_url: String = "-", followers_url: String = "-", following_url: String = "-", public_repos: Int = -1, public_gists: Int = -1, followers: Int = -1, following: Int = -1, created_at: String = "-", updated_at: String = "-" ) {
        self.login = login
        self.id = id
        self.node_id = node_id
        self.avatar_url = avatar_url
        self.followers_url = followers_url
        self.following_url = following_url
        self.public_repos = public_repos
        self.public_gists = public_gists
        self.following = following
        self.followers = followers
        self.created_at = created_at
        self.updated_at = updated_at
        
    }
    
    //
    //    init(nickName: String = "", realName: String = "", role: Role = .red) {
    //        self.nickName = nickName
    //        self.realName = realName
    //        self.role = role
    //
    //    }
    
    
}
