//
//  ScoreBoardViewController.swift
//  CrickScore
//
//  Created by support on 26/04/23.
//

import UIKit
import CoreData

class ScoreBoardViewController: UIViewController {
    
    @IBOutlet var winningTeamName: UILabel!
    
    @IBOutlet var batsman1: UITextField!
    @IBOutlet var batsman2: UITextField!
    @IBOutlet var bowler: UITextField!
    
    @IBOutlet var runOfBatsman1: UILabel!
    @IBOutlet var runOfBatsman2: UILabel!
    
    @IBOutlet var ballbatsman1: UILabel!
    @IBOutlet var ballbatsman2: UILabel!
    
    @IBOutlet var fourOfBatsman1: UILabel!
    @IBOutlet var fourOfBatsman2: UILabel!
    
    @IBOutlet var sixOfBatsman1: UILabel!
    @IBOutlet var sixOfBatsman2: UILabel!
    
    @IBOutlet var bowlerPlayedOver: UILabel!
    @IBOutlet var maidenOver: UILabel!
    @IBOutlet var bowlerRunCount: UILabel!
    @IBOutlet var bowlerWicket: UILabel!
    
    @IBOutlet var zeroOverBall: UIButton!
    @IBOutlet var oneOverBall: UIButton!
    @IBOutlet var twoOverBall: UIButton!
    @IBOutlet var threeOverBall: UIButton!
    @IBOutlet var fourOverBall: UIButton!
    @IBOutlet var sixOverBall: UIButton!
    @IBOutlet var wideBall: UIButton!
    @IBOutlet var noBall: UIButton!
    
    @IBOutlet var totalRunOfTeam1: UILabel!
    @IBOutlet var totalRunOfTeam2: UILabel!
    
    @IBOutlet var totalBallOfTeam1: UILabel!
    @IBOutlet var totalBallOfTeam2: UILabel!
    
    @IBOutlet var totalOverOfTeam1: UILabel!
    @IBOutlet var totalOverOfTeam2: UILabel!
    
    @IBOutlet var submitToBatsman: UIButton!
    @IBOutlet var submitToBowler: UIButton!
    
    var totalFourOfBatsman1: Int! = 0
    var totalFourOfBatsman2: Int! = 0
    
    var totalSixOfBatsman1: Int! = 0
    var totalSixOfBatsman2: Int! = 0
    
    var totalRunOfBatsman1: Int! = 0
    var totalRunOfBatsman2: Int! = 0
    
    var totalBallPlayByBatsman1: Int! = 0
    var totalBallPlayByBatsman2: Int! = 0
    
    var totalFourOfBowler: Int! = 0
    var totalSixOfBowler: Int! = 0
    var totalRunOfBowler: Int! = 0
    var totalBallPlayByBowler: Int! = 0
    var bowlerOverCount: Int! = 0
    var bowlerWicketCount: Int! = 0
    
    var totalBallCount: Int! = 0
    var totalRunCount: Int! = 0
    var totalOverCount: Int! = 0
    var totalWicketCount: Int! = 0
    var maidenOverCount: Int! = 0
    
    var batsman1OnStrike: Bool!
    var batsmanAdded: Bool = false
    var bowlerAdded: Bool = false
    var currentBatsman: String? = ""
    var isCurrentBatsman1: Bool = false
    var wicket : Bool = false
    var runAccordingOver: Int! = 0
    var winningTeamNameForThisVC : String?
    
    var player1WicketStatus: Bool = false
    var player2WicketStatus: Bool = false
    var player1CurrentIndex: Int?
    var player2CurrentIndex: Int?
    
