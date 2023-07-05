//
//  TeamDetailViewController.swift
//  CrickScore
//
//  Created by support on 18/03/23.
//

import UIKit
import CoreData

class TeamDetailViewController: UIViewController {

    @IBOutlet var teamLogo: UIImageView!
    @IBOutlet var teamName: UITextField!
    @IBOutlet var teamBelognsTo: UITextField!
    @IBOutlet var addTeamButton: UIButton!
    @IBOutlet var checkBox: UIButton!
    
    
    
    static var isSecondTeam: Bool = false
 //   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
 //   static var teamDetailArray = [TeamDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hiiiiii")
        teamLogo.layer.cornerRadius = 65
        addTeamButton.layer.cornerRadius = 20
        self.checkBox.isSelected = false
    }

    @IBAction func checkBoxClicked(_ sender: UIButton) {
        self.checkBox.isSelected = !self.checkBox.isSelected
        if self.checkBox.isSelected {
            self.checkBox.setImage(UIImage.init(systemName: "checkmark.square"), for: .selected)
            print("Select")
        }else {
            self.checkBox.setImage(UIImage.init(systemName: "square"), for: .normal)
            print("Deselect")
        }
    }
    
    
    
    @IBAction func addTeamButtonClicked(_ sender: Any) {
        
        if TeamDetailViewController.isSecondTeam == true {
            
            UserDefaults.standard.set(teamName.text, forKey: "TeamB")
            UserDefaults.standard.set(teamBelognsTo.text, forKey: String(teamName.text!))
            
//            let newTeam = TeamDetails(context: context)
//            newTeam.team_name = teamName.text
//
//            TeamDetailViewController.teamDetailArray.append(newTeam)
//            save()
//
            let addMemberVC = self.storyboard?.instantiateViewController(withIdentifier: "MemberAddedFrom") as! MemberAddedFromViewController
//            addMemberVC.teamName = TeamDetailViewController.teamDetailArray[1]
            addMemberVC.isSecondTeamMember = true
            addMemberVC.teamName = self.teamName.text
            self.navigationController?.pushViewController(addMemberVC, animated: true)
        }else {
            UserDefaults.standard.set(teamName.text, forKey: "TeamA")
            UserDefaults.standard.set(teamBelognsTo.text, forKey: String(teamName.text!))
            
            
//            let newTeam = TeamDetails(context: context)
//            newTeam.team_name = teamName.text
//
//            TeamDetailViewController.teamDetailArray.append(newTeam)
//            save()
            
            
            let addMemberVC = self.storyboard?.instantiateViewController(withIdentifier: "MemberAddedFrom") as! MemberAddedFromViewController
//            addMemberVC.teamName = TeamDetailViewController.teamDetailArray[0]
            addMemberVC.isSecondTeamMember = false
            addMemberVC.teamName = self.teamName.text
            self.navigationController?.pushViewController(addMemberVC, animated: true)
        }
        
    }
    
//    func save() {
//        do {
//            try context.save()
//        }catch {
//            print("Error saveing context: ", error)
//        }
//    }
    
//    func loadTeamDetails() {
//        let request: NSFetchRequest<TeamDetails> = TeamDetails.fetchRequest()
//        do {
//            TeamDetailViewController.teamDetailArray = try context.fetch(request)
//            print("Teams: ", TeamDetailViewController.teamDetailArray)
//            showData()
//        }catch {
//            print("Error fatcing data from context \(error)")
//        }
//    }
    
//    func showData() {
//        var teamNames = ""
//        for teamName in TeamDetailViewController.teamDetailArray {
//            teamNames = teamName.team_name! + ", " + teamNames
//            print("Team Name: \(teamNames)")
//        }
//        print("Teams Name: \(teamNames)")
//    }
    
}
