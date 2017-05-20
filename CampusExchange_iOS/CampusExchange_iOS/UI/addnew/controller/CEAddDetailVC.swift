//
//  CEAddDetailVC.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/2/28.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit
import iOS_Slide_Menu

class CEAddDetailVC: UIViewController {
    
    var mainScrollView : CELinearScrollView!
    
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
    
    var postButton: UIButton!
    
    var imageList = [UIImage]()
    
    var postIndicator: UIActivityIndicatorView!
    
    init(imgList: [UIImage]){
        super.init(nibName: nil, bundle: nil)
        
        self.imageList = imgList
        
        print("There are \(imgList.count) image from previous page.")
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
        
        let backButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
        backButton.setImage(UIImage.init(named: "back_button_icon"), for: .normal)
        backButton.bk_(whenTapped: {  [weak self] in
            if let weakSelf = self{
                _ = weakSelf.navigationController?.popViewController(animated: true)
            }
        })
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
        
        // title
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 30))
        titleLabel.text = "ITEM DETAILS"
        titleLabel.font = UIFont.init(name: "SFUIText-Semibold", size: 16)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
        
    }
    
    func updateData(){
        let service = CEMerchandiseService()
        service.getCategories { [weak self] (list) in
            var dict = Dictionary<String, Int>()
            for item in list{
                dict[item.name] = item.id
            }
            if let weakSelf = self{
                weakSelf.categoryRow.updateOptions(options: dict)
            }
        }
        
        let conditionDict = ["used" : 0 , "brand new" : 1]
        self.conditionRow.updateOptions(options: conditionDict)
        self.conditionRow.updateHeader(title: "Condition", msg: "Select product condition")
        
        let timeDict = ["3 Days" : 3 , "A week" : 7, "A month" : 30]
        self.expirationRow.updateOptions(options: timeDict)
        self.expirationRow.updateHeader(title: "Post Duration", msg: "Set expire date for your post")
    }
    
    
    func setupUI(){
        
        self.edgesForExtendedLayout = UIRectEdge()
        
        let padding = CGFloat(8)
        
        let section_width = GlobalValue.SCREENBOUND.width - 2 * padding
        
        self.mainScrollView = CELinearScrollView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: GlobalValue.SCREENBOUND.height - GlobalValue.STATUSBAR_HEIGHT - GlobalValue.NVBAR_HEIGHT))
        self.mainScrollView.bounces = false
        self.view.addSubview(self.mainScrollView)
        
        // what are you selling ?
        self.nameTextRow = CEAddTextRowView.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56), placeHolder: "What are you selling?")
        self.mainScrollView.linear_addSubview(self.nameTextRow, paddingTop: 20, paddingBottom: 0)
        
        // category
        self.categoryRow = CEAddOptionRowView.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56))
        self.mainScrollView.linear_addSubview(self.categoryRow, paddingTop: 13, paddingBottom: 0)
        
        // price
        self.priceTextRow = CEAddTextRowView.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56), placeHolder: "Price")
        self.mainScrollView.linear_addSubview(self.priceTextRow, paddingTop: 13, paddingBottom: 0)
        
        // negotiable
        self.negotiateRow = CEAddButtonRow.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56), text1: "Negotiable", text2: "Fixed Price")
        self.negotiateRow.setDefaultIndex(index: 0)
        self.mainScrollView.linear_addSubview(self.negotiateRow, paddingTop: 16, paddingBottom: 0)
        
        // condition
        self.conditionRow = CEAddOptionRowView.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56))
        self.mainScrollView.linear_addSubview(self.conditionRow, paddingTop: 13, paddingBottom: 0)
        
        // expiration 
        self.expirationRow = CEAddOptionRowView.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56))
        self.mainScrollView.linear_addSubview(self.expirationRow, paddingTop: 13, paddingBottom: 0)
        
        // description
        self.descriptionBox = CEAddParagraphRowView.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 168))
        self.mainScrollView.linear_addSubview(self.descriptionBox, paddingTop: 13, paddingBottom: 0)
        
        // contact
        self.contactRow = CEAddButtonRow.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56), text1: "Default Contact", text2: "New Contact")
        self.contactRow.block2 = { [weak self] () -> Void in
            if let weakSelf = self{
                weakSelf.newContactAction()
            }
        }
        self.contactRow.block1 = { [weak self] () -> Void in
            if let weakSelf = self{
                weakSelf.defaultContactAction()
            }
        }

        
        self.mainScrollView.linear_addSubview(self.contactRow, paddingTop: 16, paddingBottom: 20)
        
        // phone
        self.phoneTextRow = CEAddTextRowView.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56), placeHolder: "Phone")
//        self.mainScrollView.linear_addSubview(self.phoneTextRow, paddingTop: 0, paddingBottom: 16)
        
        // other information
        self.otherInfoTextRow = CEAddTextRowView.init(frame: CGRect.init(x: padding, y: 0, width: section_width, height: 56), placeHolder: "Other Info")
