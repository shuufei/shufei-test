//
//  SettingViewController.swift
//  palerm
//
//  Created by 花城周平 on 2019/05/28.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct AlermTime {
//    let time: String
    let hour: String
    let min: String
    
    var time: String {
        get {
            return "\(self.hour):\(self.min)"
        }
    }
}

class SettingViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var navBarBack: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    let AlermTimesStoreClass = AlermTimesStore()
    
    var scrollView: UIScrollView = UIScrollView()
    var hourBlock: UIScrollView? = nil
    var minutesBlock: UIView? = nil
    var labelsBlock: UIStackView = UIStackView()
    var loopBlock: UIScrollView? = nil
    var scrollViewContentHeight: CGFloat = 0
    
    var alermTimeHorizonStacks: [UIStackView] = []
    
    var hourList: [CircleCustomButton] = []
    var minList: [CircleCustomButton] = []
    var currentHour: String = ""
    var loopList: [String] = []
    
    var disposable: Disposable? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PalermColor.Dark500.UIColor
        navBarBack.backgroundColor = PalermColor.Dark400.UIColor
        navBar.barTintColor = PalermColor.Dark400.UIColor
        navBar.tintColor = .white
        self.setButton()
        self.setView()
        
        self.disposable = self.AlermTimesStoreClass.list.subscribe(onNext: { alermTimes in
            print("--- changed alerm time list: ", alermTimes)
            self.setAlermTimeLabels(alermTimes)
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.disposable?.dispose()
    }
    
    func setAlermTimeLabels(_ alermTimes: [AlermTime]) {
        for horizonStack in self.alermTimeHorizonStacks {
            horizonStack.removeFromSuperview()
        }
        
        let alermTimeLabelsMaxCount = 3
        let safeAreaWidth = self.view.frame.width - self.view.safeAreaInsets.left-self.view.safeAreaInsets.right
        let alermTimeHorizonStackCount = Int(ceil(Double(alermTimes.count) / Double(alermTimeLabelsMaxCount)))
        for i in 0..<alermTimeHorizonStackCount {
            let offset = i*alermTimeLabelsMaxCount
            let tmpAlermTimes = alermTimes.dropFirst(offset).prefix(alermTimeLabelsMaxCount)
            let sidePadding: CGFloat = 24
            let row = UIStackView()
            row.addBackground(.blue)
            row.axis = .horizontal
            row.distribution = .equalSpacing
            row.spacing = 8
            
            let alermTimeLabelWidth =  (safeAreaWidth-CGFloat(sidePadding*2)-CGFloat(8*(alermTimeLabelsMaxCount-1)))/3
            for tmpAlermTime in tmpAlermTimes {
                print("time: \(tmpAlermTime.time)")
                let alermTimeLabel = UIView()
                alermTimeLabel.backgroundColor = UIColor(hexString: "3f3f3f")
                alermTimeLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
                alermTimeLabel.widthAnchor.constraint(equalToConstant: alermTimeLabelWidth).isActive = true
                row.addArrangedSubview(alermTimeLabel)
            }
            self.labelsBlock.addArrangedSubview(row)
            self.alermTimeHorizonStacks.append(row)
        }
        self.view.layoutIfNeeded()
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollViewContentHeight + self.labelsBlock.frame.height)
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
        self.setLabelsBlock()
        self.setLoopBlock()
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
        
        let format = DateFormatter()
        format.dateFormat = DateFormatter.dateFormat(fromTemplate: "H", options: 0, locale: .current)
        let hh = format.string(from: Date())
        
        let hourStack = UIStackView()
        hourStack.axis = .horizontal
        hourStack.addBackground(PalermColor.Dark500.UIColor)
        hourStack.distribution = .fillEqually
        let stackSpacing: CGFloat = 6
        hourStack.spacing = stackSpacing
        var hours: [UIButton] = []
        let size: CGFloat = 48
        let stackPadding: CGFloat = 12
        for h in 0...23 {
            let label = String(format: "%02d", h)
            let hour = self.createSelectButton(label: label, size: size, type: .Hour)
            if label == hh {
                self.currentHour = label
                hour.setOn(true)
                let xOffset = ((size+stackSpacing)*CGFloat(h)) - (self.view.center.x) + (size/2) + (stackPadding)
                hourBlock.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
            }
            self.hourList.append(hour)
            hour.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:))))
            hours.append(hour)
            hourStack.addArrangedSubview(hour)
        }
        hourStack.frame = CGRect(x: stackPadding, y: 0, width: CGFloat(hours.count)*size+CGFloat((hours.count-1)*6), height: size)
        hourBlock.contentSize = CGSize(width: hourStack.frame.width+(stackPadding*2), height: hourStack.frame.height)
        hourBlock.addSubview(hourStack)
        self.hourBlock = hourBlock
        self.view.layoutIfNeeded()
        self.scrollViewContentHeight += hourBlock.frame.height+12
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        guard let button = sender.view as? CircleCustomButton else {
            return
        }
        switch button.type {
        case .Hour:
            self.currentHour = button.titleLabel?.text ?? ""
            self.changeHour()
            break
        case .Minute:
            guard self.currentHour != "", let min = button.titleLabel?.text else {
                return
            }
            if button.active {
                let removed = self.AlermTimesStoreClass.remove(hour: self.currentHour, min: min)
                if removed {
                    button.toggle(button)
                }
            } else {
                let appended = self.AlermTimesStoreClass.append(alermTime: AlermTime(hour: self.currentHour, min: min))
                if appended {
                    button.toggle(button)
                }
            }
            break
        case .Week:
            guard let w = button.titleLabel?.text else {
                return
            }
            if button.active {
                for (index, week) in loopList.enumerated() {
                    if week == w {
                        self.loopList.remove(at: index)
                        break
                    }
                }
            } else {
                self.loopList.append(w)
            }
            button.toggle(button)
            break
        }