    var batsmanDetailArray = [PlayerDetails]()
    var bowlerDetailArray = [PlayerDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("batsmanDetailArray: \(batsmanDetailArray)")
        print("BowlerDetailArray: \(bowlerDetailArray)")
        
        self.winningTeamName.text = "\(UserDefaults.standard.string(forKey: "TeamA")!) vs \(UserDefaults.standard.string(forKey: "TeamB")!)"
        
        if TeamSelectionViewController.isRunningMatch {
            
            self.loadPlayer()
            
            var batsman1 = ""
            var batsman2 = ""
            var bowler = UserDefaults.standard.string(forKey: "Bowler")
            
            if UserDefaults.standard.string(forKey: "CurrentBatsman") == UserDefaults.standard.string(forKey: "Batsman1") {
                batsman1 = UserDefaults.standard.string(forKey: "Batsman1")!
                batsman2 = UserDefaults.standard.string(forKey: "Batsman2")!
            }else {
                batsman2 = UserDefaults.standard.string(forKey: "Batsman1")!
                batsman1 = UserDefaults.standard.string(forKey: "Batsman2")!
            }
            var tempB1 : PlayerDetails?
            var tempB2 : PlayerDetails?
            var tempBowler : PlayerDetails?
            
            var player1Index : Int?
            var player2Index : Int?
            var bowlerIndex : Int
            var index = 0
            var count = 0
            
            for player in batsmanDetailArray {
                print("Index: \(index)")
                if count == 2{
                    break
                }
                if player.playerName == batsman1 {
                    tempB1 = player
                    player1Index = index
                    count += 1
                }
                if player.playerName == batsman2 {
                    tempB2 = player
                    player2Index = index
                    count += 1
                }
                index += 1
            }
            
            index = 0
            
            for player in bowlerDetailArray {
                if player.playerName == bowler {
                    tempBowler = player
                    break
                }
            }
            
            self.batsman1.text = batsman1
            self.batsman2.text = batsman2
            self.bowler.text = tempBowler?.playerName
            
            self.runOfBatsman1.text = String(batsmanDetailArray[player1Index!].playerRunCount)
            self.runOfBatsman2.text = String(batsmanDetailArray[player2Index!].playerRunCount)
            
            self.ballbatsman1.text = String(batsmanDetailArray[player1Index!].playerBallCount)
            self.ballbatsman2.text = String(batsmanDetailArray[player2Index!].playerBallCount)
            
            self.fourOfBatsman1.text = String(batsmanDetailArray[player1Index!].playerFourCount)
            self.fourOfBatsman2.text = String(batsmanDetailArray[player2Index!].playerFourCount)
            
            self.sixOfBatsman1.text = String(batsmanDetailArray[player1Index!].playerSixCount)
            self.sixOfBatsman2.text = String(batsmanDetailArray[player2Index!].playerSixCount)
            
            
            self.bowlerPlayedOver.text = String(bowlerDetailArray[index].playerOverCount)
            self.maidenOver.text = String(bowlerDetailArray[index].playerMaidenOverCount)
            self.bowlerRunCount.text = String(bowlerDetailArray[index].playerRunCount)
            self.bowlerWicket.text = String(bowlerDetailArray[index].playerWicketCount)
            
            self.totalRunOfTeam1.text = String(bowlerDetailArray[index].totalRunCount)
            self.totalBallOfTeam1.text = String(bowlerDetailArray[index].totalBallCount)
            self.totalOverOfTeam1.text = String(bowlerDetailArray[index].totalOverCount)
            
            
            
        }else {
            
        }
        batsman1.borderStyle = .bezel
        batsman1.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        batsman2.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        bowler.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
            
    }
    
    
    @objc func textFieldDidChange(_ TextField: UITextField){
        print("TextField changed")
    }
    
    @IBAction func battingDetailSubmitted(_ sender: UIButton) {
        if (batsman1.text?.isEmpty == true) || (batsman2.text?.isEmpty == true ){
            self.displayAlertMessage(messageToDisplay: "Please Enter Batsman name.")
            return
        }else if (batsman1.text! == batsman2.text!) {
            self.displayAlertMessage(messageToDisplay: "Enter different name for other player.")
            return
        }
        batsmanAdded = true
        
        let bts = isPlayerinTeam(playerName: batsman1.text!, playerType: "Batsman", Batsman: 1)
        let bts1 = isPlayerinTeam(playerName: batsman2.text!, playerType: "Batsman", Batsman: 2)
        
        if bts && bts1 {
            UserDefaults.standard.set(batsman1.text, forKey: "Batsman1")
            UserDefaults.standard.set(batsman2.text, forKey: "Batsman2")
            submitToBatsman.alpha = 0.5
        //    self.displayAlertMessage(messageToDisplay: "Batsman added successfully.")
            print("BatsMan1 Name: \(batsman1.text!)")
            print("BatsMan2 Name: \(batsman2.text!)")
            batsman1.isUserInteractionEnabled = false
            batsman2.isUserInteractionEnabled = false
            self.bowlerOverCount = 0
            return
        }else {
            self.displayAlertMessage(messageToDisplay: "\(batsman1.text!) and \(batsman2.text!) is not in your team.")
            return
        }
        
       
    }
    
