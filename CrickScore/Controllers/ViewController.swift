//
//  ViewController.swift
//  CrickScore
//
//  Created by support on 16/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var forgetPasswordButton: UIButton!
    @IBOutlet var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 15
        
    }

    @IBAction func clickedLoginButton(_ sender: Any) {
        
        let teamVC = self.storyboard?.instantiateViewController(withIdentifier: "TeamSelection")// as! TeamSelectionViewController
        self.navigationController?.pushViewController(teamVC!, animated: true)
        
//        if userNameTextField.text?.isEmpty == true {
//            self.displayAlertMessage(messageToDisplay: "UserName can't be empty.")
//        }
//
////        if userNameTextField.state.isEmpty {
////            self.displayAlertMessage(messageToDisplay: "UserName can't be empty.")
////        }
//
//        if !self.isValidEmailAddress(givenEmailAddress: userNameTextField.text!) {
//            self.displayAlertMessage(messageToDisplay: "Email address is not valid.")
//        }
//
//        if passwordTextField.text?.isEmpty == true {
//            self.displayAlertMessage(messageToDisplay: "Password can't be empty.")
//        }
//
//        if !self.isValiePassword(str: passwordTextField.text!) {
//            self.displayAlertMessage(messageToDisplay: "Password is not secure. Please Enter secure password")
//        }
//
//        loginAPICall()

    }
    
    func loginAPICall(){
        
        let parameters = [
            "email": userNameTextField.text?.lowercased(),
            "password": passwordTextField.text
        ] as [String : Any]
        
        let postData = parameters.description.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "https://cricket-score-api-11.vercel.app/signIn/user")!, timeoutInterval: Double.infinity)
       // request.addValue("Bearer \()", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("Error: \(error)")
            print("Response: \(response)")
            print("Data: \(data)")
            guard let data = data else {
                print(String(describing: error))
                    return
            }

            print("Data count: \(String(data: data, encoding: .utf8)!)")
            let response = String(data: data , encoding: .utf8)
            
            do {
                let responseModel = try JSONDecoder().decode(signinResponseMondel.self, from: data)
                print("Response Model: \(responseModel)")
            }catch{
                print(error)
            }
            
            print("response: \(response!)")
            print("API Called Successfully")
            DispatchQueue.main.async {
                let teamVC = self.storyboard?.instantiateViewController(withIdentifier: "TeamSelection")// as! TeamSelectionViewController
                self.navigationController?.pushViewController(teamVC!, animated: true)
            }
                
        }
        task.resume()
    }
    
    
}

