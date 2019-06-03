//
//  ViewController.swift
//  palerm
//
//  Created by 花城周平 on 2019/05/28.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items = [100, 200, 100, 150, 200, 100]
    
    @IBOutlet weak var fabButton: UIButton!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
//        table.estimatedRowHeight = 50
//        table.rowHeight = UITableView.automaticDimension
        table.register(UINib(nibName: "AlermTableViewCell", bundle: nil), forCellReuseIdentifier: "alermCell")
        self.view.backgroundColor = PalermColor.Dark200.UIColor
        table.backgroundColor = PalermColor.Dark200.UIColor
        setFabButton()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AlermTableViewCell = tableView.dequeueReusableCell(withIdentifier: "alermCell") as! AlermTableViewCell
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alermCell") else { return UITableViewCell() }
//        let index = (indexPath as NSIndexPath).row
//        cell.alermView?.frame.size = CGSize(width: view.frame.width-32, height: CGFloat(items[index]+100))
//        cell.alermView?.addTarget(self, action: #selector(self.changeCellHeight(_:)), for: .touchUpInside)
//        cell.layoutIfNeeded()
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alermCellBase") else { return UITableViewCell() }
        return cell
        
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
//        cell.backgroundColor = PalermColor.Dark500.UIColor
//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.layer.borderWidth = 1
//        let alerm = UIControl()
//        let index = (indexPath as NSIndexPath).row
//        let item = items[index]
//        alerm.frame = CGRect(x: 0, y: 0, width: view.frame.width-32, height: CGFloat(item))
//        alerm.backgroundColor = .white
//        alerm.center.x = view.center.x
//        alerm.addTarget(self, action: #selector(self.changeCellHeight(_:)), for: .touchUpInside)
//        cell.addSubview(alerm)
////        cell.textLabel?.text = "cell item"
//        return cell
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        tableView.estimatedRowHeight = 20
//        return UITableView.automaticDimension
        let item = items[(indexPath as NSIndexPath).row]
        return CGFloat(item + 20)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[(indexPath as NSIndexPath).row] = 300
        table.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func setFabButton() {
        fabButton.backgroundColor = PalermColor.Dark100.UIColor
        fabButton.layer.masksToBounds = false
        fabButton.layer.cornerRadius = CGFloat(fabButton.frame.width / 2)
        fabButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        fabButton.layer.shadowColor = UIColor.black.cgColor
        fabButton.layer.shadowOpacity = 0.3
        fabButton.layer.shadowRadius = 15
        fabButton.addTarget(self, action: #selector(self.showSetting(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func showSetting(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showSetting", sender: nil)
    }
    
    @objc func changeCellHeight(_ sender: UIControl) {
        sender.frame.size = CGSize(width: sender.frame.width, height:300)
//        table.reloadRows(at: 0, with: .automatic)
    }


}


