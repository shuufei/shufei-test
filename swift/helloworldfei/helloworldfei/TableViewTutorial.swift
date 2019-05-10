//
//  TableViewTutorial.swift
//  helloworldfei
//
//  Created by 花城周平 on 2019/05/04.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit

let sectionTitle = ["チョウ目", "バッタ目", "コチョウ目"]
let section0 = [("キタハテ", "タテハチョウ科"), ("クロアゲハ", "アゲハチョウ科")]
let section1 = [("キリギリス", "キリギリス科"), ("ヒナバッタ", "バッタ科"), ("マツムシ", "マツムシ科")]
let section2 = [("ハンミョウ", "ハンミョウ科"), ("アオオサムシ", "オサムシ科"), ("チビクワガタ", "クワガタムシ科")]
let tableData = [section0, section1, section2]

class TableViewTutorial: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myTableView = UITableView(frame: view.frame, style: .grouped)
        myTableView.delegate = self
        myTableView.dataSource = self
        view.addSubview(myTableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = tableData[section]
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let sectionData = tableData[(indexPath as NSIndexPath).section]
        let cellData = sectionData[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = cellData.0
        cell.detailTextLabel?.text = cellData.1
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
}
