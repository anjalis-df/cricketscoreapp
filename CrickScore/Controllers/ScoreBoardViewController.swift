//
//  ScoreBoardViewController.swift
//  CrickScore
//
//  Created by support on 26/04/23.
//

import UIKit
import CoreData

class ScoreBoardViewController: UIViewController {
    
    @IBOutlet var teamAName: UILabel!
    @IBOutlet var teamBName: UILabel!
    @IBOutlet var matchTitle: UILabel!
    
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
    @IBOutlet var bowlerMaidenOver: UILabel!
    @IBOutlet var bowlerRunCount: UILabel!
    @IBOutlet var bowlerWicket: UILabel!
    
    @IBOutlet var zeroOverBall: UIButton!
    @IBOutlet var oneOverBall: UIButton!
    @IBOutlet var twoOverBall: UIButton!
    @IBOutlet var threeOverBall: UIButton!
    @IBOutlet var fourOverBall: UIButton!
    @IBOutlet var sixOverBall: UIButton!
    @IBOutlet var wideBall: UIButton!
    @IBOutlet var wicketOverBall: UIButton!
    
    @IBOutlet var totalRunOfTeam1: UILabel!
    @IBOutlet var totalRunOfTeam2: UILabel!
    
    @IBOutlet var totalBallOfTeam1: UILabel!
    @IBOutlet var totalBallOfTeam2: UILabel!
    
    @IBOutlet var totalOverOfTeam1: UILabel!
    @IBOutlet var totalOverOfTeam2: UILabel!
    
    @IBOutlet var submitToBatsman: UIButton!
    @IBOutlet var submitToBowler: UIButton!
    
    @IBOutlet var nameOfBatsmanTeam: UILabel!
    @IBOutlet var nameOfBowlerTeam: UILabel!
    
    var teamOfBatsman: String = ""
    var teamOfBowler: String = ""
    
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
    var maidenOverCount: Int! = 0
    
    var batsman1OnStrike: Bool!
    var batsmanAdded: Bool = false
    var bowlerAdded: Bool = false
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
    var batsmanDropDownArray = [PlayerDetails]()
    var bowlerDropDownArray = [PlayerDetails]()
    var dropDownArray = [PlayerDetails]()
    var teamScoreDetailArray = [TeamScoreDetails]()
    
    var teamA: String? = ""
    var teamB: String? = ""
    var winningTeam: String? = ""
    var loserTeam: String? = ""
    var totalWicketCount: Int? = 0
    var currentBowler: String? = ""
    var currentBatsman: String? = ""
    var firstBatsmanOnStrike: String? = ""
    var secondBatsmanOnStrike: String? = ""
    var winningTeamSelection: String? = ""
    var isLoserTeamCompletedBatting: String? = ""
    var isWinningTeamCompletedBatting: String? = ""
    var totalOvers: Int? = 0
    var playerCount: Int? = 0
    var battingTurn: String? = ""
    var isWicket: Bool = false
    var isBowlerChanged: Bool = false
    var maximumRunOfLastPlayedTeam = 0
    
