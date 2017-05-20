//
//  CESortTableViewController.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/2/26.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

protocol SortRefreshProtocol {
    func sortUpdateWith(id : Int)
}

class CESortTableViewController: UITableViewController {
    
    var previousSelectedCellIndex : Int = 0
    
    let CELL_IDENTIFIER = "CERankTableCell"
    
    var delegate: SortRefreshProtocol?

    
    var data = [String]()
    
    var dataList:[CESort] = [CESort]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib.init(nibName: CELL_IDENTIFIER, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER)
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView.init()
        
        
        self.previousSelectedCellIndex = 0
        
        let sort1 = CESort.init(Id: 0, Name: "Recently")
        let sort2 = CESort.init(Id: 1, Name: "Price low to high")
        let sort3 = CESort.init(Id: 2, Name: "Price high to low")
        let sort4 = CESort.init(Id: 3, Name: "Price negotiable")
        
        self.dataList = [sort1 , sort2 , sort3 , sort4]
        self.tableView.reloadData()
        
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
        titleLabel.text = "SORT YOUR DISCOVERY"
        titleLabel.font = UIFont.init(name: "SFUIText-Semibold", size: 16)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        if let delegate = self.delegate{
            delegate.sortUpdateWith(id: self.previousSelectedCellIndex)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER , for: indexPath) as! CERankTableCell
        
        
        if indexPath.row > (self.dataList.count - 1){
            return cell
        }
        
        let item = self.dataList[indexPath.row]
        
        cell.setDataItem(item: item)
        
        if indexPath.row == self.previousSelectedCellIndex{
            
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oldCell = tableView.cellForRow(at: IndexPath.init(row: self.previousSelectedCellIndex, section: 0))
        
        oldCell?.setSelected(false, animated: false)
        
        let newCell = tableView.cellForRow(at: indexPath)
        
        newCell?.setSelected(true, animated: false)
        
        self.previousSelectedCellIndex = indexPath.row
        
    }


}
