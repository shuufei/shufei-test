//
//  ScrollImageTutorial.swift
//  helloworldfei
//
//  Created by 花城周平 on 2019/05/05.
//  Copyright © 2019 花城周平. All rights reserved.
//

import UIKit

class ScrollImageTutorial: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    struct Photo {
        var imageName:String
        var title:String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoList = [
            Photo(imageName: "suizokukan", title: "水族館"),
            Photo(imageName: "bin", title: "瓶"),
            Photo(imageName: "kukou", title: "空港")
        ]
        
        let subView = createContentsView(contentList: photoList)
        scrollView.addSubview(subView)
        
        scrollView.isPagingEnabled = true
        scrollView.contentSize = subView.frame.size
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.delegate = self
        
        pageControl.numberOfPages = photoList.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
    }
    
    func createContentsView(contentList: Array<Photo>) -> UIView {
        let contentView = UIView()
        let pageWidth = self.view.frame.width
        let pageHeight = scrollView.frame.height
        print("pageHeight: \(pageHeight)")
        let pageViewRect = CGRect(x:0, y:0, width:pageWidth, height:pageHeight)
        let photoSize = CGSize(width:250, height:250)
        contentView.frame = CGRect(x:0, y:0, width:pageWidth*3, height:pageHeight)
        let colors:[UIColor] = [.cyan, .yellow, .lightGray, .orange]
        for i in 0..<contentList.count {
            let contentItem = contentList[i]
            let pageView = createPage(viewRect: pageViewRect, imageSize: photoSize, item: contentItem)
            let left = pageViewRect.width * CGFloat(i)
            let xy = CGPoint(x:left, y:0)
            pageView.frame = CGRect(origin: xy, size: pageViewRect.size)
            pageView.backgroundColor = colors[i]
            contentView.addSubview(pageView)
        }
        return contentView
    }
    
    func createPage(viewRect:CGRect, imageSize:CGSize, item:Photo) -> UIView {
        let pageView = UIView(frame: viewRect)
        let photoView = UIImageView()
        let left = (pageView.frame.width - imageSize.width)/2
        photoView.frame = CGRect(x:left, y:10, width:imageSize.width, height:imageSize.height)
        photoView.contentMode = .scaleAspectFill
        photoView.image = UIImage(named: item.imageName)
        photoView.clipsToBounds = true
        let titleFrame = CGRect(x:left, y:photoView.frame.maxY+10, width:200, height:21)
        let titleLabel = UILabel(frame: titleFrame)
        titleLabel.text = item.title
        pageView.addSubview(photoView)
        pageView.addSubview(titleLabel)
        return pageView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = Int(scrollView.contentOffset.x)
        let w = Int(scrollView.frame.width)
//        print("x: \(x), w: \(w)")
        let pageNo = x/w
        pageControl.currentPage = pageNo
    }
    @IBAction func gotoFrogPage(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "frogPage")
        nextVC?.modalTransitionStyle = .flipHorizontal
        present(nextVC!, animated: true, completion: nil)
    }

    @IBAction func showAlert(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.title = "タイトル"
        alert.message = "メッセージ文"
        
        alert.addTextField(configurationHandler: {(textField) -> Void in
            textField.delegate = self
        })
        
        alert.addAction(UIAlertAction(
            title: "button1",
            style: .default,
            handler: {(action) -> Void in
                self.hello(message: action.title!)
        }))
        
//        alert.addAction(UIAlertAction(
//            title: "button2",
//            style: .default,
//            handler: {(action) -> Void in
//                self.hello(message: action.title!)
//        }))
        
        alert.addAction(UIAlertAction(
            title: "cancel",
            style: .cancel,
            handler: nil
        ))
        
//        alert.addAction(UIAlertAction(
//            title: "delete",
//            style: .destructive,
//            handler: {(action) -> Void in
//                self.hello(message: action.title!)
//        }))
        
        self.present(alert, animated: true, completion: { print("show alert") })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text ?? "")
    }
    
    func hello(message msg: String) {
        print(msg)
    }
    
    @IBAction func showActionSheet(_ sender: Any) {
        let actionSheet = UIAlertController(title: "title", message: "message", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "button1", style: .default, handler: {(action) -> Void in
                self.hello(message: action.title!)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "button2", style: .default, handler: {(action) -> Void in
            self.hello(message: action.title!)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: {(action) -> Void in
            self.hello(message: action.title!)
        }))
        
        self.present(actionSheet, animated: true, completion: {print("show actionsheet")})
    }
}
