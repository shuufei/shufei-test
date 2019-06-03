//
//  StackViewController.swift
//  palerm
//
//  Created by 花城周平 on 2019/06/01.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit

class StackViewController: UIViewController {

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

        
        self.view.addSubview(labelAndSwitcherWrapper)
//        stackView.frame.origin = CGPoint(x: 50, y: 50)
//        stackView2.frame.origin = CGPoint(x: stackView.frame.minX, y: stackView.frame.maxY+6)
//        stackView.addBackground(.white)
//        stackView2.addBackground(.white)
//        self.view.addSubview(stackView)
//        self.view.addSubview(stackView2)
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
        insertSubview(subView, at: 0)
    }
}
