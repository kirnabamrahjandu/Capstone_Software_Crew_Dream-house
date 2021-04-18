//
//  ChatListTableCell.swift
//  Dream House
//
//  Created by DreamHouseTeam Kumar on 09/04/21.
//

import UIKit

class ChatListTableCell: UITableViewCell {
    
    @IBOutlet var backView: UIView!
    @IBOutlet var receiverNamLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
