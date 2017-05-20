//
//  CEBookMarkVC.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/3/2.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit
import iOS_Slide_Menu

class CEBookMarkVC: UIViewController {
    
    let CELL_IDENTIFIER = "CEGoodsCollectionViewCell"
    
    var collectionView : UICollectionView!
    
    var collectionViewLayout = UICollectionViewFlowLayout()
    let service = CEBookmarkService()
    
    // data source
    var merchandiseList = [CEMerchandise]()
    
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
        
        
        
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 30))
        titleLabel.text = "BOOKMARKS"
        titleLabel.font = UIFont.init(name: "SFUIText-Semibold", size: 16)
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel
        
        
        // left bar button
        let leftButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 25, height: 25))
        leftButton.setImage(UIImage.init(named: "mainpage_menu_icon"), for: .normal)
        leftButton.addTarget(SlideNavigationController.sharedInstance(), action: #selector(SlideNavigationController.sharedInstance().toggleLeftMenu), for: .touchUpInside)
        SlideNavigationController.sharedInstance().leftBarButtonItem = UIBarButtonItem.init(customView: leftButton)
        
//        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
//        button.setImage(UIImage.init(named: "back_button_icon"), for: .normal)
//        button.bk_(whenTapped: { [weak self] ()-> Void in
//            if let weakSelf = self{
//                let _ = weakSelf.navigationController?.popViewController(animated: true)
//            }
//        })
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: button)
    }
    
    func setupUI(){
        self.edgesForExtendedLayout = UIRectEdge()
        
        self.view.backgroundColor = UIColor.white
        let btn_height = CGFloat(72)
        let collection_height = GlobalValue.SCREENBOUND.height - GlobalValue.NVBAR_HEIGHT - GlobalValue.STATUSBAR_HEIGHT - btn_height
        
        // collection view layout
        let cell_width = ( GlobalValue.SCREENBOUND.width - 8 * 2 - 11 ) / 2
        let cell_height = cell_width + 36
        
        self.collectionViewLayout.minimumInteritemSpacing = 11
        self.collectionViewLayout.minimumLineSpacing = 8
        self.collectionViewLayout.itemSize = CGSize.init(width: cell_width, height: cell_height)
        self.collectionViewLayout.scrollDirection = .vertical
        self.collectionViewLayout.headerReferenceSize = CGSize.zero
        self.collectionViewLayout.headerReferenceSize = CGSize.zero
        self.collectionViewLayout.sectionInset = UIEdgeInsets.init(top: 10, left: 8, bottom: 32, right: 8)
        
        // collection view
        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: collection_height), collectionViewLayout: self.collectionViewLayout)
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.register(UINib.init(nibName: CELL_IDENTIFIER, bundle: nil), forCellWithReuseIdentifier: CELL_IDENTIFIER)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
        
        // clear button
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: btn_height))
        button.backgroundColor = UIColor.init(RGBWithRed: 83, green: 88, blue: 95, alpha: 1)
        button.setTitle("CLEAR BOOKMARKS", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "SFUIText-Regular", size: 20)
        button.titleLabel?.textColor = UIColor.white
        button.top = collection_height
        button.addTarget(self, action: #selector(self.clearAction), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func updateData(){
        service.getBookmarkList { [weak self] (list, error) in
            if error != nil{
                return
            }
            guard let list = list else{
                return
            }
            if let weakSelf = self{
                weakSelf.merchandiseList = list
                weakSelf.collectionView.reloadData()
            }
        }
    }
    
    
    func clearAction(){
        
    }
    
}

extension CEBookMarkVC: UICollectionViewDelegateFlowLayout , UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.merchandiseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_IDENTIFIER, for: indexPath) as! CEGoodsCollectionViewCell
        
        let data = self.merchandiseList[indexPath.row]
        cell.updateData(item: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let merchandise = self.merchandiseList[indexPath.row]
        let vc = CEItemDetailVC.init(MerchandiseId: merchandise.postId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension CEBookMarkVC : SlideNavigationControllerDelegate{
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool {
        return true
    }
}
