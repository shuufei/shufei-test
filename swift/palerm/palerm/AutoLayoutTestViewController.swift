//
//  AutoLayoutTestViewController.swift
//  palerm
//
//  Created by 花城周平 on 2019/06/12.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit

class AutoLayoutTestViewController: UIViewController {
    
    struct Card {
        var _self: UIStackView
        var foot: UIView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let card = self.createStack()
        let stack = card._self
        super.view.addSubview(stack)
        stack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 56).isActive = true
        stack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        
//        let innerInnerView = UIView()
//        innerInnerView.frame = CGRect(x: 0, y: 0, width: 8, height: 8)
//        innerInnerView.backgroundColor = .red
//        card.foot.addSubview(innerInnerView)
//        innerInnerView.translatesAutoresizingMaskIntoConstraints = false
////        innerInnerView.centerXAnchor.constraint(equalTo: card.foot.centerXAnchor).isActive = true
//        innerInnerView.leadingAnchor.constraint(equalTo: card.foot.leadingAnchor, constant: 40).isActive = true
    }
    
    func createStack() -> Card {
        let stack = UIStackView()
        stack.addBackground(.black)
        stack.axis = .vertical
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:))))
        let innerStack = UIStackView()
        innerStack.addBackground(.lightGray)
//        innerStack.frame = CGRect(x: 0, y: 0, width: 0, height: 20)
        let innerStack2 = UIView()
//        innerStack2.addBackground(.blue)
//        innerStack2.axis = .vertical
//        innerStack2.alignment = .center
//        innerStack2.distribution = .fill
        innerStack2.backgroundColor = .blue
//        innerStack2.frame = CGRect(x: 0, y: 0, width: 0, height: 20)
//        innerStack.translatesAutoresizingMaskIntoConstraints = false
        innerStack.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        innerStack2.translatesAutoresizingMaskIntoConstraints = false
        innerStack2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        let innerInnerView = UIView()
        innerInnerView.frame = CGRect(x: 0, y: 0, width: 8, height: 8)
        innerInnerView.backgroundColor = .red
        innerInnerView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        innerStack2.addSubview(innerInnerView)
//        innerStack2.addArrangedSubview(innerInnerView)
//        innerInnerView.translatesAutoresizingMaskIntoConstraints = false
//        innerInnerView.centerXAnchor.constraint(equalTo: innerStack2.centerXAnchor).isActive = true
        
//        innerInnerStack.addBackground(.red)
//        innerStack2.addSubview(innerInnerStack)
//        innerInnerStack.translatesAutoresizingMaskIntoConstraints = false
//        innerInnerStack.topAnchor.constraint(equalTo: innerStack2.topAnchor, constant: 3).isActive = true
//        innerInnerStack.leadingAnchor.constraint(equalTo: innerStack2.leadingAnchor, constant: 40).isActive = true
//        let c = innerStack2.convert(self.view.center, to: innerStack2)
//        print("--- check center: ", c)
//        innerInnerStack.center.x = self.view.center.x-4
//        innerInnerStack.heightAnchor.constraint(equalToConstant: 5)
        
        stack.addArrangedSubview(innerStack)
        stack.addArrangedSubview(innerStack2)
//        innerStack.topAnchor.constraint(equalTo: stack.topAnchor, constant: 10).isActive = true
        return Card(_self: stack, foot: innerStack2)
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        guard let item = sender.view else {
            return
        }
        let point = item.frame.origin
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
            item.frame.origin = CGPoint(x: point.x+40, y: point.y)
        }, completion: nil)
        
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
