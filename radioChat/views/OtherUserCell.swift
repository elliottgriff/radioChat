//
//  OtherUserCell.swift
//  radioChat
//
//  Created by elliott on 4/3/21.
//

import UIKit

class OtherUserCell: UITableViewCell {

    @IBOutlet weak var otherUserView: UIView!
    @IBOutlet weak var otherUserLabel: UILabel!
    @IBOutlet weak var otherText: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        otherUserLabel.adjustsFontSizeToFitWidth = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
