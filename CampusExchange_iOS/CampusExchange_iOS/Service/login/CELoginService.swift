//
//  CELoginService.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-03-10.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CELoginService: NSObject {
    
    func loginToCampusWith(userName username: String, password pwd: String, finishBlk: @escaping ((_ flag: Bool) -> Void)){
        
        let url = GlobalValue.BASEURL + "login/"
        
        let params = ["username" : username,
            "password" : pwd]
        
        CEBaseNetworkService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (result, error) in
            if error != nil{
                finishBlk(false)
            }
            
            // 登录学校成功之后， 获取 student id
            if let studentID = result?["studentid"] as? String{
                self.loginToServerWith(studentID: studentID, finishBlock: { (flag) in
                    finishBlk(flag)
                })
            }
            else{
                finishBlk(false)
            }
            
            
        }
    }
    
    
    func loginToServerWith(studentID studentid : String , finishBlock: @escaping ((_ flag: Bool )-> Void)){
        let url = GlobalValue.BASEURL + "login/"
        
        let params = ["data":["studentid" : studentid]]
        CEBaseNetworkService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (result, error) in
            if error != nil || result == nil{
                finishBlock(false)
                return
            }
            
            // status 1 success
            if let status = result?["status"] as? Int{
                if status == 1{
                    // login user gere
                    let user = CEUser.init(data: result!["data"]! as! Dictionary<String, Any>)
                    CEAppCenter.sharedInstance().login(user: user)
                    
                    finishBlock(true )
                    return
                }
                finishBlock(false )
            }
            else{
                finishBlock(false )
            }
        }
        
    }
    
    
    
    
}
