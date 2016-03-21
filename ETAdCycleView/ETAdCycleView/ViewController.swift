//
//  ViewController.swift
//  ETAdCycleView
//
//  Created by Volley on 16/3/21.
//  Copyright © 2016年 Volley. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ETCycleViewDelegate{

    var adCycleScroll: ETAdCycleView!
    @IBOutlet weak var ibCycleView: ETAdCycleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //使用frame创建
        adCycleScroll = ETAdCycleView(frame: CGRect(x: 0, y: 30, width: view.size_width, height: 100))
        view.addSubview(adCycleScroll)
        
        let adImages = ["https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/logo.png"
            ,"http://tb1.bdstatic.com/tb/cms/frs/bg/default_head20141014.jpg","https://www.baidu.com/img/bd_logo1.png",""]
        adCycleScroll.et_setCycleImagesWithURLs(adImages, placeHolder: UIImage(named: "u86"))
        adCycleScroll.delegate = self
        
        
        //使用xib创建
        let adCycleImages = ["https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/logo.png"
            ,"http://tb1.bdstatic.com/tb/cms/frs/bg/default_head20141014.jpg","https://www.baidu.com/img/bd_logo1.png",""]
        ibCycleView.et_setCycleImagesWithURLs(adCycleImages, placeHolder: UIImage(named: "u86"))
        ibCycleView.delegate = self
    }
    
    func et_cycleView(didClickPage pageView: UIImageView, atIndex index: Int) {
        print("\(index)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

