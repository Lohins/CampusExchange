//
//  CEBaseNetworkService.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-02-24.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit
import AFNetworking

typealias finishBlock = (_ result: Dictionary<String, AnyObject>? , _ error: Error?) -> Void

class CEBaseNetworkService: NSObject {
    
//    单例模式
    static let sharedInstance: CEBaseNetworkService = CEBaseNetworkService()
    
    var sessionManager = AFHTTPSessionManager()
    
    override init() {
        super.init()
        
        self.initManager()
    }
    
    func initManager(){
        self.sessionManager.requestSerializer = AFJSONRequestSerializer.init(writingOptions: .init(rawValue: 0))
        self.sessionManager.requestSerializer.timeoutInterval = 8
        self.sessionManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "content-type")
        self.sessionManager.responseSerializer.acceptableContentTypes = NSSet.init(objects: "application/json" , "text/json" , "text/javascript" , "text/html") as? Set<String>
    }
    
    
    // Get Method without cache
    func getWithoutCache(_ url: String , params: Dictionary<String , AnyObject>? , finishBlk:@escaping finishBlock){
        self.sessionManager.get(url, parameters: params, progress: { (progress: Progress) -> Void in
        }, success: { (task, result) -> Void in
            if let jsonDict = result as? Dictionary<String , AnyObject>{
                finishBlk( jsonDict , nil )
            }
            else{
                let error = NSError.init(domain: "Data Missing", code: 20, userInfo: nil)
                finishBlk(nil, error)
            }
        }, failure: { (task , error) -> Void in
            finishBlk(nil , error)
        })
    }
    
    
    // Post Method without cache
    func postWithoutCache(_ url: String , params: Dictionary<String , AnyObject>? , finishBlk:@escaping finishBlock){
        self.sessionManager.post(url, parameters: params, progress: { (progress: Progress) -> Void in
        }, success: { (task, result) -> Void in
            if let jsonDict = result as? Dictionary<String , AnyObject>{
                finishBlk( jsonDict , nil )
            }
            else{
                let error = NSError.init(domain: "Data Missing", code: 20, userInfo: nil)
                finishBlk(nil, error)
            }
        }, failure: { (task , error) -> Void in
            finishBlk(nil , error)
        })
    }
}
