//
//  MemberAddedFromViewController.swift
//  CrickScore
//
//  Created by support on 20/03/23.
//

import UIKit
import CoreData

class MemberAddedFromViewController: UIViewController {
    
    @IBOutlet var playerName1: UITextField!
    @IBOutlet var playerName2: UITextField!
    @IBOutlet var playerName3: UITextField!
    @IBOutlet var playerName4: UITextField!
    @IBOutlet var playerName5: UITextField!
    @IBOutlet var playerName6: UITextField!
    @IBOutlet var playerName7: UITextField!
    @IBOutlet var playerName8: UITextField!
    @IBOutlet var playerName9: UITextField!
    @IBOutlet var playerName10: UITextField!
    
    @IBOutlet var mobileNumber1: UITextField!
    @IBOutlet var mobileNumber2: UITextField!
    @IBOutlet var mobileNumber3: UITextField!
    @IBOutlet var mobileNumber4: UITextField!
    @IBOutlet var mobileNumber5: UITextField!
    @IBOutlet var mobileNumber6: UITextField!
    @IBOutlet var mobileNumber7: UITextField!
    @IBOutlet var mobileNumber8: UITextField!
    @IBOutlet var mobileNumber9: UITextField!
    @IBOutlet var mobileNumber10: UITextField!
    
    var teamName: TeamDetails? 
    var isSecondTeamMember: Bool?

//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var team1Array = [PlayerDetails]()
    static var team2Array = [PlayerDetails]()
    
    static var playerDetails = [PlayerDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Team Name: \(self.teamName!)")
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationItem.title = teamName?.team_name
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white
                              ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.customView?.backgroundColor
    }

    @objc func addTapped(){
        if playerName1.text?.isEmpty == true || playerName2.text?.isEmpty == true || playerName3.text?.isEmpty == true || playerName4.text?.isEmpty == true || playerName5.text?.isEmpty == true || playerName6.text?.isEmpty == true || playerName7.text?.isEmpty == true || playerName8.text?.isEmpty == true || playerName9.text?.isEmpty == true || playerName10.text?.isEmpty == true ||  mobileNumber1.text?.isEmpty == true || mobileNumber2.text?.isEmpty == true || mobileNumber3.text?.isEmpty == true || mobileNumber4.text?.isEmpty == true || mobileNumber5.text?.isEmpty == true || mobileNumber6.text?.isEmpty == true || mobileNumber7.text?.isEmpty == true || mobileNumber8.text?.isEmpty == true || mobileNumber9.text?.isEmpty == true || mobileNumber10.text?.isEmpty == true{
            displayAlertMessage(messageToDisplay: "Please enter all player details.")
            return
        }

        print("Player name: \(self.playerName1.text!)")
        print("Player name: \(self.playerName2.text!)")
        print("Player name: \(self.playerName3.text!)")
        print("Player name: \(self.playerName4.text!)")
        print("Player name: \(self.playerName5.text!)")
        print("Player name: \(self.playerName6.text!)")
        print("Player name: \(self.playerName7.text!)")
        print("Player name: \(self.playerName8.text!)")
        print("Player name: \(self.playerName9.text!)")
        print("Player name: \(self.playerName10.text!)")

        let playerDetails = [
            "playerName1" : self.playerName1.text!,
            "playerName2" : self.playerName2.text!,
            "playerName3" : self.playerName3.text!,
            "playerName4" : self.playerName4.text!,
            "playerName5" : self.playerName5.text!,
            "playerName6" : self.playerName6.text!,
            "playerName7" : self.playerName7.text!,
            "playerName8" : self.playerName8.text!,
            "playerName9" : self.playerName9.text!,
            "playerName10" : self.playerName10.text!
        ]

        UserDefaults.standard.set(playerDetails, forKey: teamName!.team_name!)
        print(UserDefaults.standard.object(forKey: teamName!.team_name!)!)
        let playerDetails1 = UserDefaults.standard.object(forKey: teamName!.team_name!) as! [String: String]
        print("Stored Dict Values: \(playerDetails1)")
        print("One Player: \(playerDetails1["playerName1"] ?? "")")
        
        if isSecondTeamMember == true {
            let MatchDetailsVC = (self.storyboard?.instantiateViewController(withIdentifier: "MatchDetailsID"))! as! MatchDetailsViewController
            var team = UserDefaults.standard.string(forKey: "TeamB")
            print("Team: \(team)")
            
            for playerName in playerDetails {
                print("Name: \(playerName.value)")
                let playerDetail = PlayerDetails(context: TeamSelectionViewController.context)
                playerDetail.name = playerName.value
                playerDetail.ballCount = 0
                playerDetail.fourCount = 0
                playerDetail.sixCount = 0
                playerDetail.runCount = 0
                playerDetail.overCount = 0
                playerDetail.wicketCount = 0
                playerDetail.wicketStatus = false
                playerDetail.isBatsman = false
                playerDetail.teamName = team
                playerDetail.parent = teamName
                MemberAddedFromViewController.team2Array.append(playerDetail)
                MemberAddedFromViewController.playerDetails.append(playerDetail)
                save()
                print("Player Detail: \(playerDetail.parent?.team_name)")
            }
            loadTeam2Details()
            self.navigationController?.pushViewController(MatchDetailsVC, animated: true)
        }else {
            let teamDetailVC = (self.storyboard?.instantiateViewController(identifier: "TeamDetails"))! as TeamDetailViewController
            var team = UserDefaults.standard.string(forKey: "TeamA")
            print("Team: \(team)")
            TeamDetailViewController.isSecondTeam = true
            for playerName in playerDetails {
                print("Name: \(playerName.value)")
                let team = teamName?.team_name
                print("Team Name: \(team ?? "Hello")")
                let playerDetail = PlayerDetails(context: TeamSelectionViewController.context)
                playerDetail.name = playerName.value
                playerDetail.ballCount = 0
                playerDetail.fourCount = 0
                playerDetail.sixCount = 0
                playerDetail.runCount = 0
                playerDetail.overCount = 0
                playerDetail.wicketCount = 0
                playerDetail.wicketStatus = false
                playerDetail.isBatsman = false
                playerDetail.parent = TeamDetailViewController.teamDetailArray[0]
                MemberAddedFromViewController.team1Array.append(playerDetail)
                MemberAddedFromViewController.playerDetails.append(playerDetail)
                save()
                print("Player Detail: \(playerDetail.parent?.team_name)")
            }
            loadTeam1Details()
            self.navigationController?.popViewController(animated: true)
           
        }
        
    }
    
    func save() {
        do{
            try TeamSelectionViewController.context.save()
        }catch{
            print("Error saveing context: ", error)
        }
    }
    
    func loadTeam1Details() {
        let request: NSFetchRequest<PlayerDetails> = PlayerDetails.fetchRequest()
        
        do {
            MemberAddedFromViewController.team1Array = try TeamSelectionViewController.context.fetch(request)
            print("Batsman Details: ", MemberAddedFromViewController.team2Array)
        }catch {
            print("Error fatcing data from context \(error)")
        }
        
    }
    
    func loadTeam2Details() {
        let request: NSFetchRequest<PlayerDetails> = PlayerDetails.fetchRequest()
        
        do {
            MemberAddedFromViewController.team2Array = try TeamSelectionViewController.context.fetch(request)
            print("Bowler Details", MemberAddedFromViewController.team2Array)
        }catch {
            print("Error fatcing data from context \(error)")
        }
    }
}
