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

let alertTimesList = [
    ["08:00", "08:05", "08:10", "08:15", "08:20", "08:25", "08:30"],
    ["09:30"],
    ["10:10", "10:15", "10:20"]
]

class StackViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var timeCard1 = TimeCard(_self: nil, head: nil, timeCells: nil, foot: nil, timeCellsHeight: nil, timeCellsHeightConstraints: nil, open: false, pullIcon: nil)
    var timeCardList: [TimeCard] = []
    let labelSpace: CGFloat = 6
    let timeLabelMaxCount = 4

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.backgroundColor = PalermColor.Dark200.UIColor
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.view.backgroundColor = PalermColor.Dark200.UIColor
        for (index, alertTimes) in alertTimesList.enumerated() {
            var timeCard: TimeCard?
            if alertTimes.count == 1 {
                timeCard = createTimeCard(time: alertTimes[0])
            } else if 1 < alertTimes.count {
                timeCard = createTimeCard(times: alertTimes)
            }
            if let _timeCard = timeCard {
                if let expandTrigger = _timeCard.foot {
                    expandTrigger.tag = index
                }
                self.timeCardList.append(_timeCard)
            }
        }
        
//        let times: [String] = [
//            //            "08:00", "08:05", "08:10", "08:15", "08:20", "08:25", "08:30"
//            "08:00", "08:05", "08:10"
//            //            "08:00"
//        ]
//        var timeCard: TimeCard?
//        if times.count == 1 {
//            timeCard = createTimeCard(time: times[0])
//        } else if 1 < times.count {
//            timeCard = createTimeCard(times: times)
//        }
//        if let _timeCard = timeCard {
//            self.timeCard1 = _timeCard
//            if let timeCardView = _timeCard._self {
//                timeCardView.frame.origin = CGPoint(x: 16, y: 80) // for debug
//                self.view.addSubview(timeCardView)
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.timeCardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let index = (indexPath as NSIndexPath).row
        cell.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
