import UIKit


class ViewController: UIViewController {
    
    //MARK:- outlets and vars
    
    //  @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var publicReposts: UILabel!
    @IBOutlet weak var publicGists: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var dateCreate: UILabel!
    @IBOutlet weak var dataUpdate: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var user = User()
    
    //MARK:- did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProgram()
        
    }
    
    
    func setupProgram()  {
        print("did load")
        textField.delegate = self
        
        //future cods
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
    }
    //MARK:- future cods
    @objc func keyboardShow() {
        print("keyboardShow")
    }
    @objc func keyboardHide() {
        print("keyboardHide")
    }
    
    //MARK:- creare new VC
    func getFollowersAndCreateNewVCAndPush(path: String) { //?? name????
        guard let url = URL(string: path) else {
            showAlertAsync(mesage: "bad url GETFOLLOWERS")
            return
        }
        let sesion = URLSession(configuration: .default)
        let task = sesion.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.showAlertAsync(mesage: "error GetFollowers nil")
                return
            }
            
            guard let data = data else {
                self.showAlertAsync(mesage: "bad data getFolowers")
                return
            }
            do {
                let users = try JSONDecoder().decode([UserFromFollowers].self, from: data)
                
                DispatchQueue.main.async {
                    print(users)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: FollowersViewController.IdStoryboard) as! FollowersViewController
                    vc.users = users
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } catch let error {
                self.showAlertAsync(mesage: error.localizedDescription)
            }
        }
        task.resume()
        
    }
    
    
    //MARK:- get user from site
    func getDataFromGitHubFromLogin(userName: String) {
        let path = "https://api.github.com/users/" + userName
        
        guard let url = URL(string: path) else {
            showAlertAsync(mesage: "bad url login !!!!")
            return
        }
        
        let sesion = URLSession(configuration: .default)
        let task = sesion.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.showAlertAsync(mesage: "error login nil")
                return
            }
            
            guard let data = data else {
                self.showAlertAsync(mesage: "bad data")
                return
            }
            do {
                self.user = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    print(self.user)
                    self.refreshLabel()
                }
            } catch let error  {
                self.showAlertAsync(mesage: error.localizedDescription + " in login")
            }
        }
        task.resume()
    }
    
    func getDataFromGitHubFromId(userId: Int) {
        let path = "https://api.github.com/users?since=" + String(userId-1)
        print(path)
        
        guard let url = URL(string: path) else {
            showAlertAsync(mesage: "bad url ID")
            return
        }
        
        let sesion = URLSession(configuration: .default)
        let task = sesion.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.showAlertAsync(mesage: "error in ID")
                return
            }
            
            guard let data = data else{
                self.showAlertAsync(mesage: "bad data ID")
                return
            }
            do {
                var userFromId = [UserFromId]()
                userFromId = try JSONDecoder().decode([UserFromId].self, from: data)
                if userFromId.count > 0 && userFromId[0].id == userId{
                    self.getDataFromGitHubFromLogin(userName: userFromId[0].login)  //if we find ID run func getDataFromGitHubFromLogin
                } else {
                    self.showAlertAsync(mesage: "id not found")
                }
                
            } catch let error {
                self.showAlertAsync(mesage: error.localizedDescription)
            }
        }
        task.resume()
    }
    
    //MARK:- refresh label
    func refreshLabel() {
        id.text = String(user.id)
        userName.text = user.login
        getImage(path: user.avatar_url)
        
        publicReposts.text = String(user.public_repos)
        publicGists.text = String(user.public_gists)
        followers.text =  String(user.followers)
        following.text = String(user.following)
        dateCreate.text = user.created_at
        dataUpdate.text = user.updated_at
        print("followers - \(user.followers_url)")
        print("following - \(user.following_url)")
        
    }
    
  // get avatar image
    func getImage(path: String) {
        //  var path1 = "https://avatars1.githubusercontent.com/u/42915692?v=4"
        guard let url = URL(string: path) else {
            showAlertAsync(mesage: "bad url in get img")
            return
        }
        
        DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.avatar.image = UIImage(data: data)
                    }
                } else {
                    self.showAlertAsync(mesage: "no data in GetImg")
                }
            
        }
    }
    
    
    //MARK:- findUser
    func findUser() {
        if segmentControl.selectedSegmentIndex == 0 {
            guard let login = textField.text else {
                showAlert(mesage: "NameTextField is nil")
                return
            }
            
            guard  login != "" else {
                showAlert(mesage: "textFieldName id 0 sign")
                return
            }
            print("login - \(login)")
            getDataFromGitHubFromLogin(userName: login)
            print(user.followers_url)
            print(user.following_url)
            
        }
        
        /////////
        if segmentControl.selectedSegmentIndex == 1 {
            guard let data = textField.text else {  // maybe better if ????
                showAlert(mesage: "textIdField is nil")
                return
            }
            guard let id = Int(data) else {
                showAlert(mesage: "input number")
                return
            }
            guard id > 1 else {
                showAlert(mesage: "input number bigger than 1")
                return
            }
            print("id - \(id)")
            getDataFromGitHubFromId(userId: id)
            
        }
    }
    
    //MARK:- alert functions
    func showAlertAsync (mesage: String) { // go to main theard and show alert
        DispatchQueue.main.async {
            print(mesage)
            let alert = UIAlertController(title: "oops some error", message: mesage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlert (mesage: String) { //only show alert
        print(mesage)
        let alert = UIAlertController(title: "oops some error", message: mesage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- func for TextField
    func changeTextFieldStyle(segmentControl: UISegmentedControl) {
        label.text = segmentControl.selectedSegmentIndex == 0 ? "write Login" : "write Id"
        textField.placeholder = segmentControl.selectedSegmentIndex == 0 ? "write Login" : "write Id"
        textField.text = ""  // clear textField when change SegmentControl
        textField.resignFirstResponder()
        textField.becomeFirstResponder()
        
    }
    
  //  hide keyboard when tapped not textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
    //MARK:- actions UI
    @IBAction func findPressed(_ sender: UIButton) {
        findUser()
    }
    
    @IBAction func followersPressed(_ sender: UIButton) {
        if user.followers > 0 {
            getFollowersAndCreateNewVCAndPush(path: user.followers_url)
            
        } else {
            showAlert(mesage: "No followers (")
        }
    }
    
    @IBAction func followingPressed(_ sender: UIButton) {
        
        //        if user.following > 0 {
        //            showAlert(mesage: "oto vono tobi bulo treba ?????")
        //        } else {
        //            showAlert(mesage: "No following (")
        //        }
        
        //? what method is best?
        
        let message =  user.following > 0 ? "oto vono tobi bulo treba ?????" : "No following ("
        showAlert(mesage: message)
        
    }
    
    @IBAction func segmentControlPressed(_ sender: UISegmentedControl) {
        changeTextFieldStyle(segmentControl: sender)
    }
    
}

//MARK:- extencsion
extension ViewController: UITextFieldDelegate {
    //input only Integer when ID selected
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if segmentControl.selectedSegmentIndex == 1 {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            print("delegate id  \(allowedCharacters.isSuperset(of: characterSet))")
            return allowedCharacters.isSuperset(of: characterSet)
        } else {
            return true   // input all letter if Login selected
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {  //change keyBoard style
        textField.keyboardType = segmentControl.selectedSegmentIndex == 0 ? .default : .decimalPad
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    //hide KeyBoard when pressed return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        textField.resignFirstResponder()
        findUser()
        return true
    }
    
}


