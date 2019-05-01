//
//  ChatTableViewCell.swift
//  firestore_test
//
//  Created by Takahiro Ishitsuka  on 2019/05/01.
//  Copyright © 2019 Taka. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(name: String?) {
        nameLabel.text = name
    }
    
    func set(message: String?) {
        messageLabel.text = message
    }
    
}
