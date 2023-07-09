//
//  ViewController.swift
//  CrickScore
//
//  Created by support on 16/03/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var forgetPasswordButton: UIButton!
    @IBOutlet var createAccountButton: UIButton!
    static var userIndex: Int! 
    static var isForgetPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 15
        self.loadUserDetails()
        let userLoggedout = UserDefaults.standard.string(forKey: "UserLoggedOut")
        if  userLoggedout != nil && userLoggedout == "0" {
            print("Logged Email: \(UserDefaults.standard.string(forKey: "LastLoggedEmail"))")
            print("Logged Password: \(UserDefaults.standard.string(forKey: "LastLoggedPassword"))")
            let index = Int(UserDefaults.standard.string(forKey: "LastLoggedIndex")!)
            
            MemberAddedFromViewController.currentMatchUserDetail = RegistrationViewController.userDetails[index!]
            print("email: \(MemberAddedFromViewController.currentMatchUserDetail?.emailId)")
            print("email: \(MemberAddedFromViewController.currentMatchUserDetail?.password)")
            
            let teamVC = self.storyboard?.instantiateViewController(withIdentifier: "TeamSelection")// as! TeamSelectionViewController
            self.navigationController?.pushViewController(teamVC!, animated: true)
        }
    }

    @IBAction func clickedLoginButton(_ sender: Any) {
        
        if emailTextField.text?.isEmpty == true {
            self.displayAlertMessage(messageToDisplay: "UserName can't be empty.")
            return
        }

        if !self.isValidEmailAddress(givenEmailAddress: emailTextField.text!) {
            self.displayAlertMessage(messageToDisplay: "Email address is not valid format.")
            return
        }

        if passwordTextField.text?.isEmpty == true {
            self.displayAlertMessage(messageToDisplay: "Password can't be empty.")
            return
        }

        if !self.isValiePassword(str: passwordTextField.text!) {
            self.displayAlertMessage(messageToDisplay: "Password is not secure. Please Enter secure password")
            return
        }
        
        if !checkingUserExistance() {
            displayAlertMessage(messageToDisplay: "Email or Password is Incorrect.")
            return
        }
        UserDefaults.standard.set(false, forKey: "UserLoggedOut")
        
        let teamVC = self.storyboard?.instantiateViewController(withIdentifier: "TeamSelection")// as! TeamSelectionViewController
        self.navigationController?.pushViewController(teamVC!, animated: true)
//
//        loginAPICall()

    }
    
    @IBAction func forgetPasswordClicked(_ sender: Any) {
        LoginViewController.isForgetPassword = true
        let registratioVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationVC")
        self.navigationController?.pushViewController(registratioVC!, animated: true)
    }
    
    
    @IBAction func createNewAccount(_ sender: Any) {        
        let registrationVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationVC")
        self.navigationController?.pushViewController(registrationVC!, animated: true)
    }
    
    func checkingUserExistance() -> Bool {
        var isExist = false
        var index = 0
        for user in RegistrationViewController.userDetails{
            print("User: \(user)")
            if (user.emailId == self.emailTextField.text) && (user.password == self.passwordTextField.text){
                UserDefaults.standard.set(self.emailTextField.text, forKey: "LastLoggedEmail")
                UserDefaults.standard.set(self.passwordTextField.text, forKey: "LastLoggedPassword")
                UserDefaults.standard.set(index, forKey: "LastLoggedIndex")
                LoginViewController.userIndex = Int(UserDefaults.standard.string(forKey: "LastLoggedIndex")!)
                MemberAddedFromViewController.currentMatchUserDetail = user
                isExist = true
                return isExist
            }
            index += 1
        }
        return isExist
    }
    
    func loadUserDetails() {
        let request: NSFetchRequest<UserRegistrationDetails> = UserRegistrationDetails.fetchRequest()
        do {
            RegistrationViewController.userDetails = try RegistrationViewController.context.fetch(request)
            print("User Details: \(RegistrationViewController.userDetails)")
        }catch{
            print("Error while fatching data from context: \(error)")
        }
    }
    
    
//    func loginAPICall(){
//        
//        let parameters = [
//            "email": userNameTextField.text?.lowercased(),
//            "password": passwordTextField.text
//        ] as [String : Any]
//        
//        let postData = parameters.description.data(using: .utf8)
//        
//        var request = URLRequest(url: URL(string: "https://cricket-score-api-11.vercel.app/signIn/user")!, timeoutInterval: Double.infinity)
//       // request.addValue("Bearer \()", forHTTPHeaderField: "Authorization")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//        request.httpBody = postData
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            print("Error: \(error)")
//            print("Response: \(response)")
//            print("Data: \(data)")
//            guard let data = data else {
//                print(String(describing: error))
//                    return
//            }
//
//            print("Data count: \(String(data: data, encoding: .utf8)!)")
//            let response = String(data: data , encoding: .utf8)
//            
//            do {
//                let responseModel = try JSONDecoder().decode(signinResponseMondel.self, from: data)
//                print("Response Model: \(responseModel)")
//            }catch{
//                print(error)
//            }
//            
//            print("response: \(response!)")
//            print("API Called Successfully")
//            DispatchQueue.main.async {
//                let teamVC = self.storyboard?.instantiateViewController(withIdentifier: "TeamSelection")// as! TeamSelectionViewController
//                self.navigationController?.pushViewController(teamVC!, animated: true)
//            }
//                
//        }
//        task.resume()
//    }
    
    
}

