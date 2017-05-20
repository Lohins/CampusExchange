//
//  CEMainPageVC.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-02-24.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

import iOS_Slide_Menu

class CEMainPageVC: UIViewController {
    var menuBarButton   : UIBarButtonItem!
    var searchBarButton : UIBarButtonItem!
    var cancelBarButton : UIBarButtonItem!

    var searchBar : CEMPSearchBar!
    
    var headerView: CEMPHeaderView!
    
    // data source
    var merchandiseList = [CEMerchandise]()
    
    
    var collectionLayout = UICollectionViewFlowLayout()
    var collectionView : CEBaseCollectionView!
    
    let service = CEMerchandiseService()
    
    // 过滤
    let sortVC = CESortTableViewController()
    let filterVC = CEFilterTableViewController()
    
    // 搜索设置
    let searchSetting = CEGetGoodsSetting.init()
    
    let cell_identifier = "CEGoodsCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavBar()
        
        self.setupUI()
        
        self.sortVC.delegate = self
        self.filterVC.delegate = self
        
        // 一开始的时候，filter = nil (-1)， sort = 0, page = 1
        
        self.fetchDataBy(index: 1)
    }
    
    func updateDataWith(Keyword:String){
        self.service.getPostBy(KeyWord: Keyword) { [weak self](list) in
            if let weakSelf = self{
                weakSelf.merchandiseList = list
                weakSelf.collectionView.reloadData()
            }
        }
    }
    
    func fetchDataBy( index:Int){
        self.service.getPostsBy(sortId: self.searchSetting.sortId, filter: self.searchSetting.filterId , page_index:index) { [weak self](list) in
            if let weakSelf = self{
                // 意味着 是上拉刷新 或者 是初始化加载
                if index == 1{
                    weakSelf.merchandiseList.removeAll()
                    weakSelf.merchandiseList = list
                }
                // 意味着是下拉加载
                else{
                    weakSelf.merchandiseList.append(contentsOf: list)
                }
                
                weakSelf.collectionView.reloadData()
            }
        }
    }
    
    func setupNavBar(){
        self.edgesForExtendedLayout = UIRectEdge()

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.init(RGBWithRed: 211, green: 17, blue: 69, alpha: 1)
        
        // title 
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 32))
        titleLabel.text = "CAMPUS EXCHANGE"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.init(name: "CollegeBold", size: 24)
        self.navigationItem.titleView = titleLabel
        
        // left bar button
        let leftButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 25, height: 25))
        leftButton.setImage(UIImage.init(named: "mainpage_menu_icon"), for: .normal)
        leftButton.addTarget(SlideNavigationController.sharedInstance(), action: #selector(SlideNavigationController.sharedInstance().toggleLeftMenu), for: .touchUpInside)
        self.menuBarButton = UIBarButtonItem.init(customView: leftButton)
        SlideNavigationController.sharedInstance().leftBarButtonItem = self.menuBarButton
        
        // right bar button
        let rightButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 25, height: 25))
        rightButton.setImage(UIImage.init(named: "mainpage_search_icon"), for: .normal)
        rightButton.addTarget(self, action: #selector(self.searchBarAction), for: .touchUpInside)
        self.searchBarButton = UIBarButtonItem.init(customView: rightButton)
        self.navigationItem.rightBarButtonItem = self.searchBarButton
        
        let cancelButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 25, height: 25))
        cancelButton.setImage(UIImage.init(named: "post_dismiss_icon"), for: .normal)
        cancelButton.addTarget(self, action: #selector(self.cancelBarAction), for: .touchUpInside)
        self.cancelBarButton = UIBarButtonItem.init(customView: cancelButton)
        
    }
    
    // 点击 搜索按钮， nav bar 的 标题和 右边按钮 都需要变换。同时在导航栏下面显示 搜索框
    func searchBarAction(){
        self.navigationItem.rightBarButtonItem = self.cancelBarButton
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView.init())
        
        
        if let titleLabel = self.navigationItem.titleView as? UILabel{
            titleLabel.text = "DISCOVER ITEMS"
        }
        
        // display search bar under the navigation bar
        UIView.animate(withDuration: 0.5, animations: {
            self.headerView.top = self.searchBar.bottom
            self.collectionView.top = self.headerView.bottom
            self.collectionView.height = self.collectionView.height - self.searchBar.height
            self.searchBar.alpha = 1
        }, completion: { (flag) -> Void in
            self.searchBar.show()
        })
        
    }
    
    // 点击 取消按钮， 应当把 导航栏的 部件还原到初始状态，
    func cancelBarAction(){
        self.navigationItem.rightBarButtonItem = self.searchBarButton
        
        self.navigationItem.leftBarButtonItem = self.menuBarButton

        if let titleLabel = self.navigationItem.titleView as? UILabel{
            titleLabel.text = "CAMPUS EXCHANGE"
        }
        
        // dismiss search bar and resize the collection

        UIView.animate(withDuration: 0.5, animations: {
            self.headerView.top = self.searchBar.top
            self.collectionView.top = self.headerView.bottom
            self.collectionView.height = self.collectionView.height + self.searchBar.height
            self.searchBar.alpha = 0
        }, completion: { (flag) -> Void in
            self.searchBar.dismiss()
        })
        
    }
    
    func setupUI(){
        self.view.backgroundColor = UIColor.white
        
        // init search bar
        self.searchBar = CEMPSearchBar.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: 50))
        self.searchBar.alpha = 0
        self.searchBar.searchBlock = { [weak self] (text)->Void in
            if let weakSelf = self{
                weakSelf.updateDataWith(Keyword: text)
            }
            
        }
        
        // add header view
        
        headerView = CEMPHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: 48))
        headerView.sortBlock = { [weak self] ()-> Void in
            if let weakSelf = self{
                weakSelf.navigationController?.pushViewController(weakSelf.sortVC, animated: true)
            }
        }
        
        headerView.filterBlock = { [weak self] ()-> Void in
            if let weakSelf = self{
                weakSelf.navigationController?.pushViewController(weakSelf.filterVC, animated: true)
            }
        }
        
        
        
        // add bottom view
        let bottomView = CEMPBottomView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: 87))
        bottomView.bottom = GlobalValue.SCREENBOUND.height - GlobalValue.STATUSBAR_HEIGHT - GlobalValue.NVBAR_HEIGHT
        
        
        // collection view
        // pull to reload
        let headerBlk = { [weak self] ()-> Void in
            if let weakSelf = self{
                weakSelf.fetchDataBy(index: 1)
            }
        }
        let footerBlk = {[weak self] ()-> Void in
            if let weakSelf = self{
                let index = weakSelf.merchandiseList.count + 1
                weakSelf.fetchDataBy(index: index)
            }
        }
        self.collectionView = CEBaseCollectionView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: bottomView.top - headerView.bottom + 31 ), layout: self.collectionLayout, headerBlock: headerBlk, footerBlock: footerBlk)
        self.collectionView.top = headerView.bottom
        self.collectionView.register(UINib.init(nibName: cell_identifier, bundle: Bundle.main), forCellWithReuseIdentifier: cell_identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.white
        
        
        let cell_width = ( GlobalValue.SCREENBOUND.width - 8 * 2 - 11 ) / 2
        let cell_height = cell_width + 36
        
        self.collectionLayout.minimumInteritemSpacing = 11
        self.collectionLayout.minimumLineSpacing = 8
        self.collectionLayout.itemSize = CGSize.init(width: cell_width, height: cell_height)
        self.collectionLayout.scrollDirection = .vertical
        self.collectionLayout.headerReferenceSize = CGSize.zero
        self.collectionLayout.headerReferenceSize = CGSize.zero
        self.collectionLayout.sectionInset = UIEdgeInsets.init(top: 10, left: 8, bottom: 32, right: 8)
        
        self.view.addSubview(searchBar)
        self.view.addSubview(headerView)
        self.view.addSubview(self.collectionView)
        self.view.addSubview(bottomView)
        
    }

}

extension CEMainPageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.merchandiseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_identifier, for: indexPath) as! CEGoodsCollectionViewCell
        
        let data = self.merchandiseList[indexPath.row]
        cell.updateData(item: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let merchandise = self.merchandiseList[indexPath.row]
        let vc = CEItemDetailVC.init(MerchandiseId: merchandise.postId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.collectionLayout.itemSize
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.collectionLayout.sectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.collectionLayout.minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.collectionLayout.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
}

extension CEMainPageVC: SlideNavigationControllerDelegate{
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool {
        return true
    }
}

extension CEMainPageVC: FilterRefreshProtocol, SortRefreshProtocol{
    func sortUpdateWith(id: Int) {
        self.searchSetting.sortId = id
        
        self.fetchDataBy(index: 1)
    }
    
    func filterUpdateWith(id: Int?) {
        if let id = id{
            self.searchSetting.filterId = id
        }
        else{
            self.searchSetting.filterId = -1
        }
        
        self.fetchDataBy(index: 1)

    }
}
