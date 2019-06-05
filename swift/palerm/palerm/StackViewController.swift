//
//  StackViewController.swift
//  palerm
//
//  Created by 花城周平 on 2019/06/01.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit

struct TimeCard {
    var _self: UIStackView?
    let head: UIStackView?
    let timeCells: UIStackView?
    let foot: UIView?
    let timeCellsHeight: CGFloat?
    let timeCellsHeightConstraints: NSLayoutConstraint?
    var open: Bool
    let pullIcon: UIImageView?
}

class StackViewController: UIViewController {
    
    var timeCard1 = TimeCard(_self: nil, head: nil, timeCells: nil, foot: nil, timeCellsHeight: nil, timeCellsHeightConstraints: nil, open: false, pullIcon: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = PalermColor.Dark200.UIColor
        
        let labelSpace: CGFloat = 6
        let rect = CGRect(x:0, y:0, width:0, height: 0)
        let stackView = UIStackView(frame: rect)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually // timelabelは同じサイズで良さそうだからfillEquallyで良い
        stackView.spacing = labelSpace

        let stackView2 = UIStackView(frame: rect)
        stackView2.axis = .horizontal
        stackView2.distribution = .fillEqually
        stackView2.spacing = labelSpace
        
        let times: [String] = [
            "08:00", "08:05", "08:10", "08:15"
        ]
        let times2: [String] = [
            "08:20", "08:25", "08:30"
        ]
        var timeLabelsWidth: CGFloat = 0
        var timeLabelsWidth2: CGFloat = 0
        var timeHeight: CGFloat = 0
        times.forEach { time in
            let timeLabel = createTimeLabel(time: time)
            timeLabelsWidth += timeLabel.frame.width
            timeHeight = timeLabel.frame.height
            stackView.addArrangedSubview(timeLabel)
        }
        times2.forEach { time in
            let timeLabel = createTimeLabel(time: time)
            timeLabelsWidth2 += timeLabel.frame.width
            stackView2.addArrangedSubview(timeLabel)
        }
        print("timelabel height: \(timeHeight), timelabel width: \(timeLabelsWidth)")
        let stackviewWidth = timeLabelsWidth+(labelSpace*CGFloat(times.count-1))
        let stackviewWidth2 = timeLabelsWidth2+(labelSpace*CGFloat(times2.count-1))
        stackView.frame.size = CGSize(width: stackviewWidth, height: timeHeight)
        stackView2.frame.size = CGSize(width: stackviewWidth2, height: timeHeight)
//        stackView.frame.size = CGSize(width: timeLabelsWidth+24, height: timeHeight)
//        stackView2.frame.size = CGSize(width: timeLabelsWidth2+24, height: timeHeight)
//        stackView.center = self.view.center
//        stackView.frame.origin = CGPoint(x: 12, y: 200)
//        let stackView2Y = stackView.frame.maxY + 6
//        stackView2.frame.origin = CGPoint(x: 12, y: stackView2Y)
        
        let timeLabelStackWrapper = UIStackView(frame: CGRect(x: 0, y: 200, width: stackView.frame.width, height: stackView.frame.height+stackView2.frame.height+labelSpace))
        timeLabelStackWrapper.axis = .vertical
        timeLabelStackWrapper.distribution = .fillEqually
        timeLabelStackWrapper.spacing = labelSpace
        timeLabelStackWrapper.alignment = .leading

        stackView.widthAnchor.constraint(equalToConstant: stackviewWidth).isActive = true
        stackView2.widthAnchor.constraint(equalToConstant: stackviewWidth2).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: timeHeight).isActive = true
        stackView2.heightAnchor.constraint(equalToConstant: timeHeight).isActive = true
        
        timeLabelStackWrapper.addArrangedSubview(stackView)
        timeLabelStackWrapper.addArrangedSubview(stackView2)
        
