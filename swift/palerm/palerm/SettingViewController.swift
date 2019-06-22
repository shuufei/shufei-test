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
    var scrollViewContentHeight: CGFloat = 0
    
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
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.topAnchor.constraint(equalTo: self.navBar.bottomAnchor).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.setHourBlock()
        self.setMinutesBlock()
//        self.setLoopBlock()
        self.setCells()
        self.scrollViewContentHeight += 48
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollViewContentHeight)
    }
    
    func setHourBlock() {
        let label = UILabel()
        label.text = "時"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = PalermColor.Dark50.UIColor
        label.sizeToFit()
        self.scrollView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 24).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        self.scrollViewContentHeight += label.frame.height+24

        let hourBlock = UIScrollView()
        hourBlock.contentOffset = CGPoint(x: 0, y: 0)
        hourBlock.showsHorizontalScrollIndicator = false
        self.scrollView.addSubview(hourBlock)
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
        for h in 0...23 {
            let hour = self.createSelectButton(label: String(format: "%02d", h), size: size)
            hours.append(hour)
            hourStack.addArrangedSubview(hour)
        }
        hourStack.frame = CGRect(x: 12, y: 0, width: CGFloat(hours.count)*size+CGFloat((hours.count-1)*6), height: size)
        hourBlock.contentSize = CGSize(width: hourStack.frame.width+24, height: hourStack.frame.height)
        hourBlock.addSubview(hourStack)
        self.hourBlock = hourBlock
        self.view.layoutIfNeeded()
        self.scrollViewContentHeight += hourBlock.frame.height+12
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
        let label = UILabel()
        label.text = "分"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = PalermColor.Dark50.UIColor
        label.sizeToFit()
        self.scrollView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.hourBlock!.bottomAnchor, constant: 32).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        let size: CGFloat = 337
        let minutesBlock = UIView()
        minutesBlock.translatesAutoresizingMaskIntoConstraints = false
        minutesBlock.widthAnchor.constraint(equalToConstant: size).isActive = true
        minutesBlock.heightAnchor.constraint(equalToConstant: size).isActive = true
        minutesBlock.backgroundColor = PalermColor.Dark100.UIColor
        minutesBlock.layer.cornerRadius = CGFloat(size / 2)
        self.scrollView.addSubview(minutesBlock)
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
        print("--- r: \(r)")
        // 中心からの座標
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
            let cPoint = minutesBlock.convert(point, from: self.scrollView)
            print("--- point\(i*5): ", cPoint)
            minute.center = cPoint
            minutesBlock.addSubview(minute)
        }
        self.minutesBlock = minutesBlock
        self.scrollViewContentHeight += minutesBlock.frame.height+32
        return
    }
    
    func setCells() {
        let borderTop = UIView()
        borderTop.backgroundColor = UIColor(hexString: "404040")
        self.scrollView.addSubview(borderTop)
        borderTop.translatesAutoresizingMaskIntoConstraints = false
        borderTop.topAnchor.constraint(equalTo: self.minutesBlock!.bottomAnchor, constant: 32).isActive = true
        borderTop.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        borderTop.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        borderTop.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        self.scrollViewContentHeight += 0.5

        let soundCell = UITableViewCell(style: .value1, reuseIdentifier: "sound")
        soundCell.accessoryType = .disclosureIndicator
        soundCell.backgroundColor = PalermColor.Dark300.UIColor
        soundCell.textLabel?.text = "サウンド"
        soundCell.textLabel?.textColor = UIColor(hexString: "efefef")
        soundCell.detailTextLabel?.text = "alerm"
        soundCell.detailTextLabel?.textColor = UIColor(hexString: "8E8E93")
        self.scrollView.addSubview(soundCell)
        soundCell.translatesAutoresizingMaskIntoConstraints = false
        soundCell.topAnchor.constraint(equalTo: borderTop.bottomAnchor).isActive = true
        soundCell.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        soundCell.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        soundCell.heightAnchor.constraint(equalToConstant: 44).isActive = true
//        self.scrollViewContentHeight += soundCell.frame.height+32
        self.scrollViewContentHeight += 44+32
        
        let border = UIView()
        border.backgroundColor = PalermColor.Dark300.UIColor
        self.scrollView.addSubview(border)
        border.translatesAutoresizingMaskIntoConstraints = false
        border.topAnchor.constraint(equalTo: soundCell.bottomAnchor).isActive = true
        border.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        border.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        border.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        let innerBorder = UIView()
        innerBorder.backgroundColor = UIColor(hexString: "404040")
        border.addSubview(innerBorder)
        innerBorder.translatesAutoresizingMaskIntoConstraints = false
        innerBorder.topAnchor.constraint(equalTo: border.topAnchor).isActive = true
        innerBorder.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        innerBorder.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        innerBorder.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        self.scrollViewContentHeight += 0.5
        
        let snoozeCell = UITableViewCell(style: .value1, reuseIdentifier: "snooze")
        snoozeCell.backgroundColor = PalermColor.Dark300.UIColor
        snoozeCell.accessoryView = UISwitch()
        snoozeCell.selectionStyle = .none
        snoozeCell.textLabel?.text = "スヌーズ"
        snoozeCell.textLabel?.textColor = UIColor(hexString: "efefef")
        self.scrollView.addSubview(snoozeCell)
        snoozeCell.translatesAutoresizingMaskIntoConstraints = false
        snoozeCell.topAnchor.constraint(equalTo: border.bottomAnchor).isActive = true
        snoozeCell.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        snoozeCell.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        snoozeCell.heightAnchor.constraint(equalToConstant: 48).isActive = true
//        self.scrollViewContentHeight += snoozeCell.frame.height
        self.scrollViewContentHeight += 48
        
        let borderBottom = UIView()
        borderBottom.backgroundColor = UIColor(hexString: "404040")
        self.scrollView.addSubview(borderBottom)
        borderBottom.translatesAutoresizingMaskIntoConstraints = false
        borderBottom.topAnchor.constraint(equalTo: snoozeCell.bottomAnchor).isActive = true
        borderBottom.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        borderBottom.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        borderBottom.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        self.scrollViewContentHeight += 0.5
        
        
        let deleteBorderTop = UIView()
        deleteBorderTop.backgroundColor = UIColor(hexString: "404040")
        self.scrollView.addSubview(deleteBorderTop)
        deleteBorderTop.translatesAutoresizingMaskIntoConstraints = false
        deleteBorderTop.topAnchor.constraint(equalTo: borderBottom.bottomAnchor, constant: 32).isActive = true
        deleteBorderTop.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        deleteBorderTop.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        deleteBorderTop.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        self.scrollViewContentHeight += 0.5

        let deleteCell = UITableViewCell(style: .default, reuseIdentifier: "delete")
        deleteCell.backgroundColor = PalermColor.Dark300.UIColor
        deleteCell.textLabel?.text = "アラームを削除"
        deleteCell.textLabel?.textColor = .red
        deleteCell.textLabel?.textAlignment = .center
        self.scrollView.addSubview(deleteCell)
        deleteCell.translatesAutoresizingMaskIntoConstraints = false
        deleteCell.heightAnchor.constraint(equalToConstant: 44).isActive = true
        deleteCell.topAnchor.constraint(equalTo: deleteBorderTop.bottomAnchor).isActive = true
        deleteCell.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        deleteCell.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        self.scrollViewContentHeight += deleteCell.frame.height+16
        self.scrollViewContentHeight += 44+32
        
        let delteBorderBottom = UIView()
        delteBorderBottom.backgroundColor = UIColor(hexString: "404040")
        self.scrollView.addSubview(delteBorderBottom)
        delteBorderBottom.translatesAutoresizingMaskIntoConstraints = false
        delteBorderBottom.topAnchor.constraint(equalTo: deleteCell.bottomAnchor).isActive = true
        delteBorderBottom.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        delteBorderBottom.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        delteBorderBottom.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        self.scrollViewContentHeight += 0.5
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
