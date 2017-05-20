//
//  CEMerchandise.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-03-10.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CEMerchandise: NSObject {
    
    var postTime: String = "Today"
    
    var productPrice: NSString = "0"
    
    var photoUrl: String = ""
    
    var isBrandNew : Int  = 0
    
    var isNegotiable : Int  = 0
    
    var productName: String = ""
    
    var productImage : [String] = [String]()
    
    var isCollected: Int = 1
    
    var postId : Int = 0
    
    var nickName: String = ""
    
    // 一下 是 给 detail 使用的
    var contactInfo: String = ""
    
    var productCategory: Int = -1
    
    var phone: String = ""
    
    var productStatus : String = ""
    
    var summary : String = ""
    
    
    
    
    // 在 首页 和 bookmark 中使用
    init(data: Dictionary<String , AnyObject>){
        super.init()
        
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 2
        
        if let PostTime = data["posttime"] as? String{
            self.postTime = PostTime.substring(with: PostTime.index(PostTime.startIndex, offsetBy:2)..<PostTime.index(PostTime.startIndex, offsetBy:10))
        }
        
        if let ProductPrice = data["productprice"] as? Float{
            self.productPrice = NSString(format:"%.2f",ProductPrice)
        }
        
        if let PhotoUrl = data["photourl"] as? String{
            self.photoUrl = PhotoUrl
        }
        
        if let IsBrandNew = data["is_brandnew"] as? Int{
            self.isBrandNew = IsBrandNew
        }
        
        if let Is_Negotiable = data["is_negotiable"] as? Int{
            self.isNegotiable = Is_Negotiable
        }
        
        if let Negotiable = data["negotiable"] as? Int{
            self.isNegotiable = Negotiable
        }
        
        if let ProductName = data["productname"] as? String{
            self.productName = ProductName
        }
        
        if let ProductImages = data["productimage"] as? [String]{
            self.productImage = ProductImages
//            let data = ProductImage.data(using: .utf8)
//            do{
//                let list = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
//                if let list = list as? [Dictionary<String, String>]{
//                    //            productImage = ProductImage
//                    print(list)
//                    for item in list{
//                        if item.keys.count == 1{
//                            let key = item.keys.first!
//                            self.productImage.append(item[key]!)
//                        }
//                    }
//                }
//            }
//            catch{
//            }

        }
        else if let ProductImages = data["productimage"] as? String{
            let data = ProductImages.data(using: .utf8)
            do{
                let list = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                if let list = list as? [Dictionary<String, String>]{
                    //            productImage = ProductImage
                    print(list)
                    for item in list{
                        if item.keys.count == 1{
                            let key = item.keys.first!
                            self.productImage.append(item[key]!)
                        }
                    }
                }
            }
            catch{
            }
        }
        
        if let IsCollected = data["is_collected"] as? Int{
            self.isCollected = IsCollected
        }
        
        if let PostId = data["postid"] as? Int{
            self.postId = PostId
        }
        
        if let NickName = data["nickname"] as? String
        {
            self.nickName = NickName
        }
        
        // detail
        if let Description = data["description"] as? String
        {
            self.summary = Description
        }
        
        if let ContactInfo = data["contackinfo"] as? String
        {
            self.contactInfo = ContactInfo
        }
        
        if let Phone = data["phone"] as? String
        {
            self.phone = Phone
        }
        
        if let ProductCategory = data["productcategory"] as? Int
        {
            self.productCategory = ProductCategory
        }
        
        if let CategoryID = data["categoryid"] as? Int
        {
            self.productCategory = CategoryID
        }
        
        if let ProductStatusID = data["productstatusid"] as? Int{
            if ProductStatusID == 4{
                self.productStatus = "new"
            }
            if ProductStatusID == 2 {
                self.productStatus = "expiresoon"
            }
        }
        
        
        if let ProductStatus = data["productstatus"] as? String
        {
            self.productStatus = ProductStatus
        }
        
    }
    
}