        let switcher = UISwitch(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

        let labelAndSwitcherWrapper = UIStackView(
            frame: CGRect(x: 0, y: 0, width: self.view.frame.width-32, height: timeLabelStackWrapper.frame.height+24)
        )
        labelAndSwitcherWrapper.center = self.view.center
        labelAndSwitcherWrapper.axis = .horizontal
        labelAndSwitcherWrapper.distribution = .equalSpacing
        labelAndSwitcherWrapper.alignment = .top
        labelAndSwitcherWrapper.isLayoutMarginsRelativeArrangement = true
        labelAndSwitcherWrapper.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        labelAndSwitcherWrapper.addBackground(PalermColor.Dark500.UIColor, 5)
        labelAndSwitcherWrapper.layer.cornerRadius = 5

//        timeLabelStackWrapper.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
//        switcher.setContentHuggingPriority(.defaultLow, for: .horizontal)
//        timeLabelStackWrapper.widthAnchor.constraint(equalToConstant: stackView.frame.width)
        labelAndSwitcherWrapper.addArrangedSubview(timeLabelStackWrapper)
        labelAndSwitcherWrapper.addArrangedSubview(switcher)
        
        let timeCell1 = createTimeCell(time: "08:15", width: labelAndSwitcherWrapper.frame.width)
        let timeCell2 = createTimeCell(time: "08:20", width: labelAndSwitcherWrapper.frame.width)
        let timeCellsWrapper = UIStackView(frame: CGRect(x: 0, y: 200, width: labelAndSwitcherWrapper.frame.width, height: timeCell1.frame.height+timeCell2.frame.height))
        timeCellsWrapper.axis = .vertical
        timeCellsWrapper.distribution = .fillEqually
        timeCellsWrapper.addArrangedSubview(timeCell1)
        timeCellsWrapper.addArrangedSubview(timeCell2)
        
        let timeCellsHeight = timeCellsWrapper.frame.height
//        super.view.addSubview(timeCellsWrapper)
        
//        self.view.addSubview(labelAndSwitcherWrapper)
        
        let expandView = UIView(frame: CGRect(x: labelAndSwitcherWrapper.frame.minX, y: labelAndSwitcherWrapper.frame.maxY, width: labelAndSwitcherWrapper.frame.width, height: 30))
        expandView.backgroundColor = PalermColor.Dark500.UIColor
        expandView.layer.cornerRadius = 5
        expandView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        expandView.addBorder(width: 0.5, color: UIKit.UIColor(hexString: "D8D8D8")!, position: .top)
        let pullIcon = UIImage(named: "pull")
        let imageView = UIImageView(image: pullIcon)
        let point = expandView.convert(expandView.center, from: self.view)
        imageView.frame = CGRect(x:0, y:0, width: 23, height: 9)
        imageView.center = point
        expandView.addSubview(imageView)
        
//        imageView.frame.origin = expandView.center
//        super.view.addSubview(imageView)
//        self.view.addSubview(expandView)
//        stackView.frame.origin = CGPoint(x: 50, y: 50)
//        stackView2.frame.origin = CGPoint(x: stackView.frame.minX, y: stackView.frame.maxY+6)
//        stackView.addBackground(.white)
//        stackView2.addBackground(.white)
//        self.view.addSubview(stackView)
//        self.view.addSubview(stackView2)
        
//        let timeCard = UIStackView(frame: CGRect(x:0, y:0, width: labelAndSwitcherWrapper.frame.width, height: labelAndSwitcherWrapper.frame.height+timeCellsWrapper.frame.height+expandView.frame.height))
        let timeCard = UIStackView(frame: CGRect(x:0, y:0, width: labelAndSwitcherWrapper.frame.width, height: labelAndSwitcherWrapper.frame.height+0+expandView.frame.height))
        timeCard.axis = .vertical
        timeCard.distribution = .fill
        timeCard.alignment = .fill
//        timeCellsWrapper.heightAnchor.constraint(equalToConstant: timeCellsWrapper.frame.height).isActive = true
        timeCellsWrapper.alpha = 0
        let timeCellsHeightConstraints = timeCellsWrapper.heightAnchor.constraint(equalToConstant: 0)
        timeCellsHeightConstraints.isActive = true
        timeCard.addArrangedSubview(labelAndSwitcherWrapper)
        timeCard.addArrangedSubview(timeCellsWrapper)
        timeCard.addArrangedSubview(expandView)
//        timeCard.addBackground(.blue)
        
        timeCard.center = self.view.center
        
        self.view.addSubview(timeCard)
        
        self.timeCard1 = TimeCard(_self: timeCard, head: labelAndSwitcherWrapper, timeCells: timeCellsWrapper, foot: expandView, timeCellsHeight: timeCellsHeight, timeCellsHeightConstraints: timeCellsHeightConstraints, open: false, pullIcon: imageView)
        
        expandView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(self.tapped(_:))
        ))
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        if !self.timeCard1.open {
            self.timeCard1.timeCellsHeightConstraints!.constant = self.timeCard1.timeCellsHeight!
            self.timeCard1.timeCells!.alpha = 1
            self.timeCard1.pullIcon!.transform = CGAffineTransform(rotationAngle: CGFloat(180*CGFloat.pi/180))
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                let point = self.timeCard1._self!.frame.origin
                self.timeCard1._self!.frame = CGRect(x:point.x, y:point.y, width: self.timeCard1.timeCells!.frame.width, height: self.timeCard1._self!.frame.height+self.timeCard1.timeCellsHeight!)
                self.view.layoutIfNeeded()
            }, completion: {(_ end: Bool) -> Void in
                self.timeCard1.open = true
            })
        } else {
            self.timeCard1.timeCellsHeightConstraints!.constant = 0
            self.timeCard1.pullIcon!.transform = CGAffineTransform(rotationAngle: CGFloat(0*CGFloat.pi/180))
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                let point = self.timeCard1._self!.frame.origin
                self.timeCard1._self!.frame = CGRect(x:point.x, y:point.y, width: self.timeCard1.timeCells!.frame.width, height: self.timeCard1._self!.frame.height-self.timeCard1.timeCellsHeight!)
                self.view.layoutIfNeeded()
                self.timeCard1.timeCells!.alpha = 0
            }, completion: {(_ end: Bool) -> Void in
                self.timeCard1.open = false
            })
        }
        
    }
    
    func createTimeCell(time: String, width: CGFloat) -> UIStackView {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 200, width: width, height: 54))
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.addBackground(PalermColor.Dark300.UIColor)
        let timeLabel = UILabel()
        timeLabel.text = time
        timeLabel.font = UIFont.systemFont(ofSize: 18)
        timeLabel.textColor = .white
        timeLabel.sizeToFit()
        timeLabel.textAlignment = .left
        let switcher = UISwitch(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(switcher)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        stackView.addBorder(width: 0.5, color: UIKit.UIColor(hexString: "D8D8D8")!, position: .top)
        return stackView
    }
    
    func createTimeLabel(time: String) -> UIView {
//        let labelBackground = UIView(frame: CGRect(x:0, y:0, width: 52, height: 24))
//        labelBackground.backgroundColor = PalermColor.Dark200.UIColor
////        labelBackground.backgroundColor = .red
//        labelBackground.layer.cornerRadius = 3
        let label = TimeLabel(frame: CGRect(x:0, y: 0, width: 0, height: 0))
        label.backgroundColor = PalermColor.Dark200.UIColor
        label.text = time
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        print("labelsize: \(label.frame.size)")
        label.layer.cornerRadius = 3
        label.clipsToBounds = true
        return label
//        labelBackground.addSubview(label)
//        return labelBackground
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


class TimeLabel: UILabel {
    
    @IBInspectable var padding: UIEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    
    override func drawText(in rect: CGRect) {
        rect.inset(by: padding)
        super.drawText(in: rect)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}

extension UIStackView {
    func addBackground(_ color: UIColor, _ cournerRadius: CGFloat = 0) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.cornerRadius = cournerRadius
        subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        insertSubview(subView, at: 0)
    }
}
