//
//  ItemCell.swift
//  helloworldfei
//
//  Created by 花城周平 on 2019/05/09.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var item: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
