//
//  ChatListTableCell.swift
//  Dream House
//
//  Created by Prince Kumar on 09/04/21.
//

import UIKit

class ChatListTableCell: UITableViewCell {
    
    @IBOutlet var chatBackView: UIView!
    @IBOutlet var receiverNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
