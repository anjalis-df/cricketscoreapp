//
//  MemberAddedForm1ViewController.swift
//  CrickScore
//
//  Created by support on 08/07/23.
//

import UIKit
import CoreData

class MemberAddedFromViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var tableView: UITableView!
    
    var playerCount: [String] = ["A", "B", "C", "D", "E", "F"]
    var indexPath: IndexPath?
    var isSecondTeamMember: Bool? = false
    var memberCount = 0
    static var playerDetails = [PlayerDetails]()
    static var tempPlayerDetails = [PlayerDetails]()
    static var currentMatchUserDetail: UserRegistrationDetails?
    var teamName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        
        
        print("Team Name: \(self.teamName ?? "ToTo")")
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationItem.title = teamName
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white
                              ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.leftBarButtonItem = nil
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
//        navigationItem.rightBarButtonItem?.tintColor = .white
//        navigationItem.rightBarButtonItem?.customView?.backgroundColor

    }
    
    @objc func playerAdded(sender: UIButton) {
        let index = IndexPath(row: sender.tag, section: 0)
        print("Index: \(index)")
        guard let cell = tableView.cellForRow(at: index) as? DynamicTableViewCell else { return }
        cell.addButton.isUserInteractionEnabled = false
        cell.addButton.alpha = 0.5
        var team: String = ""
        if cell.playerName.text == "" {
            print("please enter player name.")
            displayAlertMessage(messageToDisplay: "Please Enter Player Detail")
            return
        }else if cell.mobileNumber.text == "" {
            print("Please enter mobile number.")
            displayAlertMessage(messageToDisplay: "Please Enter Player Detail")
            return
        }
        let player = cell.playerName.text
        print("Inside Player added function.")
        
        
        if isSecondTeamMember == true {
            let MatchDetailsVC = (self.storyboard?.instantiateViewController(withIdentifier: "MatchDetailsID"))! as! MatchDetailsViewController
            team = UserDefaults.standard.string(forKey: "TeamB")!
            print("Team: \(team)")
            let playerDetail = PlayerDetails(context: RegistrationViewController.context)
            playerDetail.playerName = cell.playerName.text
            playerDetail.playerBallCount = 0
            playerDetail.playerFourCount = 0
            playerDetail.playerSixCount = 0
            playerDetail.playerRunCount = 0
            playerDetail.playerOverCount = 0
            playerDetail.playerWicketCount = 0
            playerDetail.wicketStatus = false
            playerDetail.isBatsman = false
            playerDetail.teamName = team
            playerDetail.totalRunCount = 0
            playerDetail.totalBallCount = 0
            playerDetail.playerMaidenOverCount = 0
            playerDetail.parent = RegistrationViewController.userDetails[LoginViewController.userIndex!]
            MemberAddedFromViewController.playerDetails.append(playerDetail)
            save()
            if Int(TeamSelectionViewController.playerCount)!-1 == memberCount{
                loadTempData()
                RegistrationViewController.userDetails[LoginViewController.userIndex!].haveTeam = true
                RegistrationViewController.userDetails[LoginViewController.userIndex!].teamCount = RegistrationViewController.userDetails[LoginViewController.userIndex!].teamCount + 1
                self.navigationController?.pushViewController(MatchDetailsVC, animated: true)
            }
            memberCount += 1
        
        }else {
            team = UserDefaults.standard.string(forKey: "TeamA")!
            print("Team: \(team)")
            let playerDetail = PlayerDetails(context: RegistrationViewController.context)
            playerDetail.playerName = cell.playerName.text
            playerDetail.playerBallCount = 0
            playerDetail.playerFourCount = 0
            playerDetail.playerSixCount = 0
            playerDetail.playerRunCount = 0
            playerDetail.playerOverCount = 0
            playerDetail.playerWicketCount = 0
            playerDetail.wicketStatus = false
            playerDetail.isBatsman = false
            playerDetail.teamName = team
            playerDetail.totalRunCount = 0
            playerDetail.totalBallCount = 0
            playerDetail.playerMaidenOverCount = 0
            playerDetail.parent = RegistrationViewController.userDetails[LoginViewController.userIndex!]
            MemberAddedFromViewController.playerDetails.append(playerDetail)
            save()
            if Int(TeamSelectionViewController.playerCount)!-1 == memberCount{
                TeamDetailViewController.isSecondTeam = true
                self.navigationController?.popViewController(animated: true)
            }
            memberCount += 1
        }
        print("Success")
    }
    
    func save() {
        do{
            try RegistrationViewController.context.save()
        }catch{
            print("Error saveing context: ", error)
        }
    }
    
    func loadTempData() {
        let predicate = NSPredicate(format: "parent.emailId MATCHES %@", (RegistrationViewController.userDetails[LoginViewController.userIndex!].emailId)!)
        
        let request: NSFetchRequest<PlayerDetails> = PlayerDetails.fetchRequest()
        
        request.predicate = predicate
        
        do {
            MemberAddedFromViewController.tempPlayerDetails = try RegistrationViewController.context.fetch(request)
            print("Player Array: \(MemberAddedFromViewController.tempPlayerDetails)")
        }catch {
            print("Error fatching data from context \(error)")
        }
    }

}

extension MemberAddedFromViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150 //Or we can use UITableViw.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(TeamSelectionViewController.playerCount) ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: DynamicTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "DynamicTableViewCell") as? DynamicTableViewCell
        
        if cell == nil {
            cell = Bundle.main.loadNibNamed("DynamicTableViewCell", owner: self, options: nil)?.first as? DynamicTableViewCell
        }
        
        cell?.playerName.delegate = self
        cell?.mobileNumber.delegate = self
        
        cell?.addButton.tag = indexPath.row
        cell?.playerName.tag = indexPath.row
        cell?.mobileNumber.tag = indexPath.row
        self.indexPath = indexPath
        cell?.addButton.addTarget(self, action: #selector(self.playerAdded(sender:)), for: .touchUpInside)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
}
