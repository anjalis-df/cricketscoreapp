//
//  ResultVC.swift
//  CrickScore
//
//  Created by support on 26/07/23.
//

import UIKit

class ResultVC: UIViewController {

    @IBOutlet var team1Name: UILabel!
    @IBOutlet var team1Run: UILabel!
    @IBOutlet var team1Wicket: UILabel!
    @IBOutlet var team1Over: UILabel!
    
    let run1 = ""
    let run2 = ""
    let wicket1 = ""
    let wicket2 = ""
    let over1 = ""
    let over2 = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func okAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
