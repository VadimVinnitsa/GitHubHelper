import UIKit


class ViewController: UIViewController {
    
    //MARK:- outlets and vars
    
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
    
    
    @IBOutlet weak var writeNameOrIdLabel: UILabel!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    
    
    
    var user = User()
    //   var userFromID = [UserFromId]()
    
    
    //MARK:- did load
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
        userIDTextField.isHidden = true
        
        let url = URL(string: "https://avatars1.githubusercontent.com/u/42915692?v=4")
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
              self.avatar.image = UIImage(data: data!)
            }
        }
        
        
        
    }
    
    //MARK:- get data from site
    func getDataFromGitHubFromLogin(userName: String)  {
        let path = "https://api.github.com/users/" + userName
        
        guard let url = URL(string: path) else {
           alertForFindPressed(mesage: "bad url login !!!!")
            return
             }
        
        let sesion = URLSession(configuration: .default)
        let task = sesion.dataTask(with: url) { (data, response, error) in
            //if error do something
            if error != nil {
                
                DispatchQueue.main.async {
                    self.alertForFindPressed(mesage: "error login nil")
                 }
               return
               }
            
            guard let data = data else{
                self.alertForFindPressed(mesage: "bad data")
                return
            }
            do{
                self.user = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    print(self.user)
                    self.refreshLabel()
                }
            } catch{ // NEED catch error !!!!!!!!!!!!
               // self.alertForFindPressed(mesage: "login is invalid")
            }
        }
        task.resume()
    }
    
    func getDataFromGitHubFromId(userId: Int)  {
        let path = "https://api.github.com/users?since=" + String(userId-1)
        print(path)
       
        guard let url = URL(string: path) else {
          alertForFindPressed(mesage: "bad url ID")
            return
            
        }
        
        let sesion = URLSession(configuration: .default)
        let task = sesion.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.alertForFindPressed(mesage: "error in ID")
                return
            }
            
            guard let data = data else{
                self.alertForFindPressed(mesage: "bad data ID")
                return
            }
            do{
                var userFromId = [UserFromId]()
                userFromId = try JSONDecoder().decode([UserFromId].self, from: data)
                    if userFromId.count > 0 && userFromId[0].id == userId{
                        self.getDataFromGitHubFromLogin(userName: userFromId[0].login)
                    }else{
                        
                        DispatchQueue.main.async {
                            self.alertForFindPressed(mesage: "id not found")
                        }
                    }
             // need this DispatchQueue ???
                
            } catch{} // need catch error!!!!!
        }
        task.resume()
    }
    
    //MARK:- refresh label
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
    //MARK:- button actions
    
    @IBAction func segmentControlPressed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            userNameTextField.isHidden = false
            userIDTextField.isHidden = true
            writeNameOrIdLabel.text = "write Login"
        }else {
            userNameTextField.isHidden = true
            userIDTextField.isHidden = false
            writeNameOrIdLabel.text = "write Id"
        }
        
    }
    
    
    @IBAction func find(_ sender: UIButton) {
        if segmentControl.selectedSegmentIndex == 0 {
            guard let login = userNameTextField.text else {
                alertForFindPressed(mesage: "NameTextField is nil")
                return
            }
            
            guard  login != "" else {
                alertForFindPressed(mesage: "textFieldName id 0 sign")
                return
            }
            
            print("login - \(login)")
            getDataFromGitHubFromLogin(userName: login)
        }
        
        /////////
        if segmentControl.selectedSegmentIndex == 1 {
            guard let data = userIDTextField.text else {  // maybe better if ????
                alertForFindPressed(mesage: "textIdField is nil")
                return
            }
            guard let id = Int(data) else {
                alertForFindPressed(mesage: "input number")
                return
            }
            guard id > 1 else {
                alertForFindPressed(mesage: "input number bigger than 1")
                return
            }
            print("id - \(id)")
            getDataFromGitHubFromId(userId: id)
            
        }
        
    }
    
    func alertForFindPressed (mesage: String) {
        print(mesage)
        
        let alert = UIAlertController(title: "oops some error", message: mesage, preferredStyle: .alert)
       // alert.addAction(UIAlertAction(title: "ok", style: .default, handler: funcForAlert))
        alert.addAction(UIAlertAction(title: "ok", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    func funcForAlert(action: UIAlertAction){
        
    }
    
    
    
    @IBAction func followersPressed(_ sender: UIButton) {
    }
    
    @IBAction func followingPressed(_ sender: UIButton) {
    }
    
    
}


