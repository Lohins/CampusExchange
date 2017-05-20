//
//  CEAppCenter.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-02-24.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

//这个类 用于管理整个 App 的数据信息 ： 登录 和其他

class CEAppCenter: NSObject {
    
    var user: CEUser?
    
    static private let instance = CEAppCenter()
    
    class func sharedInstance() -> CEAppCenter{
        return self.instance
    }
    
    func getUserId() -> Int{
        return (self.user?.id)!
    }
    
    func getUserPhoto() -> String{
        return (self.user?.photourl)!
    }
    
    func getUser() -> CEUser{
        return (self.user!)
    }
    
    func updateUserinfo(nickname:String, email:String, phone:String, photourl:String){
        self.user?.nickname = nickname
        self.user?.email = email
        self.user?.phone = phone
        self.user?.photourl = photourl
    }
    
    func login(user: CEUser){
        self.logout()
        self.user = user
    }
    
    func logout(){
        self.user = nil
    }
    
    // 消息提示
    func InfoNotification(vc: UIViewController , title: String , message: String){
        // 提示信息
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        vc.present(alertVC, animated: true, completion: nil)
        
        let timer = DispatchTime.now() + 1.6
        DispatchQueue.main.asyncAfter(deadline: timer) {
            alertVC.dismiss(animated: true, completion: nil)
        }
    }

}
