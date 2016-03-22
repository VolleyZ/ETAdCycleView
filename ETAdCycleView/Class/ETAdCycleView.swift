//
//  ETAdCycleView.swift
//  Baby-Kingdom
//
//  Created by Volley on 16/3/16.
//  Copyright © 2016年 Volley. All rights reserved.
//

import UIKit
import Kingfisher

@objc protocol ETCycleViewDelegate {
    optional func et_cycleView(didClickPage pageView: UIImageView, atIndex index: Int)
}

class ETAdCycleView: UIView {
    
    private var leftView = UIImageView()
    private var centerView = UIImageView()
    private var rightView = UIImageView()
    
    weak var delegate: ETCycleViewDelegate?
    
    private var adImages: [String] = []      //数据源图片
    private lazy var placeHolderImage: UIImage! = {
        let placeImage = UIImage(named: "u86")
        return placeImage
    }()
    
    func et_setCycleImagesWithURLs(urls: [String], placeHolder: AnyObject?) {
        adImages = urls
        placeHolderImage = placeHolder as? UIImage
        pageControl.numberOfPages = adImages.count
        reloadImage()
    }
    
    var switchTime = 2.0            //默认2秒切换
    
    var showPageControl: Bool = true {   //设置是否显示pagecontrol
        didSet {
            pageControl.hidden = !showPageControl
        }
    }
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    private func reloadImage() {
        for view in autoScrollView.subviews {
            view.removeFromSuperview()
        }
        
        let left = (currentPage - 1 + adImages.count) % adImages.count
        let center = currentPage
        let right = (currentPage + 1 + adImages.count) % adImages.count
        
        leftView.kf_setImageWithURL(NSURL(string: adImages[left])!, placeholderImage: placeHolderImage, optionsInfo: [.Transition(ImageTransition.Fade(1))])
        
        centerView.kf_setImageWithURL(NSURL(string: adImages[center])!, placeholderImage: placeHolderImage, optionsInfo: [.Transition(ImageTransition.Fade(1))])
        rightView.kf_setImageWithURL(NSURL(string: adImages[right])!, placeholderImage: placeHolderImage, optionsInfo: [.Transition(ImageTransition.Fade(1))])
  
        addContentView()
        
        if adImages.count == 1 {
            timeInterval = 0     //销毁默认计时器
            showPageControl = false
            autoScrollView.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height)
            autoScrollView.setContentOffset(CGPointMake(0, 0), animated: false)
        }else {
            timeInterval = switchTime
            showPageControl = true
            autoScrollView.contentSize = CGSizeMake(autoScrollView.size_width * CGFloat(adImages.count == 2 ? 3: adImages.count), 0)
            autoScrollView.setContentOffset(CGPointMake(autoScrollView.size_width, 0), animated: false)
        }
    }
    
    func autoPlayAD() {
        autoScrollView.setContentOffset(CGPointMake(autoScrollView.size_width * 2, 0), animated: true)
    }
    
    private func addContentView() {
        autoScrollView.addSubview(leftView)
        autoScrollView.addSubview(centerView)
        autoScrollView.addSubview(rightView)
    }
    
    func tapAction(tap: UITapGestureRecognizer) {
        self.delegate?.et_cycleView!(didClickPage: tap.view as! UIImageView, atIndex: self.currentPage)
    }
    
    private func addTap() {
        leftView.userInteractionEnabled = true
        centerView.userInteractionEnabled = true
        rightView.userInteractionEnabled = true
        let tapL = UITapGestureRecognizer(target: self, action: "tapAction:")
        let tapC = UITapGestureRecognizer(target: self, action: "tapAction:")
        let tapR = UITapGestureRecognizer(target: self, action: "tapAction:")
        leftView.addGestureRecognizer(tapL)
        centerView.addGestureRecognizer(tapC)
        rightView.addGestureRecognizer(tapR)
    }
    
    private func initCycleContentView() {
        addSubview(autoScrollView)
        addContentView()
        addSubview(pageControl)
        
        timeInterval = switchTime
        leftView.contentMode = .ScaleAspectFit
        centerView.contentMode = .ScaleAspectFit
        rightView.contentMode = .ScaleAspectFit
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        initCycleContentView()
        addTap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCycleContentView()
        addTap()
    }
    
    private lazy var autoScrollView: UIScrollView = {
        let autoScroll = UIScrollView()
        autoScroll.bounces = false
        autoScroll.delegate = self
        autoScroll.pagingEnabled = true
        autoScroll.showsHorizontalScrollIndicator = false
        autoScroll.showsVerticalScrollIndicator = false
        autoScroll.frame = self.bounds
        return autoScroll
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageC = UIPageControl()
        pageC.enabled = false
        pageC.currentPage = 0
        return pageC
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pageControl.frame = CGRectMake(0, size_height - 15, size_width, 10)
        leftView.frame = CGRectMake(0, 0, size_width, size_height)
        centerView.frame = CGRectMake(size_width, 0, size_width, size_height)
        rightView.frame = CGRectMake(size_width * 2, 0, size_width, size_height)
    }
    
    private var timer: NSTimer? = nil
    private var timeInterval = 0.0 {
        didSet {
            if timer == nil {
                timer = NSTimer.scheduledTimerWithTimeInterval(switchTime, target: self, selector: "autoPlayAD", userInfo: nil, repeats: true)
                NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
            }
        }
    }
}

extension ETAdCycleView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if self.timer != nil {
            if self.timer!.valid {
                self.timer!.fireDate = NSDate.distantFuture() as NSDate
            }
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.timer != nil {
            self.timer!.fireDate = NSDate.distantFuture() as NSDate
            self.timer!.fireDate = NSDate(timeIntervalSinceNow: switchTime) as NSDate
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if adImages.count <= 0 { return }
        let x = scrollView.contentOffset.x
        if x >= (autoScrollView.size_width * 2) {
            currentPage = (currentPage + 1 + adImages.count) % adImages.count
            reloadImage()
        }else if x <= 0 {
            currentPage = (currentPage - 1 + adImages.count) % adImages.count
            reloadImage()
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        autoScrollView.setContentOffset(CGPointMake(autoScrollView.size_width, 0), animated: true)
    }
}