    @IBAction func bowlingDetailSubmitted(_ sender: UIButton) {
        
        if bowler.text?.isEmpty == true {
            self.displayAlertMessage(messageToDisplay: "Please Enter Bowler name.")
            return
        }
        bowlerAdded = true
        
        if isPlayerinTeam(playerName: bowler.text!, playerType: "Bowler") {
            UserDefaults.standard.set(bowler.text, forKey: "Bowler")
            submitToBowler.alpha = 0.5
         //   self.displayAlertMessage(messageToDisplay: "Bowler added successfully")
            print("Bowler Name: \(bowler.text!)")
            bowler.isUserInteractionEnabled = false
            return
        } else {
            self.displayAlertMessage(messageToDisplay: "\(bowler.text!) is not in your team.")
            return
        }
        
    }
    
    @IBAction func scoreOverBallClicked(sender: UIButton) {
        if (batsmanAdded != true) || (bowlerAdded != true) {
            displayAlertMessage(messageToDisplay: "First add Batsman and Bowler detail.")
            return
        }
        
        let score = sender.currentTitle!
        totalBallCount += 1
        totalRunCount += Int(score)!
        totalBallOfTeam1.text = String(totalBallCount)
        if totalBallCount%6 == 0 {
            if runAccordingOver == 0 {
                self.maidenOverCount += 1
                self.maidenOver.text = String(maidenOverCount)
            }
            bowlerOverCount += 1
            runAccordingOver = 0
            totalOverCount += 1
            totalOverOfTeam1.text = String(totalOverCount)
        }
        totalRunOfTeam1.text = String(totalRunCount)
        bowlerPlayedOver.text = String(bowlerOverCount)
        runAccordingOver = runAccordingOver + Int(score)!
        print("Total Ball: \(totalBallCount!)")
        print("Total Run: \(totalRunCount!)")
        print("Total Over: \(totalOverCount!)")
        print("score: \(score)")


        if score == "1" || score == "3"{
            if batsman1.borderStyle == .bezel {
                totalRunOfBatsman1 += Int(score)!
                totalBallPlayByBatsman1 += 1
                totalRunOfBowler += 1
                batsman1.borderStyle = .line
                batsman2.borderStyle = .bezel
                runOfBatsman1.text = String(totalRunOfBatsman1)
                ballbatsman1.text = String(totalBallPlayByBatsman1)
                isCurrentBatsman1 = true
                currentBatsman = batsman1.text!
            }else {
                totalRunOfBatsman2 += Int(score)!
                totalBallPlayByBatsman2 += 1
                totalRunOfBowler += 1
                batsman2.borderStyle = .line
                batsman1.borderStyle = .bezel
                runOfBatsman2.text = String(totalRunOfBatsman2)
                ballbatsman2.text = String(totalBallPlayByBatsman2)
                isCurrentBatsman1 = false
                currentBatsman = batsman2.text!
            }
        }else if score == "2" || score == "4" || score == "6"{
            if batsman1.borderStyle == .bezel {
                if score == "4"{
                    totalFourOfBatsman1 += 1
                    totalFourOfBowler += 1
                    fourOfBatsman1.text = String(totalFourOfBatsman1)
                }else if score == "6" {
                    totalSixOfBatsman1 += 1
                    totalSixOfBowler += 1
                    sixOfBatsman1.text = String(totalSixOfBatsman1)
                }
                totalRunOfBatsman1 += Int(score)!
                totalRunOfBowler += Int(score)!
                totalBallPlayByBatsman1 += 1
                ballbatsman1.text = String(totalBallPlayByBatsman1)
                runOfBatsman1.text = String(totalRunOfBatsman1)
                fourOfBatsman1.text = String(totalFourOfBatsman1)
                sixOfBatsman1.text = String(totalSixOfBatsman1)
                currentBatsman = batsman1.text!
                isCurrentBatsman1 = true
            }else {
                if score == "4" {
                    totalFourOfBatsman2 += 1
                    totalFourOfBowler += 1
                    fourOfBatsman2.text = String(totalFourOfBatsman2)
                }else if score == "6" {
                    totalSixOfBatsman2 += 1
                    totalSixOfBowler += 1
                    sixOfBatsman2.text = String(totalSixOfBatsman2)
                }
                totalRunOfBatsman2 += Int(score)!
                totalRunOfBowler += Int(score)!
                totalBallPlayByBatsman2 += 1
                ballbatsman2.text = String(totalBallPlayByBatsman2)
                runOfBatsman2.text = String(totalRunOfBatsman2)
                fourOfBatsman2.text = String(totalFourOfBatsman2)
                sixOfBatsman2.text = String(totalSixOfBatsman2)
                currentBatsman = batsman2.text!
                isCurrentBatsman1 = false
            }
        }else if score == "WD" {
            self.totalRunCount += 1
            totalRunOfBowler += 1
            self.totalBallCount += 1
            self.totalBallPlayByBowler += 1
        }
        if score == "W" {
            wicket = true
        }else {
            wicket = false
        }
        
        UserDefaults.standard.set(currentBatsman, forKey: "CurrentBatsman")
        
        if isCurrentBatsman1 {
            batsman1OnStrike = true
            print("CurrentBatsman: \(currentBatsman!)")
            setScoreBoard(isBatsman1: true, batsManName: currentBatsman!)
            setScoreBoardForBowler(bowlerName: bowler.text!)
        } else {
            batsman1OnStrike = true
            print("CurrentBatsman: \(currentBatsman!)")
            setScoreBoard(isBatsman1: false, batsManName: currentBatsman!)
            setScoreBoardForBowler(bowlerName: bowler.text!)
        }
        
        print("Current Batsman: \(currentBatsman!)")
        
        
    }
    