    let toolBar = UIToolbar()
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isPlayerinTeam()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .white
        toolBar.barTintColor = .white
        toolBar.sizeToFit()
        
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
        pickerView.overrideUserInterfaceStyle = .light
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector((donePicker)))
        doneButton.tintColor = .blue
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelPicker))
        cancelButton.tintColor = .blue
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        self.batsman1.inputView = pickerView
        self.batsman1.inputAccessoryView = toolBar
        self.batsman2.inputView = pickerView
        self.batsman2.inputAccessoryView = toolBar
        self.bowler.inputView = pickerView
        self.bowler.inputAccessoryView = toolBar
        
        self.batsman1.accessibilityIdentifier = "batsman1"
        self.batsman2.accessibilityIdentifier = "batsman2"
        
        self.loadAllLocalDataFromUserDefaults()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target:self, action: #selector(goBackToTeamSelectionVC))
        
        print("batsmanDetailArray: \(batsmanDetailArray)")
        print("BowlerDetailArray: \(bowlerDetailArray)")
        
        self.matchTitle.text = "\(teamA!) vs \(teamB!)"
        
        if winningTeamSelection == "Batting" {
            self.nameOfBatsmanTeam.text = winningTeam
            self.nameOfBowlerTeam.text = loserTeam
        } else {
            self.nameOfBatsmanTeam.text = winningTeam
            self.nameOfBowlerTeam.text = loserTeam
        }
        
        if totalWicketCount == playerCount {
            displayAlertMessage(messageToDisplay: "Player all out")
        }
        
        batsman1.borderStyle = .bezel
        batsman2.borderStyle = .line
        batsman1.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        batsman2.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        bowler.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
        if TeamSelectionViewController.isRunningMatch {
            self.MatchRunning()
        }
        
        self.teamAName.text = teamA
        self.teamBName.text = teamB
        
        RegistrationViewController.userDetails[LoginViewController.userIndex].haveTeam = true
        print("Have Team: \(RegistrationViewController.userDetails[LoginViewController.userIndex].haveTeam)")
    }
    
   @objc func goBackToTeamSelectionVC() {
        let teamSelectionvc = self.storyboard?.instantiateViewController(withIdentifier: "TeamSelection") as! TeamSelectionViewController
        self.navigationController?.pushViewController(teamSelectionvc, animated: true)
    }
    
    @objc func textFieldDidChange(_ TextField: UITextField){
        print("TextField changed")
    }
    
    @IBAction func battingDetailSubmitted(_ sender: UIButton) {
        
        if totalWicketCount == playerCount {
            MatchFinished()
        }else if totalWicketCount! > 0 && isWicket {
            if batsman1.borderStyle == .bezel {
                totalRunOfBatsman1 = 0
                totalBallPlayByBatsman1 = 0
                totalFourOfBatsman1 = 0
                totalSixOfBatsman1 = 0
                runOfBatsman1.text = "0"
                ballbatsman1.text = "0"
                fourOfBatsman1.text = "0"
                sixOfBatsman1.text = "0"
            }else {
                totalRunOfBatsman2 = 0
                totalBallPlayByBatsman2 = 0
                totalFourOfBatsman2 = 0
                totalSixOfBatsman2 = 0
                runOfBatsman2.text = "0"
                ballbatsman2.text = "0"
                fourOfBatsman2.text = "0"
                sixOfBatsman2.text = "0"
            }
            isWicket = false
        }
        
        if totalWicketCount!-1 == playerCount {
            
        }
        
        
        
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
        
        print("Player 1 out status: \(player1WicketStatus)")
        print("Player 2 out status: \(player2WicketStatus)")
        
        
        
        if bts && bts1 {
            
            if player1WicketStatus{
                displayAlertMessage(messageToDisplay: "\(batsman1.text!) is out. please change batsman.")
                batsman1.borderStyle = .bezel
                batsman2.borderStyle = .line
                return
            }else if player2WicketStatus {
                displayAlertMessage(messageToDisplay: "\(batsman2.text!) is out. please change batsman.")
                batsman2.borderStyle = .bezel
                batsman1.borderStyle = .line
                return
            } else {
                zeroOverBall.isUserInteractionEnabled = true
                oneOverBall.isUserInteractionEnabled = true
                twoOverBall.isUserInteractionEnabled = true
                threeOverBall.isUserInteractionEnabled = true
                fourOverBall.isUserInteractionEnabled = true
                sixOverBall.isUserInteractionEnabled = true
                wideBall.isUserInteractionEnabled = true
                wicketOverBall.isUserInteractionEnabled = true
            }
            
            UserDefaults.standard.set(batsman1.text, forKey: "Batsman1")
            UserDefaults.standard.set(batsman2.text, forKey: "Batsman2")
            submitToBatsman.alpha = 0.5
            print("BatsMan1 Name: \(batsman1.text!)")
            print("BatsMan2 Name: \(batsman2.text!)")
            batsman1.isUserInteractionEnabled = false
            batsman2.isUserInteractionEnabled = false
            submitToBatsman.isUserInteractionEnabled = false
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
        if currentBowler == bowler.text! {
            displayAlertMessage(messageToDisplay: "Over is completed, please change bowler.")
            return
        }
        
        if isPlayerinTeam(playerName: bowler.text!, playerType: "Bowler") {
            UserDefaults.standard.set(bowler.text, forKey: "CurrentBowler")
            submitToBowler.alpha = 0.5
            print("Bowler Name: \(bowler.text!)")
            bowler.isUserInteractionEnabled = false
            submitToBowler.isUserInteractionEnabled = false
            self.maidenOverCount = 0
            self.bowlerOverCount = 0
            self.totalRunOfBowler = 0
            self.bowlerWicketCount = 0
            self.totalBallPlayByBowler = 0
            self.bowlerPlayedOver.text = "0"
            self.bowlerRunCount.text = "0"
            self.bowlerWicket.text = "0"
            self.bowlerPlayedOver.text = "0"
            self.bowlerMaidenOver.text = "0"
            
            zeroOverBall.isUserInteractionEnabled = true
            oneOverBall.isUserInteractionEnabled = true
            twoOverBall.isUserInteractionEnabled = true
            threeOverBall.isUserInteractionEnabled = true
            fourOverBall.isUserInteractionEnabled = true
            sixOverBall.isUserInteractionEnabled = true
            wideBall.isUserInteractionEnabled = true
            wicketOverBall.isUserInteractionEnabled = true
            isBowlerChanged = false
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
        
        if batsman1.borderStyle == .bezel {
            UserDefaults.standard.set(batsman1.text, forKey: "CurrentBatsman")
            currentBatsman = UserDefaults.standard.string(forKey: "CurrentBatsman")
            isCurrentBatsman1 = true
        } else {
            UserDefaults.standard.set(batsman2.text, forKey: "CurrentBatsman")
            currentBatsman = UserDefaults.standard.string(forKey: "CurrentBatsman")
            isCurrentBatsman1 = false
        }
        currentBowler = UserDefaults.standard.string(forKey: "CurrentBowler")
        
        
        if totalBallPlayByBowler > 6 {
            displayAlertMessage(messageToDisplay: "Over is completed, Please change bowler.")
            self.submitToBowler.isUserInteractionEnabled = true
            self.bowler.isUserInteractionEnabled = true
            self.submitToBowler.alpha = 1
            return
        }
        
        var score = sender.currentTitle!
        
        if score == "W" {
            self.totalWicketCount! += 1
            self.bowlerWicketCount += 1
            bowlerWicket.text = String(self.bowlerWicketCount)
            UserDefaults.standard.set(self.totalWicketCount, forKey: "totalWicketCount")
            wicket = true
        }else {
            wicket = false
        }
        
        if score == "W" || score == "WD" {
            score = "0"
        }
        
        totalBallCount += 1
        totalBallPlayByBowler += 1
        totalRunCount += Int(score)!
        totalRunOfBowler += Int(score)!
        bowlerRunCount.text = String(totalRunOfBowler)
        runAccordingOver = runAccordingOver + Int(score)!
        print("Total Ball: \(totalBallCount!)")
        print("Total Run: \(totalRunCount!)")
        print("Total Over: \(totalOverCount!)")
        print("score: \(score)")
        
        
        if score == "1" || score == "3"{
            if batsman1.borderStyle == .bezel {
                totalRunOfBatsman1 += Int(score)!
                totalBallPlayByBatsman1 += 1
                //              totalRunOfBowler += 1
                batsman1.borderStyle = .line
                batsman2.borderStyle = .bezel
                runOfBatsman1.text = String(totalRunOfBatsman1)
                ballbatsman1.text = String(totalBallPlayByBatsman1)
                isCurrentBatsman1 = true
                currentBatsman = batsman1.text!
            }else {
                totalRunOfBatsman2 += Int(score)!
                totalBallPlayByBatsman2 += 1
                //            totalRunOfBowler += 1
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
                //               totalRunOfBowler += Int(score)!
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
                //             totalRunOfBowler += Int(score)!
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
        }
        
        bowlerPlayedOver.text = String(bowlerOverCount)
        
        if teamA == battingTurn {
            totalBallOfTeam1.text = String(totalBallCount)
            totalRunOfTeam1.text = String(totalRunCount)
            totalOverOfTeam1.text = String(totalOverCount)
        } else {
            totalBallOfTeam2.text = String(totalBallCount)
            totalRunOfTeam2.text = String(totalRunCount)
            totalOverOfTeam2.text = String(totalOverCount)
        }
        
        
        UserDefaults.standard.set(currentBatsman, forKey: "CurrentBatsman")
        
        if totalBallCount%6 == 0 {
            if runAccordingOver == 0 {
                self.maidenOverCount += 1
                self.bowlerMaidenOver.text = String(maidenOverCount)
                maidenOverCount = 0
            }
            bowlerOverCount += 1
            runAccordingOver = 0
            totalOverCount += 1
            isBowlerChanged = true
        }
        
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
        
        
        if isLoserTeamCompletedBatting == "true" {
            if totalRunCount == maximumRunOfLastPlayedTeam+1 {
                displayAlertMessage(messageToDisplay: "Match Finished")
                showTeamResultDetial()
                return
            }
        }else if isWinningTeamCompletedBatting == "true" {
            if totalRunCount == maximumRunOfLastPlayedTeam+1 {
                displayAlertMessage(messageToDisplay: "Match Finished")
                showTeamResultDetial()
                return
            }
        }
        
        
        if wicket{
            isWicket = true
            self.isPlayerinTeam()
            if totalWicketCount == playerCount {
                if MatchFinished() {
                    displayAlertMessage(messageToDisplay: "Match is completed, Wait for result")
                    let firstteam = self.teamScoreDetailArray[0].totalBall
                    let secondTeam = self.teamScoreDetailArray[1].totalBall
                    if firstteam > secondTeam {
                        let teamName = self.teamScoreDetailArray[0].teamName
                        displayAlertMessage(messageToDisplay: "\(teamName) won")
                    }else {
                        let teamName = self.teamScoreDetailArray[1].teamName
                        displayAlertMessage(messageToDisplay: "\(teamName) won")
                    }
                }
                return
            }else {
                if totalWicketCount == playerCount! - 1 {
                    if isCurrentBatsman1 {
                        batsman1.text = nil
                        runOfBatsman1.text = "0"
                        ballbatsman1.text = "0"
                        fourOfBatsman1.text = "0"
                        sixOfBatsman1.text = "0"
                        self.totalRunOfBatsman1 = 0
                        self.totalBallPlayByBatsman1 = 0
                        self.totalFourOfBatsman1 = 0
                        self.totalSixOfBatsman1 = 0
                        batsman2.borderStyle = .bezel
                        batsman1.borderStyle = .line
                        UserDefaults.standard.set(batsman2.text, forKey: "CurrentBatsman")
                        self.currentBatsman = UserDefaults.standard.string(forKey: "CurrentBatsman")
                        isCurrentBatsman1 = false
                    }else {
                        batsman2.text = nil
                        runOfBatsman2.text = "0"
                        ballbatsman2.text = "0"
                        fourOfBatsman2.text = "0"
                        sixOfBatsman2.text = "0"
                        totalRunOfBatsman2 = 0
                        totalBallPlayByBatsman2 = 0
                        totalFourOfBatsman2 = 0
                        totalSixOfBatsman2 = 0
                        batsman1.borderStyle = .bezel
                        batsman2.borderStyle = .line
                        UserDefaults.standard.set(batsman1.text, forKey: "CurrentBatsman")
                        self.currentBatsman = UserDefaults.standard.string(forKey: "CurrentBatsman")
                        isCurrentBatsman1 = true
                    }
                }else {
                    displayAlertMessage(messageToDisplay: "Out, please change batsman.")
                    if isCurrentBatsman1 {
                        self.batsman1.isUserInteractionEnabled = true
                        self.batsman2.isUserInteractionEnabled = false
                        self.batsman1.borderStyle = .bezel
                        self.batsman2.borderStyle = .line
                    }else {
                        self.batsman2.isUserInteractionEnabled = true
                        self.batsman1.isUserInteractionEnabled = false
                        self.batsman2.borderStyle = .bezel
                        self.batsman1.borderStyle = .line
                    }
                    submitToBatsman.isUserInteractionEnabled = true
                    submitToBatsman.alpha = 1
                    zeroOverBall.isUserInteractionEnabled = false
                    oneOverBall.isUserInteractionEnabled = false
                    twoOverBall.isUserInteractionEnabled = false
                    threeOverBall.isUserInteractionEnabled = false
                    fourOverBall.isUserInteractionEnabled = false
                    sixOverBall.isUserInteractionEnabled = false
                    wideBall.isUserInteractionEnabled = false
                    wicketOverBall.isUserInteractionEnabled = false
                }
            }
            
        }
        
        if totalOvers == self.totalOverCount && totalOvers != 0 {
          //  displayAlertMessage(messageToDisplay: "\(totalOvers) completed. Now other team will do batting")
            if MatchFinished() {
                displayAlertMessage(messageToDisplay: "Match Finished")
                return
            }else {
                self.swapBothTeam()
                return
            }
        }
        
        if isBowlerChanged {
            displayAlertMessage(messageToDisplay: "Please Change Bowler")
            self.bowler.isUserInteractionEnabled = true
            self.bowlerAdded = false
            self.submitToBowler.isUserInteractionEnabled = true
            self.submitToBowler.alpha = 1
            zeroOverBall.isUserInteractionEnabled = false
            oneOverBall.isUserInteractionEnabled = false
            twoOverBall.isUserInteractionEnabled = false
            threeOverBall.isUserInteractionEnabled = false
            fourOverBall.isUserInteractionEnabled = false
            sixOverBall.isUserInteractionEnabled = false
            wideBall.isUserInteractionEnabled = false
            wicketOverBall.isUserInteractionEnabled = false
        }
        
        print("Current Batsman: \(currentBatsman!)")
        print("Current Bowler: \(currentBowler!)")
        
    }
    
    
    @objc func donePicker(){
        let selectedPlayer = dropDownArray[pickerView.selectedRow(inComponent: 0)]
        if self.batsman1.isEditing {
            self.batsman1.text = selectedPlayer.playerName
        }else if self.batsman2.isEditing{
            self.batsman2.text = selectedPlayer.playerName
        }else {
            self.bowler.text = selectedPlayer.playerName
        }
        self.view.endEditing(true)
        print("Hello")
    }
    
    @objc func cancelPicker() {
        print("Bye")
        view.endEditing(true)
    }
    
    
    func MatchRunning(){
        self.loadPlayer()
        
        if totalWicketCount == playerCount {
            if UserDefaults.standard.string(forKey: "WinningTeam") == "Batting" {
                displayAlertMessage(messageToDisplay: "Team \(winningTeam!) all out")
            }else {
                displayAlertMessage(messageToDisplay: "Team \(loserTeam!) all out")
            }
            self.swapBothTeam()
        }
        
        var batsman1 = ""
        var batsman2 = ""
        var bowler = currentBowler
        
        
        if currentBatsman == firstBatsmanOnStrike {
            self.batsman1.borderStyle = .bezel
            self.batsman2.borderStyle = .line
        }else {
            self.batsman2.borderStyle = .bezel
            self.batsman1.borderStyle = .line
        }
        batsman1 = firstBatsmanOnStrike!
        batsman2 = secondBatsmanOnStrike!
    
        print("Batsman 1: \(batsman1)")
        print("Batsman 2: \(batsman2)")
        var tempBowler : PlayerDetails?
        
        var player1Index : Int?
        var player2Index : Int?
        var bowlerIndex : Int
        var index = 0
        var count = 0
        
        var isBatsman1Out: Bool
        
        for player in batsmanDetailArray {
            print("Index: \(index)")
            if count == 2{
                break
            }
            if player.playerName == batsman1 {
                player1Index = index
                count += 1
            }
            if player.playerName == batsman2 {
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
        self.totalRunOfBatsman1 = Int(runOfBatsman1.text!)
        self.totalRunOfBatsman2 = Int(runOfBatsman2.text!)
        
        self.ballbatsman1.text = String(batsmanDetailArray[player1Index!].playerBallCount)
        self.ballbatsman2.text = String(batsmanDetailArray[player2Index!].playerBallCount)
        self.totalBallPlayByBatsman1 = Int(ballbatsman1.text!)
        self.totalBallPlayByBatsman2 = Int(ballbatsman2.text!)
        
        self.fourOfBatsman1.text = String(batsmanDetailArray[player1Index!].playerFourCount)
        self.fourOfBatsman2.text = String(batsmanDetailArray[player2Index!].playerFourCount)
        self.totalFourOfBatsman1 = Int(fourOfBatsman1.text!)
        self.totalFourOfBatsman2 = Int(fourOfBatsman2.text!)
        
        self.sixOfBatsman1.text = String(batsmanDetailArray[player1Index!].playerSixCount)
        self.sixOfBatsman2.text = String(batsmanDetailArray[player2Index!].playerSixCount)
        self.totalSixOfBatsman1 = Int(sixOfBatsman1.text!)
        self.totalSixOfBatsman2 = Int(sixOfBatsman2.text!)
        
        self.bowlerPlayedOver.text = String(bowlerDetailArray[index].playerOverCount)
        self.bowlerMaidenOver.text = String(bowlerDetailArray[index].playerMaidenOverCount)
        self.bowlerRunCount.text = String(bowlerDetailArray[index].playerRunCount)
        self.bowlerWicket.text = String(bowlerDetailArray[index].playerWicketCount)
        self.bowlerOverCount = Int(bowlerPlayedOver.text!)
        self.totalRunOfBowler = Int(bowlerRunCount.text!)
        self.bowlerWicketCount = Int(bowlerWicket.text!)
        self.maidenOverCount = Int(bowlerMaidenOver.text!)
        
        if teamA == battingTurn {
            print("Total Ball Count: \(batsmanDetailArray[index].totalBallCount)")
            print("Total Run Count: \(batsmanDetailArray[index].totalRunCount)")
            print("Total Over Count: \(batsmanDetailArray[index].totalOverCount)")
            totalBallOfTeam1.text = String(batsmanDetailArray[index].totalBallCount)
            totalRunOfTeam1.text = String(batsmanDetailArray[index].totalRunCount)
            totalOverOfTeam1.text = String(batsmanDetailArray[index].totalOverCount)
            totalRunCount = Int(totalRunOfTeam1.text!)
            totalBallCount = Int(totalBallOfTeam1.text!)
            totalOverCount = Int(totalOverOfTeam1.text!)
            
        } else {
            print("Total Ball Count: \(batsmanDetailArray[index].totalBallCount)")
            print("Total Run Count: \(batsmanDetailArray[index].totalRunCount)")
            print("Total Over Count: \(batsmanDetailArray[index].totalOverCount)")
            totalBallOfTeam2.text = String(batsmanDetailArray[index].totalBallCount)
            totalRunOfTeam2.text = String(batsmanDetailArray[index].totalRunCount)
            totalOverOfTeam2.text = String(batsmanDetailArray[index].totalOverCount)
            totalRunCount = Int(totalRunOfTeam2.text!)
            totalBallCount = Int(totalBallOfTeam2.text!)
            totalOverCount = Int(totalOverOfTeam2.text!)
        }
    
        self.batsmanAdded = true
        self.bowlerAdded = true
    }
    
    func MatchFinished() -> Bool{
        
        self.isLoserTeamCompletedBatting = UserDefaults.standard.string(forKey: "\(loserTeam!)CompletedBatting")
        self.isWinningTeamCompletedBatting = UserDefaults.standard.string(forKey: "\(winningTeam!)CompletedBatting")
        
        if winningTeam == battingTurn {
            UserDefaults.standard.set(true, forKey: "\(winningTeam!)CompletedBatting")
            self.isWinningTeamCompletedBatting = UserDefaults.standard.string(forKey: "\(winningTeam!)CompletedBatting")
        }else {
            UserDefaults.standard.set(true, forKey: "\(loserTeam!)CompletedBatting")
            self.isLoserTeamCompletedBatting = UserDefaults.standard.string(forKey: "\(loserTeam!)CompletedBatting")
        }
        
        
        if isLoserTeamCompletedBatting == "true" && isWinningTeamCompletedBatting == "true" {
            displayAlertMessage(messageToDisplay: "Match Finished")
            return true
        }else {
            self.swapBothTeam()
            return false
        }
    }
    
    func swapBothTeam() {
        
        if winningTeam == battingTurn {
 //           self.displayAlertMessage(messageToDisplay: "Hello..........")
            let teamScoreDetailAlert = UIAlertController(title: "\(winningTeam!)", message: "Score Board", preferredStyle: .alert)
            let teamScoreAlertAction = UIAlertAction(title: "Ok", style: .default) { [self] (_) in
                print("Team Name: ", teamScoreDetailArray[0].teamName!)
                print("Total Run: ", teamScoreDetailArray[0].totalRun)
                print("Total Over: ", teamScoreDetailArray[0].totalOver)
                print("Total Ball: ", teamScoreDetailArray[0].totalBall)
                
                self.maximumRunOfLastPlayedTeam = Int(teamScoreDetailArray[0].totalRun)
                
                batsman1.text = nil
                batsman2.text = nil
                bowler.text = nil
                submitToBowler.isUserInteractionEnabled = true
                submitToBatsman.isUserInteractionEnabled = true
                if teamA == battingTurn {
                    totalRunOfTeam1.text = String(teamScoreDetailArray[0].totalRun)
                    totalBallOfTeam1.text = String(teamScoreDetailArray[0].totalBall)
                    totalOverOfTeam1.text = String(teamScoreDetailArray[0].totalOver)
                }else {
                    totalRunOfTeam2.text = String(teamScoreDetailArray[0].totalRun)
                    totalBallOfTeam2.text = String(teamScoreDetailArray[0].totalBall)
                    totalOverOfTeam2.text = String(teamScoreDetailArray[0].totalOver)
                }
                
                self.teamOfBatsman = winningTeam!
                self.teamOfBowler = loserTeam!
                self.totalFourOfBatsman1 = 0
                self.totalFourOfBatsman2 = 0
                self.totalSixOfBatsman1 = 0
                self.totalSixOfBatsman2 = 0
                self.totalRunOfBatsman1 = 0
                self.totalRunOfBatsman2 = 0
                self.totalBallPlayByBatsman1 = 0
                self.totalBallPlayByBatsman2 = 0
                self.totalFourOfBowler = 0
                self.totalSixOfBowler = 0
                self.totalRunOfBowler = 0
                self.totalBallPlayByBowler = 0
                self.bowlerOverCount = 0
                self.bowlerWicketCount = 0
                self.totalBallCount = 0
                self.totalRunCount = 0
                self.totalOverCount = 0
                self.maidenOverCount = 0
                self.batsmanAdded = false
                self.bowlerAdded = false
                self.isCurrentBatsman1 = false
                self.wicket = false
                self.runAccordingOver = 0
                self.winningTeamNameForThisVC = loserTeam
                self.player1WicketStatus = false
                self.player2WicketStatus = false
                self.player1CurrentIndex = 0
                self.player2CurrentIndex = 0
//                self.winningTeam = loserTeam!
//                self.loserTeam = winningTeam!
                self.totalWicketCount = 0
                self.currentBowler = ""
                self.currentBatsman = ""
                self.winningTeamSelection = UserDefaults.standard.string(forKey: winningTeam!)
                self.isLoserTeamCompletedBatting = "false"
                self.isWinningTeamCompletedBatting = "true"
                self.totalOvers = 0
              //  self.playerCount = 0
                self.battingTurn = UserDefaults.standard.string(forKey: "BattingTurn")
                self.isWicket = false
                self.isBowlerChanged = false
                
                self.submitToBatsman.isUserInteractionEnabled = true
                self.submitToBowler.isUserInteractionEnabled = true
                self.batsman1.isUserInteractionEnabled = true
                self.batsman2.isUserInteractionEnabled = true
                self.bowler.isUserInteractionEnabled = true
                self.submitToBatsman.alpha = 1
                self.submitToBowler.alpha = 1
            }
            teamScoreDetailAlert.addAction(teamScoreAlertAction)
            
            let team = TeamScoreDetails(context: RegistrationViewController.context)
            team.teamName = winningTeam
            team.totalRun = Int16(totalRunCount)
            team.totalBall = Int16(totalBallCount)
            team.totalOver = Int16(totalOverCount)
            self.teamScoreDetailArray.append(team)
            save()
            UserDefaults.standard.set("Bowling", forKey: winningTeam!)
            UserDefaults.standard.set("Batting", forKey: loserTeam!)
            UserDefaults.standard.set(loserTeam, forKey: "BattingTurn")
            self.present(teamScoreDetailAlert, animated: true, completion: nil)
        }else {
      //      UserDefaults.standard.set(true, forKey: "\(winningTeam)CompletedBatting")
            let teamScoreDetailAlert = UIAlertController(title: "\(winningTeam!)", message: "Score Board", preferredStyle: .alert)
            let teamScoreAlertAction = UIAlertAction(title: "Ok", style: .default) { [self] (_) in
                print("Team Name: ", teamScoreDetailArray[0].teamName!)
                print("Total Run: ", teamScoreDetailArray[0].totalRun)
                print("Total Over: ", teamScoreDetailArray[0].totalOver)
                print("Total Ball: ", teamScoreDetailArray[0].totalBall)
                
                batsman1.text = nil
                batsman2.text = nil
                bowler.text = nil
                submitToBowler.isUserInteractionEnabled = true
                submitToBatsman.isUserInteractionEnabled = true
                if teamA == battingTurn {
                    totalRunOfTeam1.text = String(teamScoreDetailArray[0].totalRun)
                    totalBallOfTeam1.text = String(teamScoreDetailArray[0].totalBall)
                    totalOverOfTeam1.text = String(teamScoreDetailArray[0].totalOver)
                }else {
                    totalRunOfTeam2.text = String(teamScoreDetailArray[0].totalRun)
                    totalBallOfTeam2.text = String(teamScoreDetailArray[0].totalBall)
                    totalOverOfTeam2.text = String(teamScoreDetailArray[0].totalOver)
                }
            }
            teamScoreDetailAlert.addAction(teamScoreAlertAction)
            UserDefaults.standard.set(true, forKey: "\(winningTeam!)CompletedBatting")
            
            let team = TeamScoreDetails(context: RegistrationViewController.context)
            team.teamName = loserTeam
            team.totalRun = Int16(totalBallCount)
            team.totalBall = Int16(totalBallCount)
            team.totalOver = Int16(totalOverCount)
            self.teamScoreDetailArray.append(team)
            save()
            UserDefaults.standard.set("Bowling", forKey: loserTeam!)
            UserDefaults.standard.set("Batting", forKey: winningTeam!)
            UserDefaults.standard.set(winningTeam, forKey: "BattingTurn")
            self.present(teamScoreDetailAlert, animated: true, completion: nil)
        }
        
        
        var tempPlayerArray = [PlayerDetails]()
        tempPlayerArray = batsmanDetailArray
        batsmanDetailArray = bowlerDetailArray
        bowlerDetailArray = tempPlayerArray
        
        self.nameOfBowlerTeam.text = winningTeam
        self.nameOfBatsmanTeam.text = loserTeam
        self.batsman1.text = ""
        self.batsman2.text = ""
        self.runOfBatsman1.text = "0"
        self.runOfBatsman2.text = "0"
        self.ballbatsman1.text = "0"
        self.ballbatsman2.text = "0"
        self.fourOfBatsman1.text = "0"
        self.fourOfBatsman2.text = "0"
        self.sixOfBatsman1.text = "0"
        self.sixOfBatsman2.text = "0"
        self.bowlerRunCount.text = "0"
        self.bowlerMaidenOver.text = "0"
        self.bowlerPlayedOver.text = "0"
        self.bowlerWicket.text = "0"
        self.submitToBowler.isUserInteractionEnabled
        
        print("Batsmand Array: \(batsmanDetailArray)")
        print("Bowler Array: \(bowlerDetailArray)")
        self.isPlayerinTeam()
        displayAlertMessage(messageToDisplay: "Now other team will do batting.")
        return
    }
    
    func isPlayerinTeam(playerName: String = "", playerType: String = "", Batsman: Int = 0) -> Bool {
        
        if playerName == "" && playerType == "" {
            self.batsmanDropDownArray = batsmanDetailArray.filter({ player in
                if !player.wicketStatus {
                    return true
                }else {
                    return false
                }
            })
            
            self.bowlerDropDownArray = bowlerDetailArray.filter({ player in
                if player.playerBallCount == 6 {
                    return false
                }else {
                    return true
                }
            })
            return false
        }else {
            
            if playerType == "Bowler" {
                for player in bowlerDetailArray {
                    if player.playerName == playerName {
                        return true
                    }
                }
                return false
            }else {
                for player in batsmanDetailArray {
                    
                    if player.playerName == playerName {
                        if Batsman == 1 {
                            player1WicketStatus = player.wicketStatus
                        }else if Batsman == 2 {
                            player2WicketStatus = player.wicketStatus
                        }
                        return true
                    }
                }
                return false
            }
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
        
        if isWinningTeamCompletedBatting == "true" {
            UserDefaults.standard.set("Bowling", forKey: winningTeamSelection!)
        }
        
        
        print("Last Player 1: ", firstBatsmanOnStrike!)
        print("Last Player 2: ", secondBatsmanOnStrike!)
        print("Last Bowler: ", currentBowler!)
        
        self.matchTitle.text = "\(teamA!) vs \(teamB!)"
        
        print("Team A \(teamA!)")
        print("Team B \(teamB!)")
        print("Winning Team \(winningTeam!)")
        print("Winning Team Selection \(winningTeamSelection!)")
        
        var i = 0
        var j = 0
        
        if winningTeamSelection == "Bowling" {
            for player in MemberAddedFromViewController.playerDetails {
                if winningTeam == player.teamName {
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
                if winningTeam == player.teamName {
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
    
    func loadTeam() {
        let request: NSFetchRequest<TeamScoreDetails> = TeamScoreDetails.fetchRequest()
        
        do {
            self.teamScoreDetailArray = try RegistrationViewController.context.fetch(request)
            print("Player Array: \(self.teamScoreDetailArray)")
        }catch {
            print("Error fatching data from context \(error)")
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
        currentBowler?.playerWicketCount = Int16(self.totalWicketCount!)
        currentBowler?.totalRunCount = Int16(self.totalRunCount)
        currentBowler?.totalBallCount = Int16(self.totalBallCount)
        currentBowler?.totalOverCount = Int16(self.totalOverCount)
        currentBowler?.playerMaidenOverCount = Int16(self.maidenOverCount)
        currentBowler?.isBatsman = false
        
        self.bowlerDetailArray[index] = currentBowler!
        self.save()
        print("Bowler Detail: \(bowlerDetailArray[index])")
    }
    
    func loadAllLocalDataFromUserDefaults() {
        teamA = UserDefaults.standard.string(forKey: "TeamA") ?? ""
        teamB = UserDefaults.standard.string(forKey: "TeamB") ?? ""
        winningTeam = UserDefaults.standard.string(forKey: "WinningTeam") ?? ""
        loserTeam = UserDefaults.standard.string(forKey: "LoserTeam") ?? ""
        totalWicketCount = Int(UserDefaults.standard.string(forKey: "totalWicketCount") ?? "0") ?? 0
        currentBowler = UserDefaults.standard.string(forKey: "CurrentBowler") ?? ""
        currentBatsman = UserDefaults.standard.string(forKey: "CurrentBatsman") ?? ""
        firstBatsmanOnStrike = UserDefaults.standard.string(forKey: "Batsman1") ?? ""
        secondBatsmanOnStrike = UserDefaults.standard.string(forKey: "Batsman2") ?? ""
        totalOvers = Int(UserDefaults.standard.string(forKey: "TotalOvers") ?? "0") ?? 0
        winningTeamSelection = UserDefaults.standard.string(forKey: winningTeam!) ?? ""
        playerCount = Int(UserDefaults.standard.string(forKey: "PlayerCount") ?? "0") ?? 0
        isLoserTeamCompletedBatting = UserDefaults.standard.string(forKey: "\(loserTeam!)CompletedBatting") ?? ""
        isWinningTeamCompletedBatting = UserDefaults.standard.string(forKey: "\(winningTeam!)CompletedBatting") ?? ""
        battingTurn = UserDefaults.standard.string(forKey: "BattingTurn") ?? ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultVC else {return}
        resultVC.team1Name.text = "Test"
        resultVC.team1Run.text = "Test Run"
        resultVC.team1Over.text = "Test Over"
    }
    
    func showTeamResultDetial() {
      //  self.performSegueWithIdentifier("mySegue", sender:sender)
        self.performSegue(withIdentifier: "mySegue", sender: nil)
    }
    
}

extension ScoreBoardViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if batsman1.isEditing || batsman2.isEditing {
            self.dropDownArray = batsmanDropDownArray
        }else {
            self.dropDownArray = bowlerDropDownArray
        }
        return self.dropDownArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dropDownArray[row].playerName
    }
    
}
