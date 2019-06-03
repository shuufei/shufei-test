//
//  AlermTableViewCell.swift
//  palerm
//
//  Created by 花城周平 on 2019/05/30.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit

class AlermTableViewCell: UITableViewCell {
    @IBOutlet weak var alermView: UIView!
    
//    @IBAction func scale(_ sender: UIView) {
//        sender.frame.size = CGSize(width: sender.frame.width, height: 300)
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = PalermColor.Dark200.UIColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapView(_:)))
        alermView.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapView(_ sender: UITapGestureRecognizer) {
//        self.alermView.frame.size = CGSize(width: alermView.frame.width, height: 300)
//        self.layoutIfNeeded()
//        setSelected(true, animated: true)
        self.isSelected = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