//        for alermTime in self.AlermTimesStoreClass.get() {
//            print("time list: ", alermTime.time)
//        }
        print("loop list: ", self.loopList)
    }
    
    func changeHour() {
        for h in self.hourList {
            guard let label = h.titleLabel?.text, label != self.currentHour else {
                h.setOn(true)
                h.occureImpact(style: .light)
                continue
            }
            h.setOn(false)
        }
        for min in self.minList {
            guard let label = min.titleLabel?.text else {
                continue
            }
            var on = false
            for alermTime in self.AlermTimesStoreClass.get() {
                if self.currentHour == alermTime.hour, alermTime.min == label {
                    on = true
                }
            }
            min.setOn(on)
        }
    }
    
    func createSelectButton(label: String, size: CGFloat, color: UIColor = PalermColor.Dark100.UIColor, type: CircleCustomButtonType) -> CircleCustomButton {
        let button = CircleCustomButton(size: size, color: color, label: label, type: type)
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
//        print("--- r: \(r)")
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
            let minute = self.createSelectButton(label: String(format: "%02d", i*5), size: 50, color: PalermColor.Dark500.UIColor, type: .Minute)
            self.minList.append(minute)
            let cPoint = minutesBlock.convert(point, from: self.scrollView)
//            print("--- point\(i*5): ", cPoint)
            minute.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:))))
            minute.center = cPoint
            minutesBlock.addSubview(minute)
        }
        self.minutesBlock = minutesBlock
        self.scrollViewContentHeight += minutesBlock.frame.height+32
        return
    }
    
    func setLabelsBlock() {
        let labelsBlock = UIStackView()
        labelsBlock.axis = .vertical
        labelsBlock.distribution = .fillEqually
        labelsBlock.alignment = .leading
        labelsBlock.spacing = 6
        self.scrollView.addSubview(labelsBlock)
        labelsBlock.translatesAutoresizingMaskIntoConstraints = false
        labelsBlock.addBackground(.red)
//        labelsBlock.heightAnchor.constraint(equalToConstant: 50).isActive = true
        labelsBlock.topAnchor.constraint(equalTo: self.minutesBlock!.bottomAnchor, constant: 16).isActive = true
        labelsBlock.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        labelsBlock.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        self.labelsBlock = labelsBlock
        self.scrollViewContentHeight += labelsBlock.frame.height
    }
    
    func setLoopBlock() {
        let label = UILabel()
        label.text = "繰り返し"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = PalermColor.Dark50.UIColor
        label.sizeToFit()
        self.scrollView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.labelsBlock.bottomAnchor, constant: 16).isActive = true
