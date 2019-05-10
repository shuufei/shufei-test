//
//  PickerTutorial.swift
//  helloworldfei
//
//  Created by 花城周平 on 2019/05/04.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit

class PickerTutorial: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    override func viewDidLoad() {
        print("picker tutorial.")
        myPickerView.delegate = self
        myPickerView.dataSource = self
    }
    @IBOutlet weak var myPickerView: UIPickerView!
    
    let compos = [["月", "火", "水", "木", "金"], ["早朝", "午前中", "昼間", "夜間"]]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return compos.count
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let compo = compos[component]
        return compo.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if component == 0 {
            return 50
        } else {
            return 100
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = compos[component][row]
        return item
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = compos[component][row]
        print("\(item)が選ばれた")
        
        let row1 = myPickerView.selectedRow(inComponent: 0)
        let row2 = myPickerView.selectedRow(inComponent: 1)
        print("現在選択されている行番号")
        
        let item1 = self.pickerView(myPickerView, titleForRow: row1, forComponent: 0)
        let item2 = self.pickerView(myPickerView, titleForRow: row2, forComponent: 1)
        print("現在選択されている項目名\(item1!), \(item2!)")
        print("--------")
        
    }
}
