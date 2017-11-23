//
//  WalkthroughView.swift
//  DisherX
//
//  Created by Cyril on 27/9/17.
//  Copyright © 2017 Cyril. All rights reserved.
//

import Foundation
import UIKit

protocol WalkthroughViewDelegate: class {
    func didFinishFlow()
}

class WalkthroughView: UIView, UIScrollViewDelegate {
    
    fileprivate var scrollView = UIScrollView()
    fileprivate var pageControll = UIPageControl()
    fileprivate let bgPagingView = UIView()
    fileprivate let numberOfPages = 3
    fileprivate let nextBtn = UIButton()
    fileprivate let previousBtn = UIButton()
    var images: [UIImage]! { didSet { self.addImagesToScrollView() } }
    
    weak var delegate: WalkthroughViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func initViews() {
        self.addViews()
        self.setScrollView()
        self.setBgPagingView()
        self.setPageControll()
        self.addNextButton()
        self.addPreviousButton()
    }
    
    fileprivate func addViews() {
        self.addSubview(scrollView)
        self.addSubview(bgPagingView)
        self.bgPagingView.addSubview(pageControll)
    }
    
    fileprivate func setScrollView() {
        self.scrollView.isScrollEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.bounces = false
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(numberOfPages), height:0)
        self.scrollView.isPagingEnabled = true
        self.scrollView.delegate = self
        
        self.scrollView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(self).offset(-20)
        }
    }
    
    fileprivate func addImagesToScrollView() {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        for i in 0...numberOfPages-1  {
            let xOrigin = CGFloat(i) * width
            let v = UIView(frame: CGRect(x: xOrigin, y: 0, width: width, height: height))
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
            imageView.isUserInteractionEnabled = true
            imageView.image = self.images[i]
            imageView.contentMode = .scaleAspectFill
            v.addSubview(imageView)
            scrollView.addSubview(v)
        }
    }
    
    fileprivate func setPageControll() {
        self.pageControll.currentPage = 0
        self.pageControll.numberOfPages = numberOfPages
        
        pageControll.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgPagingView)
            make.centerY.equalTo(bgPagingView)
        }
    }
    
    fileprivate func setBgPagingView() {
        bgPagingView.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self).offset(-20)
        }
    }
    
    ///IS not being called at the moment
    fileprivate func addLineToPaging() {
        let line = UIView()
        line.backgroundColor = .white
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalTo(self.bgPagingView)
            make.bottom.equalTo(self.bgPagingView.snp.top).offset(-15)
        }
    }
    
    fileprivate func addPreviousButton() {
        previousBtn.setTitle("Previous", for: .normal)
        previousBtn.addTarget(self, action: #selector(btnPreviousClicked), for: .touchUpInside)
        previousBtn.isHidden = true
        previousBtn.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
        bgPagingView.addSubview(previousBtn)
        previousBtn.snp.makeConstraints { (make) in
            make.left.equalTo(bgPagingView).offset(30)
            make.top.equalTo(bgPagingView)
            make.bottom.equalTo(bgPagingView)
        }
    }
    
    fileprivate func addNextButton() {
        nextBtn.setTitle("Next", for: .normal)
        nextBtn.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
        nextBtn.addTarget(self, action: #selector(btnNextClicked), for: .touchUpInside)
        
        bgPagingView.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { (make) in
            make.right.equalTo(bgPagingView).offset(-30)
            make.top.equalTo(bgPagingView)
            make.bottom.equalTo(bgPagingView)
        }
    }
    
    //Actions
    
    @objc func btnNextClicked() {
        if self.pageControll.currentPage == numberOfPages-1 {
            delegate?.didFinishFlow()
        } else {
            self.pageControll.currentPage += 1
            previousBtn.isHidden = false
            self.animateTheMoving {
                self.scrollView.contentOffset.x += self.frame.width
            }
        }
    }
    
    @objc func btnPreviousClicked() {
        if self.pageControll.currentPage-1 == 0 { previousBtn.isHidden = true }
        self.pageControll.currentPage -= 1
        self.animateTheMoving {
            self.scrollView.contentOffset.x -= self.frame.width
        }
    }
    
    private func animateTheMoving(action:@escaping() -> Void) {
        UIView.animate(withDuration: 0.2, animations: action)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.scrollView.frame.width > 0 { // didLayoutSubviews
            let currentPage = Int(floor((self.scrollView.contentOffset.x - (scrollView.frame.width / 2 )) / ( scrollView.frame.width) + 1))
            self.pageControll.currentPage = currentPage
            currentPage == numberOfPages-1 ? nextBtn.setTitle("Start", for: .normal) : nextBtn.setTitle("Next", for: .normal)
            previousBtn.isHidden = currentPage == 0 ? true : false
        }
    }
 
}
