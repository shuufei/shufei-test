//
//  SettingViewController.swift
//  palerm
//
//  Created by 花城周平 on 2019/05/28.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var navBarBack: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var scrollView: UIScrollView = UIScrollView()
    var hourBlock: UIScrollView? = nil
    var minutesBlock: UIView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PalermColor.Dark500.UIColor
        navBarBack.backgroundColor = PalermColor.Dark400.UIColor
        navBar.barTintColor = PalermColor.Dark400.UIColor
        navBar.tintColor = .white
        self.setButton()
        self.setView()
    }
    
    func setButton() {
        cancelButton.action = #selector(self.cancel(_:))
    }
    
    func setView() {
        // TODO: Add ScrollView
        self.setHourBlock()
        self.setMinutesBlock()
    }
    
    func setHourBlock() {
        let label = UILabel()
        label.text = "時"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = PalermColor.Dark50.UIColor
        label.sizeToFit()
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        label.topAnchor.constraint(equalTo: self.navBar.bottomAnchor, constant: 24).isActive = true

        let hourBlock = UIScrollView()
        hourBlock.contentOffset = CGPoint(x: 0, y: 0)
        hourBlock.showsHorizontalScrollIndicator = false
        self.view.addSubview(hourBlock)
        hourBlock.translatesAutoresizingMaskIntoConstraints = false
        hourBlock.heightAnchor.constraint(equalToConstant: 60).isActive = true
        hourBlock.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        hourBlock.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        hourBlock.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12).isActive = true
        
        let hourStack = UIStackView()
        hourStack.axis = .horizontal
        hourStack.addBackground(PalermColor.Dark500.UIColor)
        hourStack.distribution = .fillEqually
        hourStack.spacing = 6
        var hours: [UIButton] = []
        let size: CGFloat = 48
        for h in 0...24 {
            let hour = self.createSelectButton(label: String(format: "%02d", h), size: size)
            hours.append(hour)
            hourStack.addArrangedSubview(hour)
        }
        hourStack.frame = CGRect(x: 12, y: 0, width: CGFloat(hours.count)*size+CGFloat((hours.count-1)*6), height: size)
        hourBlock.contentSize = CGSize(width: hourStack.frame.width+24, height: hourStack.frame.height)
        hourBlock.addSubview(hourStack)
        self.hourBlock = hourBlock
