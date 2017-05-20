//
//  CEUser.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-03-10.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEUser: NSObject {
    
    var id: Int = 0
    
    var phone: String = ""
    
    var nickname: String = ""
    
    var email: String  = ""
    
    var photourl : String = ""
    
    init(userID : Int){
        super.init()
        id = userID
    }
    
    init(data: Dictionary<String, Any>){
        super.init()
        if let PHONE = data["phone"] as? String{
            self.phone = PHONE
        }
        
        if let ID = data["userid"] as? Int{
            self.id = ID
        }
        
        if let Nickname = data["nickname"] as? String{
            self.nickname = Nickname
        }
        
        if let Email = data["email"] as? String{
            self.email = Email
        }
        
        if let PhotoUrl = data["photourl"] as? String{
            self.photourl = PhotoUrl
        }
        
    }
    
    func updateInfo(data: Dictionary<String, Any>){
        if let PHONE = data["phone"] as? String{
            self.phone = PHONE
        }
        
        if let Nickname = data["nickname"] as? String{
            self.nickname = Nickname
        }
        
        if let Email = data["email"] as? String{
            self.email = Email
        }
        
        if let PhotoUrl = data["photourl"] as? String{
            self.photourl = PhotoUrl
        }
    }
    
}
