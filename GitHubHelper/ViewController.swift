//
//  ViewController.swift
//  GitHubHelper
//
//  Created by Admin on 03.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var user : User?

   let identifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   https://api.github.com/users?since=10000000
     //   https://api.github.com/users/VadimVinnitsa
      tableView.delegate = self
        tableView.dataSource = self
        start()
        
 
        
    
    }

    
    func start()  {
        print("did load")
        user = User(login: "-", id: 1)
    }
    
    func getDataFromGitHub(userName: String)  {
        let path = "https://api.github.com/users/VadimVinnitsa"     // + userName
        guard let url = URL(string: path) else {return}
        let sesion = URLSession(configuration: .default)
        let task = sesion.dataTask(with: url) { (data, response, error) in
            //if error do something
            do{
                self.user = try JSONDecoder().decode(User.self, from: data!)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch{}
        }
        task.resume()
    }
 
  
    
    @IBAction func findPressed(_ sender: UIButton) {
        getDataFromGitHub(userName: "dsf")
    }
    
}

extension ViewController: UITableViewDelegate{
    
    
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
         // let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if let user = self.user {
            cell.textLabel?.text = String(user.id)
            
        }else{
            cell.textLabel?.text = "---"
            
        }
        
        return cell
    }
    
    
    
    
}