//        hourStack.translatesAutoresizingMaskIntoConstraints = false
//        hourStack.leadingAnchor.constraint(equalTo: hourBlock.leadingAnchor, constant: 12).isActive = true
//        hourBlock.addSubview(hour)
    }
    
    func createSelectButton(label: String, size: CGFloat, color: UIColor = PalermColor.Dark100.UIColor) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: size, height: size))
        button.layer.cornerRadius = size / 2
        button.backgroundColor = color
        button.setTitle(label, for: .normal)
        button.setTitleColor(PalermColor.Dark50.UIColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }
    
    func setMinutesBlock() {
        let size: CGFloat = 337
        let minutesBlock = UIView()
        minutesBlock.translatesAutoresizingMaskIntoConstraints = false
        minutesBlock.widthAnchor.constraint(equalToConstant: size).isActive = true
        minutesBlock.heightAnchor.constraint(equalToConstant: size).isActive = true
        minutesBlock.backgroundColor = PalermColor.Dark100.UIColor
        minutesBlock.layer.cornerRadius = CGFloat(size / 2)
        self.view.addSubview(minutesBlock)
        minutesBlock.topAnchor.constraint(equalTo: self.hourBlock!.bottomAnchor, constant: 32).isActive = true
        minutesBlock.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        let holeSize: CGFloat = 197
        let minutesBlockHole = UIView()
        minutesBlockHole.translatesAutoresizingMaskIntoConstraints = false
        minutesBlockHole.widthAnchor.constraint(equalToConstant: holeSize).isActive = true
        minutesBlockHole.heightAnchor.constraint(equalToConstant: holeSize).isActive = true
        minutesBlockHole.backgroundColor = PalermColor.Dark500.UIColor
        minutesBlockHole.layer.cornerRadius = CGFloat(holeSize / 2)
        minutesBlock.addSubview(minutesBlockHole)
        minutesBlockHole.centerXAnchor.constraint(equalTo: minutesBlock.centerXAnchor).isActive = true
        minutesBlockHole.centerYAnchor.constraint(equalTo: minutesBlock.centerYAnchor).isActive = true
        minutesBlock.layoutIfNeeded()
        
        let r: CGFloat = (((size/2)-(holeSize/2))/2)+(holeSize/2)
        let points: [CGPoint] = [
            CGPoint(x: 0, y: -r),
            CGPoint(x: r/2, y: -CGFloat(sqrt(3)/2)*r),
            CGPoint(x: CGFloat(sqrt(3)/2)*r, y: -r/2),
            CGPoint(x: r, y: 0),
            CGPoint(x: CGFloat(sqrt(3)/2)*r, y: r/2),
            CGPoint(x: r/2, y: CGFloat(sqrt(3)/2)*r),
            CGPoint(x: 0, y: r),
            CGPoint(x: -r/2, y: CGFloat(sqrt(3)/2)*r),
            CGPoint(x: -CGFloat(sqrt(3)/2)*r, y: r/2),
            CGPoint(x: -r, y: 0),
            CGPoint(x: -CGFloat(sqrt(3)/2)*r, y: -r/2),
            CGPoint(x: -r/2, y: -CGFloat(sqrt(3)/2)*r)
        ]
        
        for (i, point) in points.enumerated() {
            let minute = self.createSelectButton(label: String(format: "%02d", i*5), size: 50, color: PalermColor.Dark500.UIColor)
            let cPoint = minutesBlock.convert(point, from: self.view)
            print("--- point\(i*5): ", cPoint)
            minute.center = cPoint
            minutesBlock.addSubview(minute)
        }

//        let minute20 = self.createSelectButton(label: String(format: "%02d", 20), size: 50, color: PalermColor.Dark500.UIColor)
//        let point20 = minutesBlock.convert(CGPoint(x: CGFloat(sqrt(3)/2)*r, y: r/2), from: self.view)
//        print("--- point20: ", point20)
//        minute20.center = point20
//        minutesBlock.addSubview(minute20)
        
//        let minute25 = self.createSelectButton(label: String(format: "%02d", 25), size: 50, color: PalermColor.Dark500.UIColor)
//        let point25 = minutesBlock.convert(CGPoint(x: r/2, y: CGFloat(sqrt(3)/2)*r), from: self.view)
//        print("--- point25: ", point25)
//        minute25.center = point25
//        minutesBlock.addSubview(minute25)
//
//        let minute30 = self.createSelectButton(label: String(format: "%02d", 30), size: 50, color: PalermColor.Dark500.UIColor)
//        let point30 = minutesBlock.convert(CGPoint(x: 0, y: r), from: self.view)
//        print("--- point30: ", point30)
//        minute30.center = point30
//        minutesBlock.addSubview(minute30)
//
//        let minute35 = self.createSelectButton(label: String(format: "%02d", 35), size: 50, color: PalermColor.Dark500.UIColor)
//        let point35 = minutesBlock.convert(CGPoint(x: -r/2, y: CGFloat(sqrt(3)/2)*r), from: self.view)
//        print("--- point35: ", point35)
//        minute35.center = point35
//        minutesBlock.addSubview(minute35)
//
//        let minute40 = self.createSelectButton(label: String(format: "%02d", 40), size: 50, color: PalermColor.Dark500.UIColor)
//        let point40 = minutesBlock.convert(CGPoint(x: -CGFloat(sqrt(3)/2)*r, y: r/2), from: self.view)
//        print("--- point40: ", point40)
//        minute40.center = point40
//        minutesBlock.addSubview(minute40)
//
//        let minute45 = self.createSelectButton(label: String(format: "%02d", 45), size: 50, color: PalermColor.Dark500.UIColor)
//        let point45 = minutesBlock.convert(CGPoint(x: -r, y: 0), from: self.view)
//        print("--- point45: ", point45)
//        minute45.center = point45
//        minutesBlock.addSubview(minute45)
        return
    }
    
    @objc func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
