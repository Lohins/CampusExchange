//
//  CEBaseTableView.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-02-24.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

import MJRefresh

class CEBaseTableView: UITableView {
    
    // 描述：
    // 初始化函数：
    // 参数： frame， header block， footer block
    // note: 只有当传进的 block 不为空时，才会 添加 header 或者footer。因为有些页面并不是两者都需要。
    init(frame: CGRect, headerRefreshBlk : (()->Void)?, footerRefreshBlk : (()->Void)?){
        
        super.init(frame: frame, style: .plain)
        
        // 初始化 header
        if let headerBlk = headerRefreshBlk{
            let header = MJRefreshNormalHeader.init(refreshingBlock: {
                headerBlk()
                self.mj_header.endRefreshing()
            })
            // header 被拉动时显示的内容
//            header?.setTitle(String.localizedString("TableHeaderRefresh-Idle"), for: .idle)
//            header?.setTitle(String.localizedString("TableHeaderRefresh-Pulling"), for: .pulling)
//            header?.setTitle(String.localizedString("TableHeaderRefresh-Loading"), for: .refreshing)
            
            self.mj_header = header
        }
        
        
        if let footerBlk = footerRefreshBlk{
            // 初始化 footer
            let footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
                footerBlk()
                self.mj_footer.endRefreshing()
            })
//            footer?.setTitle(String.localizedString("TableFooterRefresh-Idle"), for: .idle)
//            footer?.setTitle(String.localizedString("TableFooterRefresh-Pulling"), for: .pulling)
//            footer?.setTitle(String.localizedString("TableFooterRefresh-Loading"), for: .refreshing)
            
            self.mj_footer = footer
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
