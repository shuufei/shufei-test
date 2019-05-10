//
//  ViewController.swift
//  helloworldfei
//
//  Created by 花城周平 on 2019/05/01.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit

extension UIColor {
    class var wakakusa:UIColor {
        return UIColor(red: 0.6706, green: 0.7882, blue: 0.0, alpha: 1)
    }
    class var beniaka:UIColor {
        return UIColor(red: 0.898, green: 0.0, blue: 0.3098, alpha: 1)
    }
}

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var myLabel: UILabel!
    @IBAction func hello(_ sender: Any) {
        myLabel.text = "こんにちは"
    }
    @IBAction func thankYou(_ sender: Any) {
        myLabel.text = "ありがとう"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let myObj = MyClass()
        myObj.hello()
        
//        createLabel()
//        createButton()
//        print(textField.delegate)
//        textField.delegate = self
//        messageTextField.delegate = self
    }
    
    func createLabel() {
        let myLabel = UILabel()
        myLabel.text = "生成されたラベル"
        myLabel.frame = CGRect(x:50, y:250, width:200, height:21)
        myLabel.textColor = UIColor.blue
        myLabel.backgroundColor = UIColor.lightGray
        view.addSubview(myLabel)
    }
    
    func createButton() {
        let okButton2 = UIButton()
        okButton2.frame = CGRect(x: 50, y: 400, width: 120, height: 120)
        let bkgImage = UIImage(named: "image")
        okButton2.setBackgroundImage(bkgImage, for: .normal)
        okButton2.setTitle("OK", for: .normal)
        okButton2.setTitleColor(UIColor.black, for: .normal)
        okButton2.addTarget(self, action: #selector(ViewController.tapOK(_:)), for: UIControl.Event.touchUpInside)
        view.addSubview(okButton2)
    }

    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBAction func random(_ sender: Any) {
        let num = arc4random_uniform(100)
        numLabel.text = String(num)
    }
    @objc func tapOK(_ sender: Any) {
        print("OK")
    }
    @IBOutlet weak var stepperNumLabel: UILabel!
    @IBAction func changedStepperValue(_ sender: UIStepper) {
        let num = Int(sender.value)
        stepperNumLabel.text = String(num)
    }
    @IBOutlet weak var msgLabel: UILabel!
    @IBAction func changeSwitch(_ sender: UISwitch) {
        msgLabel.isHidden = !sender.isOn
    }
    @IBAction func changedColor(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            colorChip.backgroundColor = UIColor.blue
        case 1:
            colorChip.backgroundColor = UIColor.yellow
        case 2:
            colorChip.backgroundColor = UIColor.green
        default:
            colorChip.backgroundColor = UIColor.blue
        }
    }
    @IBOutlet weak var colorChip: UIView!
    @IBOutlet weak var targetImage: UIImageView!
    @IBAction func changedSlider(_ sender: UISlider) {
        targetImage.alpha = CGFloat(sender.value)
    }
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print("-- check text: \(textField.text), \(range), \(string)")
        let tmpStr = textField.text! as NSString
        let replacedString = tmpStr.replacingCharacters(in: range, with: string)
        if replacedString == "" {
            countLabel.text = "0"
        } else {
            if let num = Int(replacedString) {
                countLabel.text = String(num * 25)
            }
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        countLabel.text = "0"
        return true
    }
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBOutlet weak var messageTextField: UITextField!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    @IBOutlet weak var myPickerView: UIPickerView!
}

class MyClass {
    let msg = "hello"
    func hello() {
        print(msg)
    }
}
