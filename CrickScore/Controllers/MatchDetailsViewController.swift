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
    var loserTeamName: String?
    var isTossButtonClicked: Bool? = false
    
    var scoreBoardVC: ScoreBoardViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tossAction(_ sender: UIButton) {
        
        if totalOversTextField.text?.isEmpty == true {
            displayAlertMessage(messageToDisplay: "Please first enter total number of overs.")
            return
        }
        
        UserDefaults.standard.set(totalOversTextField.text, forKey: "TotalOvers")
        
        let result = Int.random(in: 1...2)
        print("Result: \(result)")
        self.isTossButtonClicked = true
        if result == 1 {
            winningTeamLabel.text = UserDefaults.standard.string(forKey: "TeamA")
            winningTeamName = winningTeamLabel.text!
            loserTeamName = UserDefaults.standard.string(forKey: "TeamB")
            
        }else {
            winningTeamLabel.text = UserDefaults.standard.string(forKey: "TeamB")
            winningTeamName = winningTeamLabel.text!
            loserTeamName = UserDefaults.standard.string(forKey: "TeamA")
        }
        
        UserDefaults.standard.set(winningTeamName, forKey: "WinningTeam")
        UserDefaults.standard.set(loserTeamName, forKey: "LoserTeam")
        
        print("Winning Team: \(winningTeamName!)")
        
        scoreBoardVC = self.storyboard?.instantiateViewController(withIdentifier: "ScoreBoardViewController") as! ScoreBoardViewController
        scoreBoardVC?.winningTeamNameForThisVC = winningTeamName

    }
    
    @IBAction func battingSelected(_ sender: UIButton) {
        if checkingaOverValidation() == false{
            return
        }
        scoreBoardVC?.teamOfBatsman = UserDefaults.standard.string(forKey: "WinningTeam")!
        scoreBoardVC?.teamOfBowler = UserDefaults.standard.string(forKey: "LoserTeam")!
        UserDefaults.standard.set(winningTeamName, forKey: "BattingTurn")
        
        let teamA = UserDefaults.standard.string(forKey: "TeamA")
        let teamB = UserDefaults.standard.string(forKey: "TeamB")
        
        var i = 0
        var j = 0
        
        UserDefaults.standard.set("Batting", forKey: winningTeamName!)
        
        if UserDefaults.standard.string(forKey: "TeamA") == winningTeamName {
            for player in MemberAddedFromViewController.playerDetails {
                if teamA == player.teamName {
                    scoreBoardVC?.batsmanDetailArray.append(player)
                    i += 1
                    print("Index of Team A: \(i)")
                }else {
                    scoreBoardVC?.bowlerDetailArray.append(player)
                    j += 1
                    print("Index of Team B: \(j)")
                }
            }
        }else {
            for player in MemberAddedFromViewController.playerDetails {
                if teamA == player.teamName {
                    scoreBoardVC?.bowlerDetailArray.append(player)
                    i += 1
                    print("Index of Team A: \(i)")
                }else {
                    scoreBoardVC?.batsmanDetailArray.append(player)
                    j += 1
                    print("Index of Team B: \(j)")
                }
            }
        }
        
        print(scoreBoardVC?.winningTeamNameForThisVC)
        self.navigationController?.pushViewController(scoreBoardVC!, animated: true)
        
    }
    
    @IBAction func bowlingSelected(_ sender: UIButton) {
        if checkingaOverValidation() == false{
            return
        }
        
        scoreBoardVC?.teamOfBatsman = UserDefaults.standard.string(forKey: "LoserTeam")!
        scoreBoardVC?.teamOfBowler = UserDefaults.standard.string(forKey: "WinningTeam")!
        
        UserDefaults.standard.set("Bowling", forKey: winningTeamName!)
        
        let teamA = UserDefaults.standard.string(forKey: "TeamA")
        let teamB = UserDefaults.standard.string(forKey: "TeamB")
        
        print("Team A \(teamA!)")
        print("Team B \(teamB!)")
        
        var i = 0
        var j = 0
        
        if UserDefaults.standard.string(forKey: "TeamA") == winningTeamName {
            for player in MemberAddedFromViewController.playerDetails {
                if teamA == player.teamName {
                    scoreBoardVC?.bowlerDetailArray.append(player)
                    i += 1
                    print("Index of TeamA \(i)")
                }else {
                    scoreBoardVC?.batsmanDetailArray.append(player)
                    j += 1
                    print("Index of TeamB \(j)")
                }
            }
        }else {
            for player in MemberAddedFromViewController.playerDetails {
                if teamA == player.teamName {
                    scoreBoardVC?.batsmanDetailArray.append(player)
                    i += 1
                    print("Index of TeamA \(i)")
                }else {
                    scoreBoardVC?.bowlerDetailArray.append(player)
                    j += 1
                    print("Index of TeamB \(j)")
                }
            }
        }
        print(scoreBoardVC?.winningTeamNameForThisVC)
        self.navigationController?.pushViewController(scoreBoardVC!, animated: true)
    }
    
    func checkingaOverValidation()-> Bool{
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
