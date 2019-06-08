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
    let labelSpace: CGFloat = 6
    let timeLabelMaxCount = 4

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = PalermColor.Dark200.UIColor

        let times: [String] = [
            "08:00", "08:05", "08:10", "08:15", "08:20", "08:25", "08:30"
        ]
        let timeCard = createTimeCard(times: times)
        self.timeCard1 = timeCard
        if let timeCardView = timeCard._self {
            timeCardView.frame.origin = CGPoint(x: 16, y: 80) // for debug
            self.view.addSubview(timeCardView)
        }
    }
    
    func createTimeCard(times: [String]) -> TimeCard {
        // create timeCard head
        var timeLabelStacks: [UIStackView] = []
        var timeLabelStacksHeight: CGFloat = 0
        var timeLabelStacksWidth: CGFloat = 0
        let timesStackCount = Int(ceil(Double(times.count) / Double(self.timeLabelMaxCount)))
        for i in 0..<timesStackCount {
            let offset = i*self.timeLabelMaxCount
            let tmpTimes = times.dropFirst(offset).prefix(self.timeLabelMaxCount)
            let stackView = createTimeLabelStack(times: tmpTimes.map{$0})
            timeLabelStacks.append(stackView)
            timeLabelStacksHeight += stackView.frame.height
            if timeLabelStacksWidth < stackView.frame.width {
                timeLabelStacksWidth = stackView.frame.width
            }
        }
        let timeLabelStackWrapper = UIStackView(frame: CGRect(x: 0, y: 200, width: timeLabelStacksWidth, height: timeLabelStacksHeight+(CGFloat(timeLabelStacks.count-1)*self.labelSpace)))
        timeLabelStackWrapper.axis = .vertical
        timeLabelStackWrapper.distribution = .fillEqually
        timeLabelStackWrapper.spacing = labelSpace
        timeLabelStackWrapper.alignment = .leading
        for stack in timeLabelStacks {
            timeLabelStackWrapper.addArrangedSubview(stack)
        }
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
        labelAndSwitcherWrapper.addArrangedSubview(timeLabelStackWrapper)
        labelAndSwitcherWrapper.addArrangedSubview(switcher)

        // create expand view
        let expandView = self.createTimeCardExpandView(times: times, width: labelAndSwitcherWrapper.frame.width)
        let timeCellsHeightConstraints = expandView.heightAnchor.constraint(equalToConstant: 0)
        timeCellsHeightConstraints.isActive = true
        let timeCellsHeight = expandView.frame.height

        // create expand trigger
        let expandTrigger = self.createTimeCardExpandTriggerView(width: labelAndSwitcherWrapper.frame.width)
        let pullIcon = UIImage(named: "pull")
        let imageView = UIImageView(image: pullIcon)
        let point = expandTrigger.convert(expandTrigger.center, from: self.view)
        imageView.frame = CGRect(x:0, y:0, width: 23, height: 9)
        imageView.center = point
        expandTrigger.addSubview(imageView)
        
        // create time card
        let timeCard = UIStackView(frame: CGRect(x:0, y:0, width: labelAndSwitcherWrapper.frame.width, height: labelAndSwitcherWrapper.frame.height+0+expandTrigger.frame.height))
        timeCard.axis = .vertical
        timeCard.distribution = .fill
        timeCard.alignment = .fill
        timeCard.addArrangedSubview(labelAndSwitcherWrapper)
        timeCard.addArrangedSubview(expandView)
        timeCard.addArrangedSubview(expandTrigger)
        return TimeCard(_self: timeCard, head: labelAndSwitcherWrapper, timeCells: expandView, foot: expandTrigger, timeCellsHeight: timeCellsHeight, timeCellsHeightConstraints: timeCellsHeightConstraints, open: false, pullIcon: imageView)
    }
    
    func createTimeCardExpandTriggerView(width: CGFloat) -> UIView {
        let expandView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 30))
        expandView.backgroundColor = PalermColor.Dark500.UIColor
        expandView.layer.cornerRadius = 5
        expandView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        expandView.addBorder(width: 0.5, color: UIKit.UIColor(hexString: "505050")!, position: .top)
        expandView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(self.tapped(_:))
        ))
        return expandView
    }
    
    func createTimeCardExpandView(times: [String], width: CGFloat) -> UIStackView {
        var cells: [UIStackView] = []
        var cellHeight: CGFloat = 0
        for time in times {
            let cell = createTimeCell(time: time, width: width)
            cells.append(cell)
            cellHeight += cell.frame.height
        }
        let timeCellsWrapper = UIStackView(frame: CGRect(x: 0, y: 200, width: width, height: cellHeight))
        timeCellsWrapper.axis = .vertical
        timeCellsWrapper.distribution = .fillEqually
        timeCellsWrapper.alpha = 0
        for cell in cells {
            timeCellsWrapper.addArrangedSubview(cell)
        }
        return timeCellsWrapper
    }
    
    func createTimeLabelStack(times: [String]) -> UIStackView {
        let rect = CGRect(x:0, y:0, width:0, height: 0)
        let stackView = UIStackView(frame: rect)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually // timelabelは同じサイズで良さそうだからfillEquallyで良い
        stackView.spacing = self.labelSpace
        var timeLabelsWidth: CGFloat = 0
        var timeHeight: CGFloat = 0
        times.forEach { time in
            let timeLabel = createTimeLabel(time: time)
            timeLabelsWidth += timeLabel.frame.width
            timeHeight = timeLabel.frame.height
            stackView.addArrangedSubview(timeLabel)
        }
        let stackviewWidth = timeLabelsWidth+(self.labelSpace*CGFloat(times.count-1))
        stackView.frame.size = CGSize(width: stackviewWidth, height: timeHeight)
        stackView.widthAnchor.constraint(equalToConstant: stackviewWidth).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: timeHeight).isActive = true
        return stackView
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
        stackView.addBorder(width: 0.5, color: UIKit.UIColor(hexString: "505050")!, position: .top)
        return stackView
    }
    
    func createTimeLabel(time: String) -> UIView {
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