    func isPlayerinTeam(playerName: String, playerType: String, Batsman: Int = 0) -> Bool {
        
        if playerType == "Bowler" {
            for player in bowlerDetailArray {
                if player.playerName == playerName {
                    return true
                }
            }
            return false
        }else {
            for player in batsmanDetailArray {
                
                if Batsman == 1 && player.wicketStatus != true {
                    self.player1WicketStatus = true
                }else if Batsman == 2 {
                    self.player2WicketStatus = true
                }else {
                    self.player1WicketStatus = false
                    self.player2WicketStatus = false
                }
                
                if player.playerName == playerName {
                    return true
                }
            }
            return false
        }
    }

    func save() {
        do {
            try RegistrationViewController.context.save()
        }catch {
            print("Error saveing context: ", error)
        }
    }
    
    func loadPlayer() {
        let predicate = NSPredicate(format: "parent.emailId MATCHES %@", (MemberAddedFromViewController.currentMatchUserDetail?.emailId)!)
        
        let request: NSFetchRequest<PlayerDetails> = PlayerDetails.fetchRequest()
        
        request.predicate = predicate
        
        do {
            MemberAddedFromViewController.playerDetails = try RegistrationViewController.context.fetch(request)
            print("Player Array: \(MemberAddedFromViewController.playerDetails)")
        }catch {
            print("Error fatching data from context \(error)")
        }
        
        print("Last Player 1: ", UserDefaults.standard.string(forKey: "Batsman1"))
        print("Last Player 2: ", UserDefaults.standard.string(forKey: "Batsman2"))
        print("Last Bowler: ", UserDefaults.standard.string(forKey: "Bowler"))
        
        let teamA = UserDefaults.standard.string(forKey: "TeamA")
        let teamB = UserDefaults.standard.string(forKey: "TeamB")
        
        self.winningTeamName.text = "\(teamA!) vs \(teamB!)"
        
        let winningTeamName = UserDefaults.standard.string(forKey: "WinningTeam")
        let winningTeamSelection = UserDefaults.standard.string(forKey: winningTeamName!)
        
        print("Team A \(teamA!)")
        print("Team B \(teamB!)")
        print("Winning Team \(winningTeamName!)")
        print("Winning Team Selection \(winningTeamSelection!)")
        
        var i = 0
        var j = 0
        
        if winningTeamSelection == "Bowling" {
            for player in MemberAddedFromViewController.playerDetails {
                if winningTeamName == player.teamName {
                    self.bowlerDetailArray.append(player)
                    i += 1
                }else {
                    self.batsmanDetailArray.append(player)
                    j += 1
                }
            }
            print("Bowler Array: \(self.bowlerDetailArray)")
            print("Batsman Array: \(self.batsmanDetailArray)")
        }else {
            for player in MemberAddedFromViewController.playerDetails{
                if winningTeamName == player.teamName {
                    self.batsmanDetailArray.append(player)
                    i += 1
                }else {
                    self.bowlerDetailArray.append(player)
                    j += 1
                }
            }
            print("Batsman Array: \(self.batsmanDetailArray)")
            print("Bowler Array: \(self.bowlerDetailArray)")
        }
        
    }
    
    
    
