import UIKit


class ViewController: UIViewController {

    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var publicReposts: UILabel!
    @IBOutlet weak var publicGists: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var dateCreate: UILabel!
    @IBOutlet weak var dataUpdate: UILabel!
    
    
    
    var user = User()
 //   var userFromID = [UserFromId]()

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
//        https://api.github.com/users?since=10000000
//        https://api.github.com/users/VadimVinnitsa
//      abrn
 //       bianyujiyi
  //      emin002
      
        start()
        
 
    }

    
    func start()  {
        print("did load")
       
    }
    
    func getDataFromGitHubFromLogin(userName: String)  {
         let path = "https://api.github.com/users/" + userName
        
        guard let url = URL(string: path) else {return}
        
        let sesion = URLSession(configuration: .default)
        let task = sesion.dataTask(with: url) { (data, response, error) in
            //if error do something
            guard let data = data else{
                print("no data")
                return
            }
            do{
                
                self.user = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    print(self.user)
                   self.refreshLabel()
                }
            } catch{}
        }
        task.resume()
    }
 
    func getDataFromGitHubFromId(userId: Int)  {
         let path = "https://api.github.com/users?since=" + String(userId-1)
        print(path)
        guard let url = URL(string: path) else {return} //
        
        let sesion = URLSession(configuration: .default)
        let task = sesion.dataTask(with: url) { (data, response, error) in
        
            guard let data = data else{
                print("no data")
                return
            }
            do{
                var userFromId = [UserFromId]()
                userFromId = try JSONDecoder().decode([UserFromId].self, from: data)
                DispatchQueue.main.async {
                    print(userFromId[0])
                    if userFromId[0].id == userId{
                       self.getDataFromGitHubFromLogin(userName: userFromId[0].login)
                    }else{
                        print("id not found")
                    }
                    
                } // need this DispatchQueue
                
            } catch{}
        }
        task.resume()
    }
  
    func refreshLabel(){
    id.text = String(user.id)
        userName.text = user.login
      //  avatar
   
        
        publicReposts.text = String(user.public_repos)
        publicGists.text = String(user.public_gists)
        followers.text =  String(user.followers)
        following.text = String(user.following)
        dateCreate.text = user.created_at
        dataUpdate.text = user.updated_at
        
    }
    
    @IBAction func findFromIdPressed(_ sender: UIButton) {
       
        guard let data = userIDTextField.text, let id = Int(data) else {
            print("text ID field is empty")
            return
        }
        print("id - \(id)")
        getDataFromGitHubFromId(userId: id)
        
    }
    
    @IBAction func findLoginPressed(_ sender: UIButton) {
        guard let login = userNameTextField.text else {
            print("text field is empty")
            return
        }
        print("login - \(login)")
        getDataFromGitHubFromLogin(userName: login)
         }
    
    
    @IBAction func followersPressed(_ sender: UIButton) {
    }
    
    @IBAction func followingPressed(_ sender: UIButton) {
    }
    
    
}