//        label.topAnchor.constraint(equalTo: self.minutesBlock!.bottomAnchor, constant: 32).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        self.scrollViewContentHeight += label.frame.height+32

        let loopBlock = UIScrollView()
        loopBlock.contentOffset = CGPoint(x: 0, y: 0)
        loopBlock.showsHorizontalScrollIndicator = false
        self.scrollView.addSubview(loopBlock)
        loopBlock.translatesAutoresizingMaskIntoConstraints = false
        loopBlock.heightAnchor.constraint(equalToConstant: 60).isActive = true
        loopBlock.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        loopBlock.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        loopBlock.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12).isActive = true
        
        let loopStack = UIStackView()
        loopStack.axis = .horizontal
        loopStack.addBackground(PalermColor.Dark500.UIColor)
        loopStack.distribution = .fillEqually
        loopStack.spacing = 6
        let weekStrings = [
            "日", "月", "火", "水", "木", "金", "土"
        ]
        var week: [UIButton] = []
        let size: CGFloat = 48
        for weekString in weekStrings {
            let w = self.createSelectButton(label: weekString, size: size, type: .Week)
            w.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:))))
            week.append(w)
            loopStack.addArrangedSubview(w)
        }
        loopStack.frame = CGRect(x: 12, y: 0, width: CGFloat(week.count)*size+CGFloat((week.count-1)*6), height: size)
        loopBlock.contentSize = CGSize(width: loopStack.frame.width+24, height: loopStack.frame.height)
        loopBlock.addSubview(loopStack)
        self.loopBlock = loopBlock
        self.view.layoutIfNeeded()
        self.scrollViewContentHeight += loopBlock.frame.height+12
    }
    
    func setCells() {
        let borderTop = UIView()
        borderTop.backgroundColor = UIColor(hexString: "404040")
        self.scrollView.addSubview(borderTop)
        borderTop.translatesAutoresizingMaskIntoConstraints = false
        borderTop.topAnchor.constraint(equalTo: self.loopBlock!.bottomAnchor, constant: 24).isActive = true
        borderTop.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        borderTop.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        borderTop.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        self.scrollViewContentHeight += 0.5+24

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
        self.scrollViewContentHeight += 44
        
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


class CircleCustomButton: UIButton {
    
    var active = false
    var color: UIColor
    var type: CircleCustomButtonType = .Hour
    
    init(size: CGFloat, color: UIColor, label: String, type: CircleCustomButtonType = .Hour) {
        self.active = false
        self.color = color
        self.type = type
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        self.layer.cornerRadius = size / 2
        self.backgroundColor = color
        self.setTitle(label, for: .normal)
        self.setTitleColor(PalermColor.Dark50.UIColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.addTarget(self, action: #selector(self.toggle(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggle(_ sender: UIButton) {
        self.active = !self.active
        self.setOn(self.active)
//        if self.active {
//            self.backgroundColor = PalermColor.Blue.UIColor
//            self.setTitleColor(.white, for: .normal)
//        } else {
//            self.backgroundColor = color
//            self.setTitleColor(PalermColor.Dark50.UIColor, for: .normal)
//        }
        self.occureImpact(style: .light)
    }
    
    func setOn(_ on: Bool) {
        self.active = on
        if self.active {
            self.backgroundColor = PalermColor.Blue.UIColor
            self.setTitleColor(.white, for: .normal)
        } else {
            self.backgroundColor = color
            self.setTitleColor(PalermColor.Dark50.UIColor, for: .normal)
        }
    }
    
    func occureImpact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

enum CircleCustomButtonType {
    case Hour
    case Minute
    case Week
}