//        cell.backgroundColor = .lightGray
        cell.selectionStyle = .none
        cell.clipsToBounds = false
        cell.layer.zPosition = CGFloat(1 * index)
        if let timeCardView = self.timeCardList[index]._self {
            var y: CGFloat = 5
            if index == 0 {
                y += 11
            }
            timeCardView.frame.origin = CGPoint(x: 0, y: y)
            timeCardView.center.x = self.view.center.x
            cell.addSubview(timeCardView)
            var topMargin: CGFloat = 5
            if index == 0 {
                topMargin += 11
            }
            timeCardView.topAnchor.constraint(equalTo: cell.topAnchor, constant: topMargin).isActive = true
            timeCardView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 16).isActive = true
            timeCardView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -16).isActive = true
        }
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = (indexPath as NSIndexPath).row
        guard self.timeCardList[index].head != nil else {
            var padding: CGFloat = 10
            if index == 0 {
                padding += 11
            }
//            print("--- return height for row: \(index), \(String(describing: self.timeCardList[index]._self?.frame.height))")
            return (self.timeCardList[index]._self?.frame.height)!+padding
//            return (self.timeCardList[index]._self?.heightAnchor)!+padding
        }
        var height: CGFloat = self.timeCardList[index].head!.frame.height
        if let foot = self.timeCardList[index].foot {
            height += foot.frame.height
        }
        if self.timeCardList[index]._self != nil {
            var padding: CGFloat = 10
            if index == 0 {
                padding += 11
            }
            height += padding
            var expandHeight: CGFloat = 0
            if self.timeCardList[index].timeCellsHeight != nil && self.timeCardList[index].open {
                expandHeight += self.timeCardList[index].timeCellsHeight!
            }
            height += expandHeight
            print("--- return height for row: \(index), \(height)")
            return height
        } else {
            return 0
        }
    }
    
    func createTimeCard(time: String) -> TimeCard {
        let timeLabel = self.createTimeLabelForOne(time: time)
        let switcher = UISwitch(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        switcher.sizeToFit()
//        let labelAndSwitcherWrapper = UIStackView(
//            frame: CGRect(x: 0, y: 0, width: self.view.frame.width-32, height: switcher.frame.height+24)
//        )
        let labelAndSwitcherWrapper = UIStackView()
        labelAndSwitcherWrapper.translatesAutoresizingMaskIntoConstraints = false
        labelAndSwitcherWrapper.heightAnchor.constraint(equalToConstant: switcher.frame.height+24)
        labelAndSwitcherWrapper.axis = .horizontal
        labelAndSwitcherWrapper.distribution = .equalSpacing
        labelAndSwitcherWrapper.alignment = .center
        labelAndSwitcherWrapper.isLayoutMarginsRelativeArrangement = true
        labelAndSwitcherWrapper.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        labelAndSwitcherWrapper.addBackground(PalermColor.Dark500.UIColor, 5, false, true)
        labelAndSwitcherWrapper.addArrangedSubview(timeLabel)
        labelAndSwitcherWrapper.addArrangedSubview(switcher)
        labelAndSwitcherWrapper.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(self.locateSetting(_:))
        ))
        return TimeCard(_self: labelAndSwitcherWrapper, head: nil, timeCells: nil, foot: nil, timeCellsHeight: nil, timeCellsHeightConstraints: nil, open: false, pullIcon: nil)
    }
    
    func createTimeCard(times: [String]) -> TimeCard {
        let timeLabelStackWrapper = self.createTimeStackList(times: times)
        let switcher = UISwitch(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        switcher.sizeToFit()
        let wrapperHeight = timeLabelStackWrapper.frame.height < switcher.frame.height ? switcher.frame.height : timeLabelStackWrapper.frame.height
//        let labelAndSwitcherWrapper = UIStackView(
//            frame: CGRect(x: 0, y: 0, width: self.view.frame.width-32, height: wrapperHeight+24)
//        )
        let labelAndSwitcherWrapper = UIStackView()
        labelAndSwitcherWrapper.translatesAutoresizingMaskIntoConstraints = false
        labelAndSwitcherWrapper.heightAnchor.constraint(equalToConstant: wrapperHeight+24).isActive = true
        labelAndSwitcherWrapper.axis = .horizontal
        labelAndSwitcherWrapper.distribution = .equalSpacing
        labelAndSwitcherWrapper.alignment = .top
        labelAndSwitcherWrapper.isLayoutMarginsRelativeArrangement = true
        labelAndSwitcherWrapper.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        labelAndSwitcherWrapper.addBackground(PalermColor.Dark500.UIColor, 5, true)
        labelAndSwitcherWrapper.addArrangedSubview(timeLabelStackWrapper)
        labelAndSwitcherWrapper.addArrangedSubview(switcher)
        labelAndSwitcherWrapper.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(self.locateSetting(_:))
        ))

        // create expand view
        let expandView = self.createTimeCardExpandView(times: times, width: labelAndSwitcherWrapper.frame.width)
        let timeCellsHeightConstraints = expandView.heightAnchor.constraint(equalToConstant: 0)
        timeCellsHeightConstraints.isActive = true
        let timeCellsHeight = expandView.frame.height

        // create expand trigger
        let borderHeight: CGFloat = 0.5
        let expandTriggerHeight: CGFloat = 30
        let expandTrigger = self.createTimeCardExpandTriggerView(width: labelAndSwitcherWrapper.frame.width)
        expandTrigger.translatesAutoresizingMaskIntoConstraints = false
        expandTrigger.heightAnchor.constraint(equalToConstant: expandTriggerHeight).isActive = true
        let pullIcon = UIImage(named: "pull")
        let imageView = UIImageView(image: pullIcon)
        imageView.frame = CGRect(x:0, y:0, width: 23, height: 9)
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        expandTrigger.addSubview(imageView)
        let expandTriggerBorder = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: borderHeight))
        expandTriggerBorder.backgroundColor = PalermColor.Dark100.UIColor
        let expandTriggerWrapper = UIStackView()
        expandTriggerWrapper.axis = .vertical
        expandTriggerWrapper.distribution = .fill
        expandTriggerWrapper.translatesAutoresizingMaskIntoConstraints = false
        expandTriggerWrapper.heightAnchor.constraint(equalToConstant: expandTriggerHeight+borderHeight).isActive = true
        expandTriggerWrapper.addArrangedSubview(expandTriggerBorder)
        expandTriggerWrapper.addArrangedSubview(expandTrigger)
        expandTriggerWrapper.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(self.tapped(_:))
        ))
        
        // create time card
