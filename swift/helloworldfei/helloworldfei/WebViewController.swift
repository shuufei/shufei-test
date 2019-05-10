//
//  WebViewController.swift
//  helloworldfei
//
//  Created by 花城周平 on 2019/05/05.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var data:(name:String, url:String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let webData = data else {
            return
        }
        
        let myURL = URL(string: webData.url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
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
