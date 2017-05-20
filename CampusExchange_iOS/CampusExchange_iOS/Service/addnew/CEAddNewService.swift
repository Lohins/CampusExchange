//
//  CEAddNewService.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-03-17.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEAddNewService: NSObject {
    func updateSimgleImage(image: UIImage , finishBlk: @escaping (_ flag: Bool , _ url : String)-> Void){
        
        let url = GlobalValue.BASEURL + "admin/admin_post_base64/"
        
        guard let data = UIImageJPEGRepresentation(image, 1.0)  else {
            finishBlk(false , "")
            return
        }
//        let data = UIImageJPEGRepresentation(image, 1.0)
        let base64Str = data.base64EncodedString()
        
        
        
        let params = [
            "content" : base64Str,
            "format" : ".jpg"
        ]
        
        CEBaseNetworkService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (result, error) in
            if error != nil{
                finishBlk(false , "")
                return
            }
            
            guard let result = result, let status = result["status"] as? Int else{
                finishBlk(false , "")
                return
            }
            if status != 1{
                finishBlk(false , "")
                return
            }
            else{
                let data = result["data"] as! Dictionary<String, AnyObject>
                let url = data["url"] as! String
                finishBlk(true , url)
            }
        }
    }
    
    func addNewPost(params : Dictionary<String, AnyObject> , finishBlk:@escaping (_ flag : Bool)-> Void){
        let url = GlobalValue.BASEURL + "create_post/"
        CEBaseNetworkService.sharedInstance.postWithoutCache(url, params: params) { (result, error) in
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
