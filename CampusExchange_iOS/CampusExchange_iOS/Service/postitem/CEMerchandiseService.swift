//
//  CEMerchandiseService.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-03-10.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEMerchandiseService: NSObject {
    
    // 获取 category
    func getCategories(finishBlock: @escaping (_ list : [CECategory])-> Void){
        
        let url = GlobalValue.BASEURL + "get_category_list/"
        
        CEBaseNetworkService.sharedInstance.getWithoutCache(url, params: nil) { (result, error) in
            if error != nil {
                finishBlock([])
                return
            }
            
            guard let result = result, let status = result["status"] as? Int else{
                finishBlock([])
                return
            }
            
            if status == 1{
                var backList = [CECategory]()
                let dataList = result["data"] as! [Dictionary<String, Any>]
                for data in dataList{
                    let category = CECategory.init(data: data)
                    backList.append(category)
                }
                finishBlock(backList)
            }
            else{
                finishBlock([])
            }
        }
    }
    
    // get posts
    // 当 filter = -1， 为空， 否则为其他的 category id
    func getPostsBy(sortId: Int, filter: Int, page_index: Int, finishBlock: @escaping (_ list: [CEMerchandise])-> Void){
        let url = GlobalValue.BASEURL + "get_posts/"
        
        var params = Dictionary<String, Any>()
        if filter == -1{
            params = ["data":
                ["userid" : CEAppCenter.sharedInstance().getUserId(),
                 "sortby" : sortId,
                 "filter" : "",
                 "pagination_position" : page_index] as Dictionary<String, Any>]
        }else{
            params = ["data":
                ["userid" : CEAppCenter.sharedInstance().getUserId(),
                 "sortby" : sortId,
                 "filter" : filter,
                 "pagination_position" : page_index] as Dictionary<String, Any>]
        }

        
        CEBaseNetworkService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (result, error) in
            if error != nil{
                finishBlock([])
                return
            }
            
            guard let result = result, let data = result["data"] as? [Dictionary<String, AnyObject>] else{
                finishBlock([])
                return
            }
            
            var list = [CEMerchandise]()
            for item in data{
                let merchandise = CEMerchandise.init(data: item)
                list.append(merchandise)
            }
            finishBlock(list)
        }
    
    }
    
    // 按关键字搜索
    func getPostBy(KeyWord keyword: String, finishBlock: @escaping (_ list: [CEMerchandise])-> Void){
        let url = GlobalValue.BASEURL + "search_posts/"
        
        let params = ["data" :
            [ "userid" : CEAppCenter.sharedInstance().getUserId(),
              "keyword" : keyword
            ]]
        CEBaseNetworkService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (result, error) in
            if error != nil{
                finishBlock([])
                return
            }
            
            guard let result = result, let data = result["data"] as? [Dictionary<String, AnyObject>] else{
                finishBlock([])
                return
            }
            
            var list = [CEMerchandise]()
            for item in data{
                let merchandise = CEMerchandise.init(data: item)
                list.append(merchandise)
            }
            finishBlock(list)
        }
        

    }
    
    // bookmark a posted item
    func changeBookmarkStatusBy(postId: Int, isCollected: Int, finishBlock: @escaping (_ flag: Bool)-> Void){
        let url = GlobalValue.BASEURL + "bookmark_posts/"
        let params = ["data":
        [
            "userid" : CEAppCenter.sharedInstance().getUserId(),
            "postid" : postId,
            "operationid" : isCollected
            ]]
        
        
        CEBaseNetworkService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (result, error) in
            if error != nil{
                finishBlock( false)
                return
            }
            
            guard let result = result, let data = result["data"] as? Dictionary<String, AnyObject>, let status = data["status"] as? Int else{
                finishBlock(false)
                return
            }
            if status == 1{
                finishBlock(true)
            }
            else{
                finishBlock(false)
            }
            
        }
    }
    
    // 获取 帖子的详细信息
    func getPostDetailBy(id: Int, finishBlock: @escaping (_ merchandise: CEMerchandise? , _ error : Error?)-> Void){
        let url = GlobalValue.BASEURL + "get_post_detail/"
        let params = ["data":
        [
            "postid" : id]
        ]
        
        CEBaseNetworkService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (result, error) in
            if error != nil{
                finishBlock( nil , error)
                return
            }
            
            guard let result = result, let status = result["status"] as? Int, let data = result["data"] as? Dictionary<String, AnyObject> else{
                finishBlock( nil , NSError.init())
                return
            }
            
            if status == 1{
                let merchandise = CEMerchandise.init(data: data)
                finishBlock( merchandise , nil)
                return
            }
            else{
                finishBlock( nil , NSError.init())
                return
            }
        }
    }

}