    func setScoreBoard(isBatsman1: Bool, batsManName: String) {
        var currentPlayer: PlayerDetails?
        var index = 0
        for player in batsmanDetailArray {
            print("Index: \(index)")
            if batsManName == player.playerName {
                currentPlayer = player
                print("CurrentPlayer: \(currentPlayer)")
                break
            }
            index += 1
        }
        
        print("Player Playing: \(currentPlayer)")
    
        if isBatsman1 {
            currentPlayer?.playerName = currentBatsman
            currentPlayer?.playerBallCount = Int16(self.ballbatsman1.text!) ?? 0
            currentPlayer?.playerRunCount = Int16(self.runOfBatsman1.text!) ?? 0
            currentPlayer?.playerOverCount = Int16(self.totalOverCount)
            currentPlayer?.playerFourCount = Int16(self.fourOfBatsman1.text!) ?? 0
            currentPlayer?.playerSixCount = Int16(self.sixOfBatsman1.text!) ?? 0
            currentPlayer?.totalRunCount = Int16(self.totalRunCount)
            currentPlayer?.totalBallCount = Int16(self.totalBallCount)
            currentPlayer?.totalOverCount = Int16(self.totalOverCount)
            currentPlayer?.wicketStatus = wicket
            currentPlayer?.isBatsman = true
        } else {
            currentPlayer?.playerName = currentBatsman
            currentPlayer?.playerBallCount = Int16(self.ballbatsman2.text!) ?? 0
            currentPlayer?.playerRunCount = Int16(self.runOfBatsman2.text!) ?? 0
            currentPlayer?.playerOverCount = Int16( self.totalOverCount)
            currentPlayer?.playerFourCount = Int16(self.fourOfBatsman2.text!) ?? 0
            currentPlayer?.playerSixCount = Int16(self.sixOfBatsman2.text!) ?? 0
            currentPlayer?.totalRunCount = Int16(self.totalRunCount)
            currentPlayer?.totalBallCount = Int16(self.totalBallCount)
            currentPlayer?.totalOverCount = Int16(self.totalOverCount)
            currentPlayer?.wicketStatus = wicket
            currentPlayer?.isBatsman = true
        }
        self.batsmanDetailArray[index] = currentPlayer!
        self.save()
        print("Batsman Detail: \(batsmanDetailArray[index])")
    }
    
    
    func setScoreBoardForBowler(bowlerName: String) {
        self.totalBallPlayByBowler += 1
        
        var currentBowler: PlayerDetails?
        var index = 0
        for bowler in bowlerDetailArray {
            print("Index: \(index)")
            if bowlerName == bowler.playerName {
                currentBowler = bowler
                print("CurrentPlayer: \(currentBowler)")
                break
            }
            index += 1
        }
        currentBowler?.playerName = bowlerName
        currentBowler?.playerBallCount = Int16(self.totalBallPlayByBowler)
        currentBowler?.playerRunCount = Int16(self.totalRunOfBowler)
        currentBowler?.playerOverCount = Int16(self.totalOverCount)
        currentBowler?.playerFourCount = Int16(self.totalFourOfBowler)
        currentBowler?.playerSixCount = Int16(self.totalSixOfBowler)
        currentBowler?.playerWicketCount = Int16(self.totalWicketCount)
        currentBowler?.totalRunCount = Int16(self.totalRunCount)
        currentBowler?.totalBallCount = Int16(self.totalBallCount)
        currentBowler?.totalOverCount = Int16(self.totalOverCount)
        currentBowler?.playerMaidenOverCount = Int16(self.maidenOverCount)
        currentBowler?.isBatsman = false
        
        self.bowlerDetailArray[index] = currentBowler!
        self.save()
        print("Bowler Detail: \(bowlerDetailArray[index])")
    }
    
    
}
