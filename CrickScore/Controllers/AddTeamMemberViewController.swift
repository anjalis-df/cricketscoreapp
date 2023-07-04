//
//  AddTeamMemberViewController.swift
//  CrickScore
//
//  Created by support on 18/03/23.
//

import UIKit

class AddTeamMemberViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func addPlayersInBulkbuttonClicked(_ sender: Any) {
        let playerAddedFrom = self.storyboard?.instantiateViewController(withIdentifier: "MemberAddedFrom")
        self.navigationController?.pushViewController(playerAddedFrom!, animated: true)
    }
    
}
