//
//  RegistrationViewController.swift
//  CrickScore
//
//  Created by Anjali Sikarwar on 04/07/23.
//

import UIKit
import CoreData

class RegistrationViewController: UIViewController {
    
    @IBOutlet var secondView: UIView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var newEmailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet var submitButton: UIButton!
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static var userDetails = [UserRegistrationDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if LoginViewController.isForgetPassword {
            self.nameLabel.isHidden = true
            self.nameTextField.isHidden = true
            self.headerLabel.text = "Reset Password"
         //   self.secondView.frame = CGRect(x: 8, y: 200, width: 374, height: 300)
            emailLabel.topAnchor.constraint(equalTo: self.secondView.topAnchor, constant: 8).isActive = true
        }
        
    }

    @IBAction func submitButtonClicked(_ sender: Any) {
        if LoginViewController.isForgetPassword {
            if newEmailTextField.text?.isEmpty == true{
                self.displayAlertMessage(messageToDisplay: "Please Enter Email Address")
            }else if !self.isValidEmailAddress(givenEmailAddress: newEmailTextField.text!) {
                self.displayAlertMessage(messageToDisplay: "Email address is not valid format.")
            }else if passwordTextField.text?.isEmpty == true {
                self.displayAlertMessage(messageToDisplay: "Please Enter Password.")
            }else if !self.isValiePassword(str: passwordTextField.text!) {
                self.displayAlertMessage(messageToDisplay: "Password is not secure. Please Enter secure password")
            }else if confirmPasswordTextField.text?.isEmpty == true {
                self.displayAlertMessage(messageToDisplay: "Please Enter Confirm Password")
            }else if passwordTextField.text != confirmPasswordTextField.text {
                self.displayAlertMessage(messageToDisplay: "Password and Confirm Password are not same")
            }
        }else {
            
            if nameTextField.text?.isEmpty == true {
                self.displayAlertMessage(messageToDisplay: "Please Enter name first")
            }else if newEmailTextField.text?.isEmpty == true{
                self.displayAlertMessage(messageToDisplay: "Please Enter Email Address")
            }else if !self.isValidEmailAddress(givenEmailAddress: newEmailTextField.text!) {
                self.displayAlertMessage(messageToDisplay: "Email address is not valid format.")
            }else if passwordTextField.text?.isEmpty == true {
                self.displayAlertMessage(messageToDisplay: "Please Enter Password.")
            }else if !self.isValiePassword(str: passwordTextField.text!) {
                self.displayAlertMessage(messageToDisplay: "Password is not secure. Please Enter secure password")
            }else if confirmPasswordTextField.text?.isEmpty == true {
                self.displayAlertMessage(messageToDisplay: "Please Enter Confirm Password")
            }else if passwordTextField.text != confirmPasswordTextField.text {
                self.displayAlertMessage(messageToDisplay: "Password and Confirm Password are not same")
            }
            
        }
        
        
        loadUserDetails()
        if RegistrationViewController.userDetails.count != 0 {
            for user in RegistrationViewController.userDetails {
                if LoginViewController.isForgetPassword && user.emailId == newEmailTextField.text {
                    user.password = self.confirmPasswordTextField.text
                    save()
                    loadUserDetails()
                    self.displayAlertMessage(messageToDisplay: "Password reset successfully")
                    self.navigationController?.popViewController(animated: true)
                }
                
                if user.emailId == newEmailTextField.text {
                    displayAlertMessage(messageToDisplay: "User Already Exists.")
                    break
                }
            }
        }
        
        self.addUserinArray()
        self.navigationController?.popViewController(animated: true)
    }
    
    func addUserinArray(){
        let newUser = UserRegistrationDetails(context: RegistrationViewController.context)
        newUser.name = self.nameTextField.text
        newUser.emailId = self.newEmailTextField.text
        newUser.password = self.confirmPasswordTextField.text
        newUser.code = 0
        
        RegistrationViewController.userDetails.append(newUser)
        print("User: \(newUser)")
        save()
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
            RegistrationViewController.userDetails = try RegistrationViewController.context.fetch(request)
            print("User Details: \(RegistrationViewController.userDetails)")
        }catch{
            print("Error while fatching data from context: \(error)")
        }
    }
    
}
