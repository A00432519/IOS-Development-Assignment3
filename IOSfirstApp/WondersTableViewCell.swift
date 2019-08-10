//
//  WondersTableViewCell.swift
//  IOSfirstApp
//
//  Created by Sidharth Bhalla on 2019-07-20.
//  Copyright © 2019 Sidharth Bhalla. All rights reserved.
//

import UIKit

class WondersTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    

    @IBOutlet weak var newWondersLabel: UILabel!
    @IBOutlet weak var wondersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
