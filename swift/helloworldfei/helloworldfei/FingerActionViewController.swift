//
//  FingerActionViewController.swift
//  helloworldfei
//
//  Created by 花城周平 on 2019/05/06.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let v = hex.map { String($0) } + Array(repeating: "0", count: max(6 - hex.count, 0))
        let r = CGFloat(Int(v[0] + v[1], radix: 16) ?? 0) / 255.0
        let g = CGFloat(Int(v[2] + v[3], radix: 16) ?? 0) / 255.0
        let b = CGFloat(Int(v[4] + v[5], radix: 16) ?? 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
}

class FingerActionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    var kakudo: CGFloat = 180.0
    var items: [UIView] = []

    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var keyboardArea: UIView!
    @IBOutlet weak var bottomContraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func tapView(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBOutlet weak var addButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardArea.layer.cornerRadius = 15
        keyboardArea.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        keyboardArea.layer.shadowOpacity = 0.2
        keyboardArea.layer.shadowRadius = 15
        keyboardArea.layer.shadowColor = UIColor.black.cgColor
        keyboardArea.layer.shadowOffset = CGSize(width:3, height:10)
        tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        tableView.backgroundColor = UIColor(hex: "F2F2F2")
//        addItem()
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = UIColor(hex: "f2f2f2")
        addButton.layer.cornerRadius = 5
    }
    
    func addItem(_ title: String) {
        let item = UIView()
        item.frame = CGRect(x:0, y:10, width: 330, height:60)
        item.center.x = view.center.x
        item.backgroundColor = .white
        item.layer.cornerRadius = 10
        item.layer.shadowOpacity = 0.1
        item.layer.shadowRadius = 8
        item.layer.shadowColor = UIColor.black.cgColor
        item.layer.shadowOffset = CGSize(width:1, height:1)
        item.tag = items.count
        let pan = UIPanGestureRecognizer(target:self, action: #selector(self.handlePanGesture(_:)))
        pan.delegate = self
        item.addGestureRecognizer(pan)
//        view.addSubview(item)
        let itemLabel = UILabel()
        itemLabel.text = title
        itemLabel.frame = CGRect(x:20, y:19, width: 300, height: 22)
        itemLabel.textColor = UIColor(hex: "303030")
        itemLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//        itemLabel.center.y = 19
        item.addSubview(itemLabel)
        items.append(item)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translation(in: panGestureRecognizer.view)
            if abs(translation.x) > abs(translation.y) {
                return true
            }
            return false
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as? ItemCell {
            print("item cell")
            let item = items[(indexPath as NSIndexPath).row]
            cell.addSubview(item)
            cell.backgroundColor = UIColor(hex: "F2F2F2")
            return cell
        }
        print("no item cell")
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        guard let title = itemTextField.text, !title.isEmpty else {
            return
        }
        addItem(title)
//        tableView.reloadData()
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row:items.count-1, section: 0)], with: .fade)
        self.tableView.endUpdates()
        itemTextField.text = ""
    }
    
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let item = sender.view!
        let translation = sender.translation(in: self.view)
//        print("translation: \(translation.x)")
        let dx = translation.x
        item.center.x = view.center.x + dx
        if sender.state == .ended {
//            print("pann end: \(dx)")
            if 120 < abs(Int(dx)) {
                let x = Int(dx) < 0 ? item.frame.width*CGFloat(-1)-CGFloat(100) : view.frame.maxX+100
                UIView.animate(withDuration: 0.18, delay: 0, options: [.curveEaseOut], animations: {
                    item.frame = CGRect(x:x, y:item.frame.minY, width:item.frame.width, height: item.frame.height)
                }, completion: {(finished:Bool) in
                    item.removeFromSuperview()
                    print("remove: ", item.tag)
                    var itemIndex: Int?
                    for (index, i) in self.items.enumerated() {
                        if i.tag == item.tag {
                            itemIndex = index
                        }
                    }
                    guard itemIndex != nil else {
                        return
                    }
                    self.items.remove(at: itemIndex!)
                    self.tableView.beginUpdates()
                    self.tableView.deleteRows(at: [IndexPath(row:itemIndex!, section:0)], with: .top)
                    self.tableView.endUpdates()
                })
            } else {
                UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseOut], animations: {
                    item.center.x = self.view.center.x
                }, completion: nil)
            }
        }
//        if dx
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startObserveKeyboardNotification()
    }
    
    var lastRotation:CGFloat = 0.0
    
    @objc func hello(_ sender: UITapGestureRecognizer) {
        let tagNo = sender.view?.tag
        print("hello \(tagNo!)")
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

extension FingerActionViewController {
    /** キーボードのNotificationを購読開始 */
    func startObserveKeyboardNotification(){
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.willShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.willHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    /** キーボードのNotificationの購読停止 */
    func stopOberveKeyboardNotification(){
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /** キーボードが開いたときに呼び出されるメソッド */
    @objc func willShowKeyboard(_ notification:NSNotification){
        NSLog("willShowKeyboard called.")
        let duration = notification.duration()
        let rect     = notification.rect()
        if let duration=duration, let rect=rect {
            // ここで「self.bottomLayoutGuide.length」を使っている理由：
            // tabBarの表示/非表示に応じて制約の高さを変えないと、
            // viewとキーボードの間にtabBar分の隙間が空いてしまうため、
            // ここでtabBar分の高さを計算に含めています。
            // - tabBarが表示されていない場合、self.bottomLayoutGuideは0となる
            // - tabBarが表示されている場合、self.bottomLayoutGuideにはtabBarの高さが入る
            
            // layoutIfNeeded()→制約を更新→UIView.animationWithDuration()の中でlayoutIfNeeded() の流れは
            // 以下を参考にしました。
            // http://qiita.com/caesar_cat/items/051cda589afe45255d96
            self.view.layoutIfNeeded()
//            self.bottomContraint.constant=rect.size.height - self.bottomLayoutGuide.length;
            self.bottomContraint.constant=rect.size.height-30;
            UIView.animate(withDuration: duration, animations: { () -> Void in
                self.view.layoutIfNeeded()  // ここ、updateConstraint()でも良いのかと思ったけど動かなかった。
            })
        }
    }
    /** キーボードが閉じたときに呼び出されるメソッド */
    @objc func willHideKeyboard(_ notification:NSNotification){
        NSLog("willHideKeyboard called.")
        let duration = notification.duration()
        if let duration=duration {
            self.view.layoutIfNeeded()
            self.bottomContraint.constant=0
            UIView.animate(withDuration: duration,animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        }
    }
}

extension NSNotification{
    /** 通知から「キーボードの開く時間」を取得 */
    func duration()->TimeInterval?{
        let duration:TimeInterval? = self.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        return duration;
    }
    /** 通知から「表示されるキーボードの表示位置」を取得 */
    func rect()->CGRect?{
        let rowRect:NSValue? = self.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        let rect:CGRect? = rowRect?.cgRectValue
        return rect
    }
    
}
