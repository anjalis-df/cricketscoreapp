//
//  TeamSelectionViewController.swift
//  CrickScore
//
//  Created by support on 17/03/23.
//

import UIKit

class TeamSelectionViewController: UIViewController {
    
    @IBOutlet var TeamABtn: UIButton!
    @IBOutlet var resetBtn: UIButton!
    @IBOutlet var runningMatch: UIButton!
    
    static var isRunningMatch = false
    
//    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

        TeamABtn.layer.cornerRadius = 45
        resetBtn.layer.cornerRadius = 45
        runningMatch.layer.cornerRadius = 45
        
    }
    
    @IBAction func teamAbuttonClicked(_ sender: Any) {
        let teamDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetails") as! TeamDetailViewController
        
        self.navigationController?.pushViewController(teamDetailsVC, animated: true)
    }
    
    @IBAction func resetGameClicked(_ sender: Any) {
        
        TeamSelectionViewController.isRunningMatch = false
        
      //  TeamSelectionViewController.context.delete(<#T##object: NSManagedObject##NSManagedObject#>)
        
        let currentEmail = UserDefaults.standard.string(forKey: "LastLoggedEmail")
        
        for player in MemberAddedFromViewController.playerDetails {
            if player.parent?.emailId == currentEmail {
                player.ballCount = 0
                player.fourCount = 0
                player.sixCount = 0
                player.runCount = 0
                player.overCount = 0
                player.wicketCount = 0
                player.wicketStatus = false
                player.totalRunCount = 0
                player.totalBallCount = 0
                player.maidenOverCount = 0
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
        
        TeamSelectionViewController.isRunningMatch = true
        let scoreBoradVC = self.storyboard?.instantiateViewController(withIdentifier: "ScoreBoardViewController") as! ScoreBoardViewController
        self.navigationController?.pushViewController(scoreBoradVC, animated: true)
        
    }
    
    
}
