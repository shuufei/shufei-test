//
//  AnimationViewController.swift
//  helloworldfei
//
//  Created by 花城周平 on 2019/05/06.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    var num = 0
    @IBOutlet weak var countLabel: UILabel!
    
    @objc func step() {
        num += 1
        countLabel.text = String(num)
        UIView.transition(with: countLabel, duration: 0.5, options: [.transitionFlipFromTop], animations: nil, completion: nil)
    }
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
//        let flower = UIImageView(image: UIImage(named: "image"))
//        flower.alpha = 0
//
//        let scaleTransform = CGAffineTransform(scaleX: 0.2, y: 0.2)
//        let rotationTransform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
//        let newTransform = scaleTransform.concatenating(rotationTransform)
//        flower.transform = newTransform
//
//        flower.center = sender.location(in: self.view)
//        view.addSubview(flower)
//
//        UIView.animate(withDuration: 2.0, delay: 0, options: [.curveEaseOut], animations: {
//            flower.alpha = 1.0
//            flower.transform = .identity
//        }, completion: {(finished:Bool) in
//            self.fadeoutAndRemove(flower, newTransform)
//        })
    }
    
    func fadeoutAndRemove(_ view: UIView, _ t: CGAffineTransform) {
        UIView.animate(withDuration: 2.0, delay: 3.0, options: UIView.AnimationOptions(), animations: {
            view.alpha = 0.0
            view.transform = t
        }, completion: {(finished:Bool) in
            view.removeFromSuperview()
        })
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.step), userInfo: nil, repeats: true)
        countLabel.text = String(num)
        
        createView()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var baseView: UIView!
    
    var fromView: UIView!
    var toView: UIView!
    
    @IBAction func nextView(_ sender: Any) {
        UIView.transition(from: fromView, to: toView, duration: 1, options: .transitionFlipFromRight, completion: {_ in
                let tmp = self.fromView
                self.fromView = self.toView
                self.toView = tmp
        })
    }
    func createView() {
        let frame = CGRect(x:0, y:0, width:50, height:50)
        let view1 = UIImageView(image: UIImage(named: "image"))
        view1.frame = frame
        view1.center = CGPoint(x:baseView.bounds.midX, y:baseView.bounds.midY)
        let view2 = UILabel()
        view2.text = "shami-chan"
        view2.frame = CGRect(x:20, y:20, width:100, height:21)
        view2.backgroundColor = .gray
        view2.textColor = .white
        fromView = view1
        toView = view2
        baseView.addSubview(fromView)
        baseView.clipsToBounds = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
