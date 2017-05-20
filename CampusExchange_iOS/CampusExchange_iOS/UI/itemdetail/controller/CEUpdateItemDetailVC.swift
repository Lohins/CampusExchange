//
//  CEUpdateItemDetailVC.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-03-03.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit
import iOS_Slide_Menu

class CEUpdateItemDetailVC: UIViewController {
    
    var postItem : CEMerchandise!
    
    var mainScrollView : CELinearScrollView!
    
    var photoListBar: CEPhotoListBar!
    
    var nameTextRow: CEAddTextRowView!
    
    var categoryRow: CEAddOptionRowView!
    
    var priceTextRow: CEAddTextRowView!
    
    var negotiateRow: CEAddButtonRow!
    
    var conditionRow: CEAddOptionRowView!
    
    var expirationRow: CEAddOptionRowView!
    
    var descriptionBox: CEAddParagraphRowView!
    
    var contactRow: CEAddButtonRow!
    
    var phoneTextRow: CEAddTextRowView!
    
    var otherInfoTextRow: CEAddTextRowView!
    
    var updateButton: UIButton!
    
    var imageList = [UIImage]()
    
    var postIndicator: UIActivityIndicatorView!
    
    init(post: CEMerchandise){
        super.init(nibName: nil, bundle: nil)
        self.postItem = post
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        
        self.updateData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(RGBWithRed: 211, green: 17, blue: 69, alpha: 1)
        
        let backButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
        backButton.setImage(UIImage.init(named: "back_button_icon"), for: .normal)
        backButton.bk_(whenTapped: {  [weak self] in
            if let weakSelf = self{
                weakSelf.dismiss(animated: true, completion: nil)
            }
        })
        
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
        
        // title
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 30))
        titleLabel.text = "UPDATE ITEM DETAILS"
        titleLabel.font = UIFont.init(name: "SFUIText-Semibold", size: 16)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
        
    }

    
    
    func setupUI(){
        
        self.edgesForExtendedLayout = UIRectEdge()
        
        let padding = CGFloat(8)
        
        let section_width = GlobalValue.SCREENBOUND.width - 2 * padding
        
        self.mainScrollView = CELinearScrollView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: GlobalValue.SCREENBOUND.height - GlobalValue.STATUSBAR_HEIGHT - GlobalValue.NVBAR_HEIGHT))
        self.mainScrollView.bounces = false
        self.view.addSubview(self.mainScrollView)
        
        // photo list
        self.photoListBar = CEPhotoListBar.init(images: self.postItem.productImage)
        self.mainScrollView.linear_addSubview(self.photoListBar, paddingTop: 18, paddingBottom: 0)

        
        // what are you selling ?
        self.nameTextRow = CEAddTextRowView.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56), placeHolder: "What are you selling?")
        self.mainScrollView.linear_addSubview(self.nameTextRow, paddingTop: 22, paddingBottom: 0)
        
        // category
        self.categoryRow = CEAddOptionRowView.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56))
        self.mainScrollView.linear_addSubview(self.categoryRow, paddingTop: 13, paddingBottom: 0)
        
        // price
        self.priceTextRow = CEAddTextRowView.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56), placeHolder: "Price")
        self.mainScrollView.linear_addSubview(self.priceTextRow, paddingTop: 13, paddingBottom: 0)
        
        // negotiable
        self.negotiateRow = CEAddButtonRow.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56), text1: "Negotiable", text2: "Fixed Price")
        self.mainScrollView.linear_addSubview(self.negotiateRow, paddingTop: 16, paddingBottom: 0)
        
        // condition
        self.conditionRow = CEAddOptionRowView.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56))
        self.mainScrollView.linear_addSubview(self.conditionRow, paddingTop: 13, paddingBottom: 0)
        
        // expiration
        self.expirationRow = CEAddOptionRowView.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56))
        self.mainScrollView.linear_addSubview(self.expirationRow, paddingTop: 13, paddingBottom: 0)
        
        // phone
        self.phoneTextRow = CEAddTextRowView.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56), placeHolder: "Phone")
        self.mainScrollView.linear_addSubview(self.phoneTextRow, paddingTop: 13, paddingBottom: 0)
        
        // other information
        self.otherInfoTextRow = CEAddTextRowView.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56), placeHolder: "Other Info")
        self.mainScrollView.linear_addSubview(self.otherInfoTextRow, paddingTop: 13, paddingBottom: 0)
        
        // description
        self.descriptionBox = CEAddParagraphRowView.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 168))
        self.mainScrollView.linear_addSubview(self.descriptionBox, paddingTop: 13, paddingBottom: 0)
    
        // post button
        updateButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: 72))
        updateButton.backgroundColor = UIColor.init(RGBWithRed: 83, green: 88, blue: 96, alpha: 1)
        updateButton.setTitle("UPDATE MY POST", for: .normal)
        updateButton.titleLabel?.font = UIFont.init(name: "SFUIText-Regular", size: 20)
        updateButton.setTitleColor(UIColor.white, for: .normal)
        updateButton.addTarget(self, action: #selector(self.updateAction), for: .touchUpInside)
        self.mainScrollView.linear_addSubview(updateButton, paddingTop: 16, paddingBottom: 0)
        
        // Activity Indicator
        self.postIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.postIndicator.center = CGPoint.init(x: GlobalValue.SCREENBOUND.width / 2, y: GlobalValue.SCREENBOUND.height - GlobalValue.NVBAR_HEIGHT - GlobalValue.STATUSBAR_HEIGHT - CGFloat(36))
        self.view.addSubview(self.postIndicator)
    }
    
    func updateData(){
        // Load select options
        let service = CEMerchandiseService()
        service.getCategories { [weak self] (list) in
            var dict = Dictionary<String, Int>()
            for item in list{
                dict[item.name] = item.id
            }
            if let weakSelf = self{
                weakSelf.categoryRow.updateOptions(options: dict)
                weakSelf.categoryRow.setValue(id: weakSelf.postItem.productCategory)
            }
        }
            
        let conditionDict = ["used" : 0 , "brand new" : 1]
        self.conditionRow.updateOptions(options: conditionDict)
        self.conditionRow.updateHeader(title: "Condition", msg: "Select product condition")
        
        let timeDict = [ "3 days" : 3 , "7 days" : 7, "30 days" : 30]
        self.expirationRow.updateOptions(options: timeDict)
        self.expirationRow.updateHeader(title: "Post Duration", msg: "Select your post available time")

        // Load user setting
        self.nameTextRow.setContent(content: self.postItem.productName)
        self.priceTextRow.setContent(content: self.postItem.productPrice as String)
        self.phoneTextRow.setContent(content: self.postItem.phone)
        self.otherInfoTextRow.setContent(content: self.postItem.contactInfo)
        self.descriptionBox.setContent(content: self.postItem.summary)
        self.conditionRow.setValue(id: self.postItem.isBrandNew)
        self.expirationRow.setValue(id: 3)
        if self.postItem.isNegotiable == 1 {
            self.negotiateRow.setDefaultIndex(index: 0)
        } else {
            self.negotiateRow.setDefaultIndex(index: 1)
        }
    }
    
    func updateAction(){
        

        // load required data.
        guard let productName = self.nameTextRow.getContent(), let categoryId = self.categoryRow.getSelectedValue(),
            let price = self.priceTextRow.getContent(),  let is_brandnew = self.conditionRow.getSelectedValue(),
            let expire = self.expirationRow.getSelectedValue() , let phone = self.phoneTextRow.getContent() ,
            let email = self.otherInfoTextRow.getContent() else{
            
            //TODO: Format Check Alert
            
            return
        }
        
        // Start post process, show process indicator in button view
        self.updateButton.setTitle("", for: .normal)
        self.updateButton.isEnabled = false
        self.postIndicator.startAnimating()
        
        // load not-required data
        let is_negotiable = self.negotiateRow.getSelectedId()
        let description = self.descriptionBox.getContent()
        
        
        // upload image
        let uploadImgservice = CEAddNewService()
        let groupQueue = DispatchGroup()
        
        var imgUrlList = [Dictionary<String, String>]()
        let dataList = self.photoListBar.getData()
        var count = 0
        for item in dataList{
            // no nil
            if let exist = item {
                if let image = exist as? UIImage{
                    // uiimage
                    groupQueue.enter()
                    let queue = DispatchQueue.init(label: "Queue:\(count)")
                    count = count + 1
                    queue.async (group: groupQueue){
                        uploadImgservice.updateSimgleImage(image: image, finishBlk: { (flag, url) in
                            if flag == false{
                                print("Error occur when uploading image.")
                            }
                            else if url != ""{
                                let dict = ["filename_\(count)" : url]
                                imgUrlList.append(dict)
                            }
                            
                            groupQueue.leave()
                        })
                    }
                }
                else{
                    // string
                    let url = exist as! String
                    let dict = ["filename_\(count)" : url]
                    imgUrlList.append(dict)
                    count = count + 1
                }
            }
        }
        
        // post
        let post_service = CEPostService()
        groupQueue.notify(queue: DispatchQueue.main) {
            print("End")
            print(imgUrlList)
            var jsonStr = ""
            do{
                let data = try JSONSerialization.data(withJSONObject: imgUrlList, options: .prettyPrinted)
                if let json = String.init(data: data, encoding: .utf8){
                    jsonStr = json
                    
                    let params = [
                        "data" : [
                            "postid" : self.postItem.postId,
                            "userid" : CEAppCenter.sharedInstance().getUserId(),
                            "imagepath" : jsonStr,
                            "productname" : productName,
                            "productcategory" : categoryId,
                            "productprice" : price,
                            "is_brandnew" : is_brandnew,
                            "is_negotiable" : is_negotiable,
                            "expireduration" : expire,
                            "description" : description,
                            "phone" : phone,
                            "contactinfo" : email
                        ]
                    ]
                    post_service.updatePostBy(data: params as Dictionary<String, AnyObject>, finishBlock: {
                        (flag) in
                        
                        // Stop Indicator, recover button status
                        self.postIndicator.stopAnimating()
                        self.updateButton.setTitle("POST MY ITEM", for: .normal)
                        self.updateButton.isEnabled = true
                        
                        if flag == true {
                            // success
                            self.dismiss(animated: true, completion: nil)
                            
                        } else {
                            // error msg
                        }
                    })

                }
                else{
                    return
                }
            }
            catch{
                return
            }
        }
        
    }
    

}
