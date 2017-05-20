//
//  CEUserInfoService.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/3/14.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEUserInfoService: NSObject {
    func getUserInfo(){
        let url  = GlobalValue.BASEURL + "get_user_info/"
        let params = ["data" : ["userid" : CEAppCenter.sharedInstance().getUserId()]]
        
        CEBaseNetworkService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (result, error) in
            if error != nil{
                return
            }
            
            guard let result = result, let status = result["status"] as? Int else{
                return
            }
            
            if status != 1{
                return
            }
            else{
                let data = result["data"] as! Dictionary<String, AnyObject>
                CEAppCenter.sharedInstance().user?.updateInfo(data: data)
            }
        }
    }
    
    
    func updateUserInfoWith(nickName name:String , Phone phone: String, Email email:String, PhotoUrl photoUrl: String, finishBlk: @escaping (_ flag: Bool)-> Void){
        let url  = GlobalValue.BASEURL + "update_user_info/"
        let params = ["data" :
            [
                "userid" : CEAppCenter.sharedInstance().getUserId(),
                "nickname": name,
                "phone" : phone,
                "email" : email,
                "photourl" : photoUrl
            ]
        ]
        
        CEBaseNetworkService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (result, error) in
            if error != nil{
                finishBlk(false)
                return
            }
            
            guard let result = result, let status = result["status"] as? Int else{
                finishBlk(false)
                return
            }
            
            if status != 1{
                finishBlk(false)
                return
            }
            else{
                finishBlk(true)
            }
        }
    }
}
