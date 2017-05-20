//
//  CENewsVC.swift
//  CampusExchange_iOS
//
//  Created by Weibo Wang on 2017/3/20.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CENewsVC: UIViewController {
    
    let CELL_IDENTIFIER = "CENewsViewCell"
    
    var tableView: UITableView!
    
    var newsList = [CENewsItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        self.updateUI(pagenum: 1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(){
        self.edgesForExtendedLayout = UIRectEdge()
        
        let headerView = self.headerView()
        self.view.addSubview(headerView)
        
        // table view
        let table_height = GlobalValue.SCREENBOUND.height - headerView.height
        
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: table_height))
        self.tableView.top = headerView.bottom
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.sectionFooterHeight = CGFloat(374)
        self.tableView.register(UINib.init(nibName: CELL_IDENTIFIER, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER)
        self.view.addSubview(tableView)
        
    }
    
    func updateUI(pagenum: Int){
        let service = CENewsService()
        service.getNewsList(pageNum: pagenum){ [weak self](list) in
            if let weakSelf = self{
                weakSelf.newsList = list
                weakSelf.tableView.reloadData()
            }
        }
        print(newsList)
    }
    
    func headerView()-> UIView{
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: CGFloat(72)))
        headerView.backgroundColor = UIColor.init(RGBWithRed: 211, green: 17, blue: 69, alpha: 1)
        
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: GlobalValue.NVBAR_HEIGHT))
        titleLabel.text = "WHAT’S HAPPENING?"
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
    
    
    
    func dismissAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension CENewsVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(374)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as! CENewsViewCell
        let news = self.newsList[indexPath.row]
        print (indexPath.row)
        cell.updateUI(news: news)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let news = self.newsList[indexPath.row]
        let vc = CENewsDetailVC.init(news: news)
        self.present(vc, animated: false, completion: nil)
    }
    
}

