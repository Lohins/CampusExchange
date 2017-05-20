//
//  CECategory.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-03-10.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CECategory: CERankItem {
    
    init(id: Int , name: String) {
        super.init()
        
        self.id = id
        self.name = name
    }
    
    init(data: Dictionary<String , Any>) {
        super.init()
        
        if let ID = data["categoryid"] as? Int{
            self.id = ID
        }
        else{
            self.id = 1
        }
        
        if let Name = data["categoryname"] as? String{
            self.name = Name
        }
        else{
            self.name = "No Name"
        }
    }
}
