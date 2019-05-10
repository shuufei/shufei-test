//
//  ViewTutorial.swift
//  helloworldfei
//
//  Created by 花城周平 on 2019/05/04.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit

class ViewTutorial: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let theView = UIView()
//        theView.frame = CGRect(x: 60, y: 100, width: 210, height: 200)
//        theView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.6, alpha: 1.0)
//        theView.clipsToBounds = true
//
//        let labelB = UILabel()
//        labelB.text = "ラベルB"
//        labelB.frame = CGRect(x: 50, y: 50, width: 300, height: 60)
//        labelB.backgroundColor = UIColor.orange
//        labelB.textColor = UIColor.white
//
//        theView.addSubview(labelB)
//        self.view.addSubview(theView)
    }
    @IBOutlet weak var myCar: UIImageView!
    let homePoint = CGPoint(x:100, y:150)
    
    @IBAction func goHome(_ sender: Any) {
        myCar.center = homePoint
    }
    
    @IBAction func move(_ sender: Any) {
        myCar.center.x += 10
    }
    
    let smallFrame = CGRect(x:100, y:150, width:50, height:50)
    let bigFrame = CGRect(x:100, y:150, width:150, height:150)
    @IBAction func changedFrame(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        switch index {
        case 0:
            myCar.frame = smallFrame
        case 1:
            myCar.frame = bigFrame
        default:
            myCar.frame = bigFrame
        }
    }
}
