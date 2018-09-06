//
//  FollowersViewController.swift
//  GitHubHelper
//
//  Created by Admin on 06.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit


class FollowersViewController: UIViewController {
    //MARK:- outlets and vars
    @IBOutlet weak var tableView: UITableView!
    
    var indentifier = "cell1"
    var users = [UserFromFollowers]()  // create in func not global var!!!1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("followersDid load")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    //MARK:- button actions
    
    @IBAction func buttonPressed(_ sender: UIButton) {
    }
    
}

//MARK- extinsions
extension FollowersViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return users.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indentifier, for: indexPath)
        
        cell.backgroundColor = .purple
        switch indexPath.row {
        case 0: cell.textLabel?.text = "login - \(users[indexPath.section].login)"
        case 1: cell.textLabel?.text = "id - \(users[indexPath.section].id)"
        case 2: cell.textLabel?.text = "avatar_url - \(users[indexPath.section].avatar_url  )"
        case 3: cell.textLabel?.text = "followers_url - \(users[indexPath.section].followers_url )"
        case 4: cell.textLabel?.text = "followers_url - \(users[indexPath.section].followers_url)"
            
        default:           "error"
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return users[section].login
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "fotter"
    }
    
}
extension FollowersViewController: UITableViewDelegate{
    
}

