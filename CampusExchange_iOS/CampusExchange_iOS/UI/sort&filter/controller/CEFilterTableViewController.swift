//
//  CEFilterTableViewController.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/2/26.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

protocol FilterRefreshProtocol {
    func filterUpdateWith(id : Int?)
}

class CEFilterTableViewController: UITableViewController {

    var previousSelectedCellIndex : Int = -1
    
    let CELL_IDENTIFIER = "CERankTableCell"
    
    var delegate: FilterRefreshProtocol?
    
    var data = [CECategory]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib.init(nibName: CELL_IDENTIFIER, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER)
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView.init()
        
        self.updateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.edgesForExtendedLayout = UIRectEdge()
        
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
        titleLabel.text = "FILTER YOUR DISCOVERY"
        titleLabel.font = UIFont.init(name: "SFUIText-Semibold", size: 16)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
        
    }
    
    func updateData(){
        
        let service = CEMerchandiseService()
        
        service.getCategories { (list) in
            self.data = list
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let delegate = self.delegate{
            if self.previousSelectedCellIndex == -1{
                delegate.filterUpdateWith(id: nil)
            }
            else{
                delegate.filterUpdateWith(id: self.previousSelectedCellIndex)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.data.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER , for: indexPath) as! CERankTableCell
        
        if indexPath.row > (self.data.count - 1){
            return cell
        }
        
        let item = self.data[indexPath.row]
        
        cell.setDataItem(item: item)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 没选过之前
        if previousSelectedCellIndex == -1{
            let newCell = tableView.cellForRow(at: indexPath)
            newCell?.setSelected(true, animated: false)
            self.previousSelectedCellIndex = indexPath.row
        }
        else{
            let oldCell = tableView.cellForRow(at: IndexPath.init(row: self.previousSelectedCellIndex, section: 0))
            let newCell = tableView.cellForRow(at: indexPath)
            
            if newCell === oldCell{
                newCell?.setSelected(false, animated: false)
                self.previousSelectedCellIndex = -1

            }
            else{
                oldCell?.setSelected(false, animated: false)
                
                newCell?.setSelected(true, animated: false)
                
                self.previousSelectedCellIndex = indexPath.row
                
            }

        }
    }
    

}
