//
//  CEPostedItemVC.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/3/2.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEPostedItemVC: UIViewController {
    
    let CELL_IDENTIFIER = "CEPostedItemCell"
    
    var avatarImageView: UIImageView!
    
    var nameLabel: UILabel!
    
    var tableView: UITableView!
    
    var postItemList = [CEMerchandise]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        
//        self.updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateUI()
    }
    
    func setupUI(){
        
        self.view.backgroundColor = UIColor.white
        
        let headerView = self.headerView()
        self.view.addSubview(headerView)
        
        let avatarView = self.avatarView()
        avatarView.top = headerView.bottom
        self.view.addSubview(avatarView)
        
        
        // table view
        let table_height = GlobalValue.SCREENBOUND.height - headerView.height - headerView.height
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: table_height))
        self.tableView.top = avatarView.bottom
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.sectionFooterHeight = CGFloat(9)
        self.tableView.register(UINib.init(nibName: CELL_IDENTIFIER, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER)
        self.view.addSubview(tableView)
        
    
    }
    
    func updateUI(){
        let service = CEPostService()
        service.getMyPosts { [weak self] (list, nickName, photoUrl) in
            if let weakSelf = self{
                if let url = URL.init(string: photoUrl){
                    weakSelf.avatarImageView.setImageWith(url)
                }
                weakSelf.nameLabel.text = nickName
                weakSelf.postItemList = list
                weakSelf.tableView.reloadData()
            }
        }
    }
    
    func headerView()-> UIView{
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: GlobalValue.NVBAR_HEIGHT + GlobalValue.STATUSBAR_HEIGHT))
        headerView.backgroundColor = UIColor.init(RGBWithRed: 211, green: 17, blue: 69, alpha: 1)
        
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: GlobalValue.NVBAR_HEIGHT))
        titleLabel.text = "YOUR FOR SALE ITEMS"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.init(name: "SFUIText-Semibold", size: 16)
        titleLabel.center = CGPoint.init(x: headerView.width / 2, y: 0)
        titleLabel.top = GlobalValue.STATUSBAR_HEIGHT
        headerView.addSubview(titleLabel)
        
        let dismissBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        dismissBtn.setImage(UIImage.init(named: "post_dismiss_icon"), for: .normal)
        dismissBtn.center = titleLabel.center
        dismissBtn.left = CGFloat(16)
        dismissBtn.addTarget(self, action: #selector(self.dismissAction), for: .touchUpInside)
        headerView.addSubview(dismissBtn)
        
        return headerView
    }
    

    func avatarView() -> UIView{
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: 100))
        
        self.avatarImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 64, height: 64))
        self.avatarImageView.image = UIImage.init(named: "pic1")
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.width / 2
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.center = CGPoint.init(x: view.width / 2, y: 0)
        self.avatarImageView.top = 10
        
        view.addSubview(self.avatarImageView)
        
        self.nameLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: 14))
        self.nameLabel.text = "Hello Kitty"
        self.nameLabel.textAlignment = .center
        self.nameLabel.font = UIFont.init(name: "SFUIText-Semibold", size: 12)
        self.nameLabel.textColor = UIColor.init(RGBWithRed: 83, green: 88, blue: 96, alpha: 1)
        self.nameLabel.top = self.avatarImageView.bottom + 8
        view.addSubview(self.nameLabel)
        
        return view
    }
    
    func dismissAction(){
        self.dismiss(animated: true, completion: nil)
    }

}

extension CEPostedItemVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.postItemList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as! CEPostedItemCell
        let goods = self.postItemList[indexPath.section]
        cell.updateUI(goods: goods)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: 9))
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let goods = self.postItemList[indexPath.section]
        
        // 修改按钮
        let editAction = UITableViewRowAction.init(style: .normal, title: "EDIT", handler: {_,_ in

            let vc = CEUpdateItemDetailVC.init(post:goods)
            let nav = UINavigationController.init(rootViewController: vc)
            self.modalTransitionStyle = .partialCurl
            self.tableView.reloadRows(at: [indexPath], with:.right)
            self.present(nav, animated: true, completion: nil)
            

        })
        editAction.backgroundColor = UIColor.init(RGBWithRed: 83, green: 88, blue: 96, alpha: 1)

        // 售出按钮
        let soldAction = UITableViewRowAction.init(style: .destructive, title: "SOLD", handler: {_,_ in
            let service = CEPostService()
            service.updateMyPostBy(postId: goods.postId, operationId: 1, finishBlock: { (flag) in
                if flag == true {
                    self.postItemList.remove(at: indexPath.section)
                    self.tableView.reloadData()
                }
            })
        })
        
        soldAction.backgroundColor = UIColor.init(RGBWithRed: 211, green: 17, blue: 69, alpha: 1)
        
        return [ soldAction , editAction]
    }
}
