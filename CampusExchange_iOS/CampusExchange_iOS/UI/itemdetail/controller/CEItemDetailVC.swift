//
//  CEItemDetailVC.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/2/25.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit
import BlocksKit

class CEItemDetailVC: UIViewController {
    
    var merchandiseId: Int!
    
    var mainScrollView: UIScrollView!
    
    let service = CEMerchandiseService()
    
    // ui widgets
    var header: CEIDHeaderView!
    
    var displayView : CEIDPhotoDisplayView!
    
    var textView : CEIDTextDetailView!
    
    init(MerchandiseId: Int) {
        super.init(nibName: nil, bundle: nil)
        
        self.merchandiseId = MerchandiseId
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        
        self.updateData()
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
        titleLabel.text = "ITEM DETAILS"
        titleLabel.font = UIFont.init(name: "SFUIText-Semibold", size: 16)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
        
    }
    
    func updateData(){
        self.service.getPostDetailBy(id: self.merchandiseId) { [weak self] (merchandiseDetail, error) in
            if let weakSelf = self{
                if error != nil{
                    return
                }
                
                guard let goods = merchandiseDetail else{
                    return
                }
                
                weakSelf.updateUI(merchandise: goods)
            }
        }
    }
    func updateUI(merchandise: CEMerchandise){
        self.header.updateUI(goods: merchandise)
//        self.displayView.
        self.textView.updateData(goods: merchandise)
        
        self.displayView.updateWithUrls(urls: merchandise.productImage)
    }
    
    func setupUI(){
        
        self.edgesForExtendedLayout = UIRectEdge()
        
        self.view.backgroundColor = UIColor.white
        
        // header
        header = CEIDHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: 76))
        
        // scroll view
        displayView = CEIDPhotoDisplayView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: GlobalValue.SCREENBOUND.width))
        // , pictures: ["pic1" , "pic2" , "pic3" , "pic4"]
        
        // text view
        textView = CEIDTextDetailView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: 10), desc: "", phone: "", email: "")
        textView.top = displayView.bottom
        
        // bottom button
        let bottomButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: 64))
        bottomButton.backgroundColor = UIColor.init(RGBWithRed: 126, green: 211, blue: 33, alpha: 1)
        bottomButton.setTitle("CONTACT SELLER", for: .normal)
        bottomButton.titleLabel?.font = UIFont.init(name: "SFUIText-Regular", size: 20)
        let offset = GlobalValue.SCREENBOUND.height - GlobalValue.NVBAR_HEIGHT - GlobalValue.STATUSBAR_HEIGHT
        bottomButton.bottom = offset
        self.view.addSubview(bottomButton)
        
        // main scroll view 
        self.mainScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: offset - bottomButton.height))
        self.mainScrollView.contentSize = CGSize.init(width: GlobalValue.SCREENBOUND.width, height: textView.bottom)
        self.mainScrollView.bounces = false
        
        self.mainScrollView.addSubview(displayView)
        self.mainScrollView.addSubview(header)
        self.mainScrollView.addSubview(textView)
        self.view.addSubview(mainScrollView)

    }
}