//        let timeCard = UIStackView(frame: CGRect(x:0, y:0, width: labelAndSwitcherWrapper.frame.width, height: labelAndSwitcherWrapper.frame.height+0+expandTrigger.frame.height))
        let timeCard = UIStackView()
        timeCard.translatesAutoresizingMaskIntoConstraints = false
        timeCard.heightAnchor.constraint(equalToConstant: labelAndSwitcherWrapper.frame.height+expandTriggerWrapper.frame.height)
        timeCard.axis = .vertical
        timeCard.distribution = .fill
        timeCard.alignment = .fill
        timeCard.clipsToBounds = false
        timeCard.addArrangedSubview(labelAndSwitcherWrapper)
        timeCard.addArrangedSubview(expandView)
        timeCard.addArrangedSubview(expandTriggerWrapper)
        timeCard.addBackground(PalermColor.Dark500.UIColor, 5, false, true)
        return TimeCard(_self: timeCard, head: labelAndSwitcherWrapper, timeCells: expandView, foot: expandTriggerWrapper, timeCellsHeight: timeCellsHeight, timeCellsHeightConstraints: timeCellsHeightConstraints, open: false, pullIcon: imageView)
    }
    
    func createTimeStackList(times: [String]) -> UIStackView {
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
        timeLabelStackWrapper.spacing = self.labelSpace
        timeLabelStackWrapper.alignment = .leading
        for stack in timeLabelStacks {
            timeLabelStackWrapper.addArrangedSubview(stack)
        }
        return timeLabelStackWrapper
    }
    
    func createTimeLabelForOne(time: String) -> UILabel {
        let label = UILabel(frame: CGRect(x:0, y: 0, width: 0, height: 0))
        label.text = time
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }
    
    func createTimeCardExpandTriggerView(width: CGFloat) -> UIView {
        let expandView = UIView()
        expandView.backgroundColor = PalermColor.Dark500.UIColor
        expandView.layer.cornerRadius = 5
        expandView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
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
        let timeCellsWrapper = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: cellHeight))
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
        guard let timeCardIndex = sender.view?.tag else {
            return
        }
        let timeCard: TimeCard = self.timeCardList[timeCardIndex]
        guard (timeCard._self != nil), (timeCard.timeCells != nil), (timeCard.timeCellsHeight != nil), (timeCard.timeCellsHeightConstraints != nil), (timeCard.pullIcon != nil) else {
            return
        }
        if !timeCard.open {
            self.tableView.beginUpdates()
            self.toggleOpen(timeCard: &self.timeCardList[timeCardIndex])
            self.tableView.endUpdates()
//            self.view.layoutIfNeeded()
//            self.toggleOpen(timeCard: &self.timeCardList[timeCardIndex])
//            self.tableView.reloadRows(at: [NSIndexPath(row: timeCardIndex, section: 0) as IndexPath], with: .automatic)
            timeCard.timeCellsHeightConstraints?.constant = timeCard.timeCellsHeight ?? 0
            timeCard.timeCells?.alpha = 1
            timeCard.pullIcon?.transform = CGAffineTransform(rotationAngle: CGFloat(180*CGFloat.pi/180))
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                let point = timeCard._self!.frame.origin
                timeCard._self!.frame = CGRect(x:point.x, y:point.y, width: timeCard.timeCells!.frame.width, height: timeCard._self!.frame.height+timeCard.timeCellsHeight!)
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            timeCard.timeCellsHeightConstraints!.constant = 0
            timeCard.pullIcon!.transform = CGAffineTransform(rotationAngle: CGFloat(0*CGFloat.pi/180))
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                let point = timeCard._self!.frame.origin
                timeCard._self!.frame = CGRect(x:point.x, y:point.y, width: timeCard.timeCells!.frame.width, height: timeCard._self!.frame.height-timeCard.timeCellsHeight!)
                self.view.layoutIfNeeded()
                self.tableView.beginUpdates()
                self.toggleOpen(timeCard: &self.timeCardList[timeCardIndex])
                self.tableView.endUpdates()
                timeCard.timeCells!.alpha = 0
            }, completion: nil)
        }
    }
    
    func toggleOpen(timeCard: inout TimeCard) {
        timeCard.open = !timeCard.open
    }
    
    func createTimeCell(time: String, width: CGFloat) -> UIStackView {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: width, height: 54))
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.addBackground(PalermColor.Dark400.UIColor)
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
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.heightAnchor.constraint(lessThanOrEqualToConstant: 0.5).isActive = true
        border.backgroundColor = PalermColor.Dark100.UIColor
        let cell = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 54.5))
        cell.axis = .vertical
        cell.distribution = .fill
        cell.addArrangedSubview(border)
        cell.addArrangedSubview(stackView)
        return cell
    }
    
    func createTimeLabel(time: String) -> UIView {
        let label = TimeLabel(frame: CGRect(x:0, y: 0, width: 0, height: 0))
        label.backgroundColor = PalermColor.Dark200.UIColor
        label.text = time
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.layer.cornerRadius = 3
        label.clipsToBounds = true
        return label
    }
    
    @objc func locateSetting(_ sender: UIStackView) {
        self.performSegue(withIdentifier: "locateSetting", sender: nil)
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
    func addBackground(_ color: UIColor, _ cournerRadius: CGFloat = 0, _ top: Bool = false, _ shadow: Bool = false) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.cornerRadius = cournerRadius
        if top {
            subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        if shadow {
            subView.layer.shadowColor = UIColor.black.cgColor
            subView.layer.shadowOpacity = 0.3
            subView.layer.shadowRadius = 16
            subView.layer.shadowOffset = CGSize(width: 0, height: 5)
        }
        insertSubview(subView, at: 0)
    }
}
