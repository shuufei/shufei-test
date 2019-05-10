//
//  LongFormTutorial.swift
//  helloworldfei
//
//  Created by 花城周平 on 2019/05/05.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit

class LongFormTutorial: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var myTextFields: [UITextField]!
    
    var editingField: UITextField?
    var lastOffsetY:CGFloat = 0.0
    var overlap:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setScrollView()
        myScrollView.keyboardDismissMode = .onDrag
        
        for fld in myTextFields {
            fld.delegate = self
        }
        
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(self.keyboardChangeFrame(_:)), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
        notification.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(self.keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyboardChangeFrame(_ notification: Notification) {
        guard let fld = editingField else {
            return
        }
        let userInfo = (notification as NSNotification).userInfo!
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let fldFrame = view.convert(fld.frame, from: contentView)
        overlap = fldFrame.maxY - keyboardFrame.minY + 5
        if overlap > 0 {
            overlap += myScrollView.contentOffset.y
            myScrollView.setContentOffset(CGPoint(x:0, y: overlap), animated: true)
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        lastOffsetY = myScrollView.contentOffset.y
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        let baseline = contentView.bounds.height - myScrollView.bounds.height
        lastOffsetY = min(baseline, lastOffsetY)
        myScrollView.setContentOffset(CGPoint(x:0, y:lastOffsetY), animated: true)
    }
    
    func setScrollView() {
        let scrollFrame = CGRect(x:0, y:20, width: view.frame.width, height: view.frame.height-20)
        myScrollView.frame = scrollFrame
        let contentRect = contentView.bounds
        myScrollView.contentSize = CGSize(width:contentRect.width, height:contentRect.height)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        editingField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        editingField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    @IBAction func tapView(_ sender: Any) {
        view.endEditing(true)
    }
}
