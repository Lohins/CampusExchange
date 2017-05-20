//
//  CEAddPhotoVC.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/2/25.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEAddPhotoVC: UIViewController {
    
    var ImgViews = [CEAddPhotoView]()
    
    var scrollView: UIScrollView!
    
    var pageControl: CEIDPaging!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        
        let backButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
        backButton.setImage(UIImage.init(named: "back_button_icon"), for: .normal)
        backButton.bk_(whenTapped: {  [weak self] in
            if let weakSelf = self{
                _ = weakSelf.navigationController?.popViewController(animated: true)
            }
        })
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
        
        // title
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 30))
        titleLabel.text = "ADD PHOTO"
        titleLabel.font = UIFont.init(name: "SFUIText-Semibold", size: 16)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
        
    }
    
    func setupUI(){
        
        self.edgesForExtendedLayout = UIRectEdge()
        
        self.view.backgroundColor = UIColor.white
        
        let x = CGFloat(50)
        let y = CGFloat(65)
        let tmp_width = GlobalValue.SCREENBOUND.width - x * 2
        
        self.scrollView = UIScrollView.init(frame: CGRect.init(x: x, y: y, width: tmp_width, height: tmp_width))
        self.scrollView.contentSize = CGSize.init(width: 5 * tmp_width, height: tmp_width)
        self.scrollView.delegate = self
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.bounces = false
        self.view.addSubview(self.scrollView)
        
        // default 5 pic
        var offset_x = CGFloat(0)
        for _ in 0...4{
            let view = CEAddPhotoView.init(width: tmp_width)
            view.left = offset_x
            self.scrollView.addSubview(view)
            offset_x = offset_x + tmp_width
            
            self.ImgViews.append(view)
        }
        
        self.pageControl = CEIDPaging.init(numOfPages: 5)
        self.pageControl.center = CGPoint.init(x: GlobalValue.SCREENBOUND.width / 2, y: 0)
        self.pageControl.top = self.scrollView.bottom + 10
        self.pageControl.setCurrentPage(page: 0)
        self.view.addSubview(self.pageControl)
        
        
        // next button
        let nextButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: 72))
        nextButton.setTitle("NEXT", for: .normal)
        nextButton.backgroundColor = UIColor.init(RGBWithRed: 83, green: 88, blue: 96, alpha: 1)
        nextButton.titleLabel?.font = UIFont.init(name: "SFUIText-Regular", size: 20)
        nextButton.bottom = GlobalValue.SCREENBOUND.height - GlobalValue.NVBAR_HEIGHT - GlobalValue.STATUSBAR_HEIGHT
        nextButton.addTarget(self, action: #selector(self.nextAction), for: .touchUpInside)
        self.view.addSubview(nextButton)
    }
    
    // 抽取 用户选取的图片
    func getImages()-> [UIImage]{
        var imagesList = [UIImage]()
        for view in self.ImgViews{
            if let image = view.getImage(){
                imagesList.append(image)
            }
        }
        return imagesList
    }
    
    
    func nextAction(){
        let vc = CEAddDetailVC.init(imgList: self.getImages())
        self.navigationController?.pushViewController(vc, animated: true)
    }



}

extension CEAddPhotoVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let page = Int( offset / self.scrollView.width )
        self.pageControl.setCurrentPage(page: page)
    }
}


extension CEAddPhotoVC{
    
    class CEAddPhotoView: UIView {
        
        var imageView : UIImageView!
        
        var iconView: UIImageView!
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.setupUI()
        }
        
        convenience init(width : CGFloat){
            self.init(frame: CGRect.init(x: 0, y: 0, width: width, height: width))
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupUI(){
            
            
            // 边框
            self.layer.borderColor = UIColor.init(RGBWithRed: 83, green: 88, blue: 96, alpha: 1).cgColor
            self.layer.borderWidth = 0.5
            self.layer.cornerRadius = 10
            self.clipsToBounds = true
            
            // 默认的 添加图片的 icon
            self.iconView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 62, height: 62))
            self.iconView.image = UIImage.init(named: "mainpage_addnew_icon")
            self.iconView.center = CGPoint.init(x: self.width / 2, y: self.width / 2)
            
            // 图片
            self.imageView = UIImageView.init(frame: self.frame)
            self.addSubview(self.imageView)
        
            self.addSubview(iconView)
            
            // button
            let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: self.width))
            button.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
            self.addSubview(button)
            
        }
        
        func setImage(image: UIImage?){
            guard let img = image else{
                self.iconView.isHidden = false
                return
            }
            self.iconView.isHidden = true
            self.imageView.image = img
        }
        
        func getImage() -> UIImage?{
            return self.imageView.image
        }
        
        func clickAction(){
            
            if let nav = self.getCurrentViewController()?.navigationController{
                CEPhotoMediaManager.sharedInstance.show(in: nav, finishBlock: { [weak self] (image) -> Void in
                    if let weakSelf = self{
                        weakSelf.setImage(image: image)
                    }
                })
            }
        }
        
    }

}