//        self.mainScrollView.linear_addSubview(self.otherInfoTextRow, paddingTop: 0, paddingBottom: 20)

        
        // post button
        self.postButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: 72))
        self.postButton.backgroundColor = UIColor.init(RGBWithRed: 83, green: 88, blue: 96, alpha: 1)
        self.postButton.setTitle("POST MY ITEM", for: .normal)
        self.postButton.titleLabel?.font = UIFont.init(name: "SFUIText-Regular", size: 20)
        self.postButton.setTitleColor(UIColor.white, for: .normal)
        self.postButton.addTarget(self, action: #selector(self.postAction), for: .touchUpInside)
        self.mainScrollView.linear_addSubview(postButton, paddingTop: 16, paddingBottom: 0)
        
        // Activity Indicator
        self.postIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.postIndicator.center = CGPoint.init(x: GlobalValue.SCREENBOUND.width / 2, y: GlobalValue.SCREENBOUND.height - GlobalValue.NVBAR_HEIGHT - GlobalValue.STATUSBAR_HEIGHT - CGFloat(36))
        self.view.addSubview(self.postIndicator)

        
        // 如果个人联系信息不全， 就不选default
        if CEAppCenter.sharedInstance().user!.phone == "" || CEAppCenter.sharedInstance().user!.email == ""{
            self.contactRow.button1.isUserInteractionEnabled = false
            self.contactRow.setDefaultIndex(index: 1)
            self.newContactAction()
        }
        else{
            self.contactRow.setDefaultIndex(index: 0)
        }
    }
    
    func newContactAction(){
        self.mainScrollView.linear_insertView(before: postButton, for: self.phoneTextRow, paddingTop: 0, paddingBottom: 16)
        self.mainScrollView.linear_insertView(before: postButton, for: self.otherInfoTextRow, paddingTop: 0, paddingBottom: 16)
    }
    
    func defaultContactAction(){
        self.mainScrollView.linear_removeView(self.phoneTextRow)
        self.mainScrollView.linear_removeView(self.otherInfoTextRow)
    }
    
    func postAction(){
        
        guard let productName = self.nameTextRow.getContent(), let categoryId = self.categoryRow.getSelectedValue(), let price = self.priceTextRow.getContent(),  let is_brandnew = self.conditionRow.getSelectedValue(), let expire = self.expirationRow.getSelectedValue() else{
            //TODO: Format Check Alert
            return
        }
        
        // Start post process, show process indicator in button view
        self.postButton.setTitle("", for: .normal)
        self.postButton.isEnabled = false
        self.postIndicator.startAnimating()
        let is_negotiable = self.negotiateRow.getSelectedId()
        // 1 default, 0 new address
        let contact_choice = self.contactRow.getSelectedId()
        let description = self.descriptionBox.getContent()
        
        var phone = ""
        var email = ""
        if contact_choice == 1{
            phone = CEAppCenter.sharedInstance().user!.phone
            email = CEAppCenter.sharedInstance().user!.email
        }
        else{
            if let phoneNum = self.phoneTextRow.getContent(), let otherInfo = self.otherInfoTextRow.getContent(){
                phone = phoneNum
                email = otherInfo
            }
            else{
                return
            }
        }
        
        
        
        
        let service = CEAddNewService()
        // 1. 先上传图片获取 图片的url
        
        var imgUrlList = [Dictionary<String, String>]()
        
        let groupQueue = DispatchGroup()
        
        var count = 1
        for image in self.imageList{
            groupQueue.enter()
            let queue = DispatchQueue.init(label: "queue\(self.imageList.index(of: image))")
            queue.async(group : groupQueue) {
                service.updateSimgleImage(image: image, finishBlk: { (flag, url) in
                    if flag != true{
                        print("Error occur in loading image.")
                        // TODO  上传图片出错
                    }
                    else if url != ""{
                        let dict = ["filename_\(count)" : url]
                        imgUrlList.append(dict)
                        count = count + 1
                    }
                    
                    groupQueue.leave()
                })
            }
            
        }
        
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
                            "userid" : CEAppCenter.sharedInstance().getUserId(),
                            "imagepath" : jsonStr,
                            "productname" : productName,
                            "productprice": price,
                            "productcategory" : categoryId,
                            "is_brandnew" : is_brandnew,
                            "is_negotiable" : is_negotiable,
                            "expireduration" : expire,
                            "description" : description,
                            "phone" : phone,
                            "contactinfo" : email
                        ]
                    ]
                    service.addNewPost(params: params as Dictionary<String, AnyObject>, finishBlk: { (flag) in
                        
                        // Stop Indicator, recover button status
                        self.postIndicator.stopAnimating()
                        self.postButton.setTitle("POST MY ITEM", for: .normal)
                        self.postButton.isEnabled = true
                        
                        // success
                        if flag == true{
                            let mainVC = CEMainPageVC()
                            SlideNavigationController.sharedInstance().popToRootAndSwitch(to: mainVC, withCompletion: nil)
                        }
                        // error
                        else{
                            
                            return
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
