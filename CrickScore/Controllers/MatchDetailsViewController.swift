//
//  MatchDetailsViewController.swift
//  CrickScore
//
//  Created by support on 10/04/23.
//

import UIKit

class MatchDetailsViewController: UIViewController {

    @IBOutlet var totalOversTextField: UITextField!
    @IBOutlet var tossButton: UIButton!
    @IBOutlet var winningTeamLabel: UILabel!
    @IBOutlet var btnBatting: UIButton!
    @IBOutlet var btnBowling: UIButton!
    
    var winningTeamName: String?
    var isTossButtonClicked: Bool? = false
    
    var scoreBoardVC: ScoreBoardViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Array 1: \(MemberAddedFromViewController.team1Array)")
        print("Array 2: \(MemberAddedFromViewController.team2Array)")
    }

    @IBAction func tossAction(_ sender: UIButton) {
        
        if totalOversTextField.text?.isEmpty == true {
            displayAlertMessage(messageToDisplay: "Please first enter total number of overs.")
            return
        }
        
        let result = Int.random(in: 1...2)
        print("Result: \(result)")
        self.isTossButtonClicked = true
        if result == 1 {
            winningTeamLabel.text = TeamDetailViewController.teamDetailArray[0].team_name
            winningTeamLabel.text = UserDefaults.standard.string(forKey: "TeamA")
            winningTeamName = winningTeamLabel.text!
        }else {
            winningTeamLabel.text = TeamDetailViewController.teamDetailArray[1].team_name
            winningTeamLabel.text = UserDefaults.standard.string(forKey: "TeamB")
            winningTeamName = winningTeamLabel.text!
        }
        
        UserDefaults.standard.set(winningTeamName, forKey: "WinningTeam")
        
        self.tossButton.isUserInteractionEnabled = false
        print("Winning Team: \(winningTeamName)")
        
        scoreBoardVC = self.storyboard?.instantiateViewController(withIdentifier: "ScoreBoardViewController") as! ScoreBoardViewController
        scoreBoardVC?.winningTeamNameForThisVC = winningTeamName
        
        print("Team1 array Parent: \(TeamDetailViewController.teamDetailArray[0].team_name)")
        print("Team2 array Parent: \(TeamDetailViewController.teamDetailArray[1].team_name)")
        
        
    }
    
    @IBAction func battingSelected(_ sender: UIButton) {
        if checkingValidation() == false{
            return
        }
        let teamA = UserDefaults.standard.string(forKey: "TeamA")
        let teamB = UserDefaults.standard.string(forKey: "TeamB")
        var i = 0
        var j = 0
        
        UserDefaults.standard.set("Batting", forKey: winningTeamName!)
        
        if UserDefaults.standard.string(forKey: "TeamA") == winningTeamName {
            for player in MemberAddedFromViewController.playerDetails {
                if teamA == player.teamName {
                    scoreBoardVC?.batsmanDetailArray[i] = player
                    i += 1
                }else {
                    scoreBoardVC?.bowlerDetailArray[j] = player
                    j += 1
                }
            }
        }
        
//        print("Team1 Array: \(MemberAddedFromViewController.team1Array)")
//        print("Team2 Array: \(MemberAddedFromViewController.team2Array)")
//
//        if TeamDetailViewController.teamDetailArray[0].team_name == winningTeamName {
//            scoreBoardVC?.batsmanDetailArray = MemberAddedFromViewController.team1Array
//            scoreBoardVC?.bowlerDetailArray = MemberAddedFromViewController.team2Array
//        }else {
//            scoreBoardVC?.bowlerDetailArray = MemberAddedFromViewController.team1Array
//            scoreBoardVC?.batsmanDetailArray = MemberAddedFromViewController.team2Array
//        }
        
        print(scoreBoardVC?.winningTeamNameForThisVC)
        self.navigationController?.pushViewController(scoreBoardVC!, animated: true)
        
    }
    
    @IBAction func bowlingSelected(_ sender: UIButton) {
        if checkingValidation() == false{
            return
        }
        
        UserDefaults.standard.set("Bowling", forKey: winningTeamName!)
        
        let teamA = UserDefaults.standard.string(forKey: "TeamA")
        let teamB = UserDefaults.standard.string(forKey: "TeamB")
        
        print("Team A \(teamA)")
        print("Team B \(teamB)")
        
        var i = 0
        var j = 0
        
        if UserDefaults.standard.string(forKey: "TeamA") == winningTeamName {
            for player in MemberAddedFromViewController.playerDetails {
                if teamA == player.teamName {
                    scoreBoardVC?.bowlerDetailArray[i] = player
                    i += 1
                }else {
                    scoreBoardVC?.batsmanDetailArray[j] = player
                    j += 1
                }
            }
        }
        
//        print("Team1 Array: \(MemberAddedFromViewController.team1Array)")
//        print("Team2 Array: \(MemberAddedFromViewController.team2Array)")
//
//        if TeamDetailViewController.teamDetailArray[0].team_name == winningTeamName {
//            scoreBoardVC?.batsmanDetailArray = MemberAddedFromViewController.team1Array
//            scoreBoardVC?.bowlerDetailArray = MemberAddedFromViewController.team2Array
//        }else {
//            scoreBoardVC?.bowlerDetailArray = MemberAddedFromViewController.team1Array
//            scoreBoardVC?.batsmanDetailArray = MemberAddedFromViewController.team2Array
//        }
        
//        scoreBoardVC = self.storyboard?.instantiateViewController(withIdentifier: "ScoreBoardViewController") as! ScoreBoardViewController
//        scoreBoardVC?.winningTeamName.text = winningTeamName
        print(scoreBoardVC?.winningTeamNameForThisVC)
        self.navigationController?.pushViewController(scoreBoardVC!, animated: true)
    }
    
    func checkingValidation()-> Bool{
        if totalOversTextField.text?.isEmpty == true {
            displayAlertMessage(messageToDisplay: "Please first enter total number of overs.")
            return false
        }else if isTossButtonClicked == false {
            displayAlertMessage(messageToDisplay: "Please click on toss button first.")
            return false
        }else {
            return true
        }
    }
}
