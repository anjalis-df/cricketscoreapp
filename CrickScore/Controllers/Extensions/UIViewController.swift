//
//  AlertController.swift
//  CrickScore
//
//  Created by support on 30/03/23.
//

import UIKit

extension UIViewController {

    func displayAlertMessage(messageToDisplay: String) {
        let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default){ (action: UIAlertAction!) in
            print("Okay Button Tapped")
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func isValidEmailAddress(givenEmailAddress: String) -> Bool {
        var returnValue = true
        let emailRegex = "[A-Z0-9a-z.-_]+@[A-Z0-9a-z.-_]+\\.[A-Za-z]{2,3}"
        do {
            let regex = try NSRegularExpression(pattern: emailRegex)
            let nsString = givenEmailAddress as NSString
            let result = regex.matches(in: givenEmailAddress, range: NSRange(location: 0, length: nsString.length))
            
            if result.count == 0 {
                returnValue = false
            }
        }catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return returnValue
    }
    
    func isValiePassword(str: String) -> Bool {
//        let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$)"
        let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordCheck.evaluate(with: str)
    }
    
    func isInteger(number: Int) -> Bool {
        let numberRegex = "^[0-9]{10}$"
        let numberCheck = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        return numberCheck.evaluate(with: number)
    }
}
