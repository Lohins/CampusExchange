//
//  CEIDPhotoDisplayView.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/2/25.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEIDPhotoDisplayView: UIView {
    
    var scrollView: UIScrollView
    
    var pageControl: CEIDPaging!
    
    
    var data: [String] = [String]()
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect){
        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width
            , height: frame.size.height))
        super.init(frame: frame)
//        pageControl = CEIDPaging.init(numOfPages: 4)
//        pageControl.center = CGPoint.init(x: frame.size.width / 2, y: frame.size.width / 2)
//        pageControl.bottom = frame.size.height - 20
//        pageControl.setCurrentPage(page: 0)
        
        self.addSubview(scrollView)
//        self.addSubview(pageControl)
                
        self.setupUI()
    }
    
    init(frame: CGRect, pictures: [String]) {
        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width
            , height: frame.size.height))
        
        super.init(frame: frame)
        

        
        self.addSubview(scrollView)
        
        self.data = pictures
        
        self.setupUI()
    }
    
    func updateWithUrls(urls: [String]){
        self.data = urls
        self.scrollView.contentSize = CGSize.init(width: self.width * CGFloat( self.data.count), height: self.height)
        pageControl = CEIDPaging.init(numOfPages: self.data.count)
        pageControl.center = CGPoint.init(x: frame.size.width / 2, y: frame.size.width / 2)
        pageControl.bottom = frame.size.height - 20
        pageControl.setCurrentPage(page: 0)
        self.addSubview(pageControl)

        self.addPic(urls: urls)
    }
    
    func setupUI(){
        

        self.scrollView.contentOffset = CGPoint.init(x: 0, y: 0)
        self.scrollView.isPagingEnabled = true
        self.scrollView.delegate = self
        self.scrollView.bounces = false
        self.scrollView.showsHorizontalScrollIndicator = false
        
        // for test
//        self.addPic()
        
    }
    
    func addPic(urls: [String]){
        var offset_x = CGFloat(0)
        for url in urls{
            let imageView = UIImageView.init(frame: CGRect.init(x: offset_x, y: 0, width: self.width, height: self.height))
            imageView.setImageWith(URL.init(string: url)!)
            self.scrollView.addSubview(imageView)
            
            offset_x = offset_x + self.width
        }
    }
    
}

extension CEIDPhotoDisplayView: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.x
        
        let page = Int( offset / self.width )
        
        self.pageControl.setCurrentPage(page: page)
        
    }
    
}
