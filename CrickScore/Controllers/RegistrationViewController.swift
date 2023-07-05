//
//  RegistrationViewController.swift
//  CrickScore
//
//  Created by Anjali Sikarwar on 04/07/23.
//

import UIKit
import CoreData

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var newEmailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var userDetails = [UserRegistrationDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func submitButtonClicked(_ sender: Any) {
        if newEmailTextField.text?.isEmpty == true{
            self.displayAlertMessage(messageToDisplay: "Email Address Can't be empty.")
        }else if passwordTextField.text?.isEmpty == true {
            self.displayAlertMessage(messageToDisplay: "Please Enter Password.")
        }else if confirmPasswordTextField.text?.isEmpty == true {
            self.displayAlertMessage(messageToDisplay: "Please Enter Confirm Password")
        }else if passwordTextField.text != confirmPasswordTextField.text {
            self.displayAlertMessage(messageToDisplay: "Password and Confirm Password are not same")
        }
        loadUserDetails()
        if self.userDetails.count != 0 {
            for user in userDetails {
                if user.emailId == newEmailTextField.text {
                    displayAlertMessage(messageToDisplay: "User Already Exists.")
                }
            }
        }
    }
    
    func save() {
        do{
            try RegistrationViewController.context.save()
        }catch{
            print("Gettring error while saving registraion Detail. \(error)")
        }
    }
    
    func loadUserDetails() {
        let request: NSFetchRequest<UserRegistrationDetails> = UserRegistrationDetails.fetchRequest()
        do {
            self.userDetails = try RegistrationViewController.context.fetch(request)
            print("User Details: \(self.userDetails)")
        }catch{
            print("Error while fatching data from context: \(error)")
        }
    }
    
}
