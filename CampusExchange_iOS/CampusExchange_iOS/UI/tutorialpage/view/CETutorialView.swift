//
//  CETutorialView.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/2/28.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CETutorialView: UIView {
    
    var scrollView: UIScrollView!
    
    var pageControl: CEIDPaging!
    
    var button: UIButton!
    
    var pictureList: [UIImage] = [UIImage]()
    
    var finishBlk : (() -> Void )?
    

    init(frame: CGRect , pictures: [UIImage] , finishBlock:@escaping (()-> Void) ){
        
        super.init(frame: frame)
        
        self.pictureList = pictures
        
        self.finishBlk = finishBlock
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        let numOfPage = self.pictureList.count
        
        // scroll view
        self.scrollView = UIScrollView.init(frame: frame)
        self.scrollView.contentSize = CGSize.init(width: self.width * CGFloat(numOfPage), height: self.height)
        self.scrollView.delegate = self
        self.scrollView.isPagingEnabled = true
        self.addSubview(self.scrollView)
        
        var offset_x = CGFloat(0)
        for view in self.getSubViews(){
            self.scrollView.addSubview(view)
            view.left = offset_x
            view.top = CGFloat(0)
            offset_x = offset_x + view.width
        }
        
        let button_height = CGFloat(70)
        
        // button
        self.button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: button_height))
        self.button.setTitle("SKIP", for: .normal)
        self.button.backgroundColor = UIColor.init(RGBWithRed: 83, green: 88, blue: 96, alpha: 1)
        self.button.titleLabel?.font = UIFont.init(name: "SFUIText-Regular", size: 20)
        self.button.bottom = self.height
        self.button.addTarget(self, action: #selector(self.tapAction), for: .touchUpInside)
        self.addSubview(self.button)
        
        // page control
        self.pageControl = CEIDPaging.init(numOfPages: numOfPage)
        self.pageControl.center = CGPoint.init(x: self.width / 2, y: self.height / 2)
        self.pageControl.bottom = self.button.top - 10
        self.pageControl.setCurrentPage(page: 0)
        self.addSubview(self.pageControl)
        
        
        
    }
    
    func getSubViews() -> [UIImageView]{
        var subviews = [UIImageView]()
        for image in self.pictureList{
            let imgView = UIImageView.init(frame: self.frame)
            imgView.image = image
            subviews.append(imgView)
        }
        
        return subviews
    }
    
    func tapAction(){
        if let blk = self.finishBlk{
            blk()
        }
    }

}

extension CETutorialView: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.width)
        
        self.pageControl.setCurrentPage(page: page)
        
        let limit = CGFloat(self.pictureList.count - 1) + 0.25
        if (scrollView.contentOffset.x / scrollView.width) > limit {
            self.removeFromSuperview()
        }
    }
}
