//
//  CEBookmarkService.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/3/14.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEBookmarkService: NSObject {
    
    func getBookmarkList(finishBlk: @escaping (_ list : [CEMerchandise]? , _ error: Error?) -> Void){
        let url = GlobalValue.BASEURL + "get_bookmark_list/"
        let params = ["data" : [
            "userid" : CEAppCenter.sharedInstance().getUserId()
            ]]
        
        CEBaseNetworkService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (result, error) in
            if error != nil{
                finishBlk(nil , error)
                return
            }
            
            guard let result = result, let status = result["status"] as? Int else{
                finishBlk(nil , NSError.init())
                return
            }
            
            if status != 1{
                finishBlk(nil , NSError.init())
                return
            }
            else{
                let rawList = result["data"] as! [Dictionary<String, AnyObject>]
                var list = [CEMerchandise]()
                for item in rawList{
                    let goods = CEMerchandise.init(data: item)
                    list.append(goods)
                }
                finishBlk(list , nil)
            }
        }
    }
    
    
}
