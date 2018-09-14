import UIKit


class FollowersViewController: UIViewController {
    
    //MARK:- outlets and vars
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
        }
    }
    
    var indentifier = "cell1"
    var users = [UserFromFollowers]()  // create in func not global var!!!1
    static var IdStoryboard = "idFollowers"
    
    //MARK:- did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
    }
    
    func setupVC () {
        print("followersDid load")
      }
    
    //MARK:- UI actions
    @IBAction func buttonPressed(_ sender: UIButton) {
    }
    
}

//MARK- extinsions
extension FollowersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indentifier, for: indexPath)
        
        cell.backgroundColor = .purple
        let index = indexPath.section
        
                switch indexPath.row {
                case 0: cell.textLabel?.text = "login - \(users[index].login)"
                case 1: cell.textLabel?.text = "id - \(users[index].id)"
                case 2: cell.textLabel?.text = "avatar_url - \(users[index].avatar_url  )"
                case 3: cell.textLabel?.text = "followers_url - \(users[index].followers_url )"
                case 4: cell.textLabel?.text = "followers_url - \(users[index].followers_url)"
        
                default:   cell.textLabel?.text = "error"
                }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { // header
        return users[section].login
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? { // footer
        return "fotter"
    }
    
}

extension FollowersViewController: UITableViewDelegate {
    
}

