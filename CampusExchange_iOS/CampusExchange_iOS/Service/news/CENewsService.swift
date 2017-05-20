//
//  CENewsService.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-03-10.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CENewsService: NSObject {
    
//    根据分页游标 返回对应新闻列表。
//    前端初始pagenum 设为 0
    func getNewsList(pageNum: Int , finishBlock: @escaping (_ list :[CENewsItem])-> Void){
        let url = GlobalValue.BASEURL + "get_news_list/"
        
        
        let params = ["data" : [
            "pagenum" : pageNum
            ]]
        CEBaseNetworkService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (result, error) in
            if error != nil{
                finishBlock([])
                return
            }
            
            guard let result = result, let status  = result["status"] as? Int, let data = result["data"] as? [Dictionary<String, AnyObject>] else{
                finishBlock([])
                return
            }
            if status != 1{
                finishBlock([])
                return
            }
            
            var backList = [CENewsItem]()
            for datum in data{
                let news = CENewsItem.init(data: datum)
                backList.append(news)
            }
            finishBlock(backList)
            
        }
    }
    
    func getNewsDetailBy(NewsId id: Int, finishBlk: @escaping (_ falg : Bool)->Void){
        let url = GlobalValue.BASEURL + "get_news_item/"
        
        let params = ["data" : [
            "newsid" : id
            ]]
    }
}
