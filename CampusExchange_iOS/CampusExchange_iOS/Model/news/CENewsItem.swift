//
//  CENewsItem.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-03-10.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CENewsItem: NSObject {
    var photoUrl: String = ""
    
    var author : String = ""
    
    var content: String = ""
    
    var title: String = ""
    
    var createDate: String = ""
    
    var newId: Int  = -1
    
    init(data: Dictionary<String , AnyObject>){
        super.init()
        
        if let PhotoUrl = data["thumbnails"] as? String{
            self.photoUrl = PhotoUrl
        }
        
        if let Author = data["author"] as? String{
            self.author = Author
        }
        
        if let Title = data["title"] as? String{
            self.title = Title
        }
        
        if let Content = data["content"] as? String{
            self.content = Content
        }
        
        if let createddate = data["createddate"] as? String{
            self.createDate = createddate
        }
        
        if let id = data["newsid"] as? Int{
            self.newId = id
        }
    }
}
