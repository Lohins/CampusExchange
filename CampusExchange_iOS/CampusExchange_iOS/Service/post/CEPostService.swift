//
//  CEPostService.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-03-10.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEPostService: NSObject {
    
    // get my post
    
    func getMyPosts(finishBlock: @escaping (_ list: [CEMerchandise], _ nickName: String,_ photoUrl: String)-> Void){
        let url = GlobalValue.BASEURL + "get_my_posts/"
        
        let params = ["data" :
            [ "userid" : CEAppCenter.sharedInstance().getUserId(),
            ]]
        CEBaseNetworkService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (result, error) in
            if error != nil{
                finishBlock([] , "" , "")
                return
            }
            
            guard let result = result, let data = result["data"] as? Dictionary<String, AnyObject>, let posts = data["posts"] as? [Dictionary<String, AnyObject>], let nickName = data["nickname"] as? String, let photoUrl = data["photourl"] as? String else{
                finishBlock([] , "" , "")
                return
            }
            
            var list = [CEMerchandise]()
            for item in posts{
                let merchandise = CEMerchandise.init(data: item)
                list.append(merchandise)
            }
            finishBlock(list , nickName , photoUrl)
        }
    }
    
    //
    //    更改帖子状态。
    //
    //    Operationid = 1, 将状态设为Sold,
    //    Operationid = 0, 将状态设为原状态
    //    （根据时间、有效期判断）
    
    func updateMyPostBy(postId: Int ,operationId: Int, finishBlock: @escaping (_ flag : Bool) -> Void){
        let url = GlobalValue.BASEURL + "update_my_post/"
        
        let params = ["data" :
            [ "postid" : postId,
              "operationid" : operationId
            ]]
        CEBaseNetworkService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (result, error) in
            if error != nil{
                finishBlock(false)
                return
            }
            
            guard let result = result, let status = result["status"] as? Int else{
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
    
    // create post
    func createPostBy(data: Dictionary<String, AnyObject> , finishBlock: @escaping (_ flag : Bool) -> Void){
        let url = GlobalValue.BASEURL + "create_post/"
        CEBaseNetworkService.sharedInstance.postWithoutCache(url, params: data) { (result, error) in
            if error != nil{
                finishBlock(false)
                return
            }
            
            guard let result = result, let status = result["status"] as? Int else{
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
    
    // update post
    func updatePostBy(data: Dictionary<String, AnyObject> , finishBlock: @escaping (_ flag : Bool) -> Void){
        let url = GlobalValue.BASEURL + "edit_my_post/"
        CEBaseNetworkService.sharedInstance.postWithoutCache(url, params: data) { (result, error) in
            if error != nil{
                finishBlock(false)
                return
            }
            
            guard let result = result, let status = result["status"] as? Int else{
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
}
