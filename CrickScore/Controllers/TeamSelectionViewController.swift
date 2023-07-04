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
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
        
        TeamSelectionViewController.context.delete(<#T##object: NSManagedObject##NSManagedObject#>)
        
        let teamDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetails") as! TeamDetailViewController
        
        self.navigationController?.pushViewController(teamDetailsVC, animated: true)
    }
    
    @IBAction func runningMatchClicked(_ sender: Any) {
        
        TeamSelectionViewController.isRunningMatch = true
        
    }
    
    
}
