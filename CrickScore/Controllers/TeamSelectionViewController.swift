//
//  TeamSelectionViewController.swift
//  CrickScore
//
//  Created by support on 17/03/23.
//

import UIKit

class TeamSelectionViewController: UIViewController {
    
    @IBOutlet var selectTeamBtn: UIButton!
    @IBOutlet var resetBtn: UIButton!
    @IBOutlet var runningMatch: UIButton!
    static var isUserLoggedOut: Bool = false
    static var isRunningMatch = false
    
//    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginViewController.userIndex = Int(UserDefaults.standard.string(forKey: "LastLoggedIndex")!)
        print("Index: \(LoginViewController.userIndex)")
//        if !RegistrationViewController.userDetails[LoginViewController.userIndex].haveTeam {
//            self.runningMatch.addTarget(self, action: #selector(whenUserHaveNoAnyTeam), for: .touchUpInside)
//            self.resetBtn.addTarget(self, action: #selector(whenUserHaveNoAnyTeam), for: .touchUpInside)
//        }
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "arrowshape.turn.up.forward"), style: .plain, target: self, action: #selector(logoutButtonPressed))
        
        selectTeamBtn.layer.cornerRadius = 45
        resetBtn.layer.cornerRadius = 45
        runningMatch.layer.cornerRadius = 45
        
    }
    
    @objc func whenUserHaveNoAnyTeam() {
        self.displayAlertMessage(messageToDisplay: "You don't have any team, Please create team first.")
        return
    }
    
    @objc func logoutButtonPressed() {
        UserDefaults.standard.removeObject(forKey: "LastLoggedEmail")
        UserDefaults.standard.removeObject(forKey: "LastLoggedPassword")
        TeamSelectionViewController.isUserLoggedOut = true
        UserDefaults.standard.set(true, forKey: "UserLoggedOut")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func selectTeamBtnClicked(_ sender: Any) {
        let teamDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetails") as! TeamDetailViewController
        self.navigationController?.pushViewController(teamDetailsVC, animated: true)
    }
    
    @IBAction func resetGameClicked(_ sender: Any) {
        if !RegistrationViewController.userDetails[LoginViewController.userIndex].haveTeam {
            displayAlertMessage(messageToDisplay: "You don't have any team, Please create team first.")
            return
        }
        
        TeamSelectionViewController.isRunningMatch = false
        
      //  TeamSelectionViewController.context.delete(<#T##object: NSManagedObject##NSManagedObject#>)
        
        let currentEmail = UserDefaults.standard.string(forKey: "LastLoggedEmail")
        
        for player in MemberAddedFromViewController.playerDetails {
            if player.parent?.emailId == currentEmail {
                player.playerBallCount = 0
                player.playerFourCount = 0
                player.playerSixCount = 0
                player.playerRunCount = 0
                player.playerOverCount = 0
                player.playerWicketCount = 0
                player.wicketStatus = false
                player.totalRunCount = 0
                player.totalBallCount = 0
                player.totalWicketCount = 0
                player.playerMaidenOverCount = 0
                save()
                print("Player Details: \(player)")
            }
        }
        
        let teamDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetails") as! TeamDetailViewController
        
        self.navigationController?.pushViewController(teamDetailsVC, animated: true)
    }
    
    func save() {
        do{
            try RegistrationViewController.context.save()
        }catch{
            print("Error saveing context: ", error)
        }
    }
    
    @IBAction func runningMatchClicked(_ sender: Any) {
        if !RegistrationViewController.userDetails[LoginViewController.userIndex].haveTeam {
            displayAlertMessage(messageToDisplay: "You don't have any team, Please create team first.")
            return
        }
        
        TeamSelectionViewController.isRunningMatch = true
        let scoreBoradVC = self.storyboard?.instantiateViewController(withIdentifier: "ScoreBoardViewController") as! ScoreBoardViewController
        self.navigationController?.pushViewController(scoreBoradVC, animated: true)
        
    }
    
    
}
