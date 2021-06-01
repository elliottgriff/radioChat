//
//  MessageCell.swift
//  radioChat
//
//  Created by elliott on 3/18/21.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var yourUserView: UIView!
    @IBOutlet weak var yourUserLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        yourUserLabel.adjustsFontSizeToFitWidth = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
