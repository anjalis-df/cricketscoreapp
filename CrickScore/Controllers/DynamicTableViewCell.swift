//
//  DynamicTableViewCell.swift
//  CrickScore
//
//  Created by support on 08/07/23.
//

import UIKit

class DynamicTableViewCell: UITableViewCell {
    
    
    @IBOutlet var addButton: UIButton!
    @IBOutlet var playerName: UITextField!
    @IBOutlet var mobileNumber: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
