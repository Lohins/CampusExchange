//
//  CEContactVC.swift
//  CampusExchange_iOS
//
//  Created by S.t on 2017/3/2.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit
import iOS_Slide_Menu

class CEContactVC: UIViewController {
    
    var mainScrollView: CELinearScrollView!
    
    var avatarView: CEAvatarView!
    
    var nameTextInput: CEAddTextRowView!
    
    var phoneTextInput: CEAddTextRowView!
    
    var emailTextInput: CEAddTextRowView!
    
    var updateButton: UIButton!
    
    var updateIndicator: UIActivityIndicatorView!

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
        
        
        // left bar button
        let leftButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 25, height: 25))
        leftButton.setImage(UIImage.init(named: "mainpage_menu_icon"), for: .normal)
        leftButton.addTarget(SlideNavigationController.sharedInstance(), action: #selector(SlideNavigationController.sharedInstance().toggleLeftMenu), for: .touchUpInside)
        SlideNavigationController.sharedInstance().leftBarButtonItem = UIBarButtonItem.init(customView: leftButton)
        
        // title
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 30))
        titleLabel.text = "CONTACT INFORMATION"
        titleLabel.font = UIFont.init(name: "SFUIText-Semibold", size: 16)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
    }
    
    func setupUI(){
        self.edgesForExtendedLayout = UIRectEdge()
        
        let button_height = CGFloat(72)
        
        // main scroll view
        self.mainScrollView = CELinearScrollView.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width  , height: GlobalValue.SCREENBOUND.height - GlobalValue.NVBAR_HEIGHT - GlobalValue.STATUSBAR_HEIGHT - button_height))
        self.view.addSubview(self.mainScrollView)
        
        self.avatarView = CEAvatarView.init(frame: CGRect.init(x: 0, y: 0, width: 120, height: 120))
        self.avatarView.center = CGPoint.init(x: GlobalValue.SCREENBOUND.width / 2, y: GlobalValue.SCREENBOUND.height / 2)
        self.avatarView.top = 20
        self.avatarView.layer.cornerRadius = 60
        self.avatarView.layer.masksToBounds = true
        self.mainScrollView.linear_addSubview(self.avatarView, paddingTop: 20, paddingBottom: 0)
        
        // name input
        self.nameTextInput = CEAddTextRowView.init(frame: CGRect.init(x: 8, y: 0, width: GlobalValue.SCREENBOUND.width - 8 * 2, height: 56),placeHolder:"Display Name")
        self.nameTextInput.setContent(content: "Display Name")
        self.mainScrollView.linear_addSubview(self.nameTextInput, paddingTop: 30, paddingBottom: 0)

        
        // phone input
        self.phoneTextInput = CEAddTextRowView.init(frame: CGRect.init(x: 8, y: 0, width: GlobalValue.SCREENBOUND.width - 8 * 2, height: 56),placeHolder:"Phone Number")
        self.phoneTextInput.setContent(content: "Phone Number")
        self.mainScrollView.linear_addSubview(self.phoneTextInput, paddingTop: 13, paddingBottom: 0)
        
        
        // email input
        self.emailTextInput = CEAddTextRowView.init(frame: CGRect.init(x: 8, y: 0, width: GlobalValue.SCREENBOUND.width - 8 * 2, height: 56) , placeHolder : "Email Address")
        self.emailTextInput.setContent(content: "Email")
        self.mainScrollView.linear_addSubview(self.emailTextInput, paddingTop: 13, paddingBottom: 0)
        
        
        // update button
        self.updateButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: button_height))
        self.updateButton.bottom = GlobalValue.SCREENBOUND.height - GlobalValue.NVBAR_HEIGHT - GlobalValue.STATUSBAR_HEIGHT
        self.updateButton.backgroundColor = UIColor.init(RGBWithRed: 83, green: 88, blue: 96, alpha: 1)
        self.updateButton.setTitle("UPDATE CONTACT INFO", for: .normal)
        self.updateButton.titleLabel?.font = UIFont.init(name: "SFUIText-Regular", size: 20)
        self.updateButton.addTarget(self, action: #selector(self.updateAction), for: .touchUpInside)
        self.view.addSubview(self.updateButton)
        
        // update progress indicator
        self.updateIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.updateIndicator.center = CGPoint.init(x: GlobalValue.SCREENBOUND.width / 2, y: GlobalValue.SCREENBOUND.height - GlobalValue.NVBAR_HEIGHT - GlobalValue.STATUSBAR_HEIGHT - CGFloat(36))
        self.view.addSubview(self.updateIndicator)
        
    }
    
    func updateData(){
        let user = CEAppCenter.sharedInstance().getUser()
        self.nameTextInput.setContent(content: user.nickname)
        self.emailTextInput.setContent(content: user.email)
        self.phoneTextInput.setContent(content: user.phone)
        if let url = URL.init(string: user.photourl){
            self.avatarView.avatarImageView.setImageWith(url)
        }
    }
    
    func updateAction(){
        self.updateButton.setTitle("", for: .normal)
        self.updateIndicator.startAnimating()
        let flag = avatarView.getstatus()
        let nickname = nameTextInput.getContent_unnil()!
        let phone = phoneTextInput.getContent_unnil()!
        let email = emailTextInput.getContent_unnil()!
        let user = CEAppCenter.sharedInstance().getUser()
        let photourl = user.photourl
        
        // if selected new photo, upload, and update photourl
        if flag == true{
            let upload = CEAddNewService()
            let image = avatarView.getImage()
            upload.updateSimgleImage(image: image, finishBlk: { (result, url) in
                if flag != true{
                    print("Error occur in uploading image.")
                    // TODO  上传图片出错
                }
                else if url != ""{
                    self.postAction(nickname: nickname, phone: phone, email: email, photourl: url)
                }
            })
        }
        else{
            self.postAction(nickname: nickname, phone: phone, email: email, photourl: photourl)
        }


    }
    
    func postAction(nickname:String,phone:String,email:String,photourl:String){
        let service = CEUserInfoService()
        service.updateUserInfoWith(nickName: nickname, Phone: phone, Email: email, PhotoUrl: photourl){ (result) in
            if result == true{
                // update appcenter current user info
                CEAppCenter.sharedInstance().updateUserinfo(nickname: nickname, email: email, phone: phone, photourl: photourl)
                // re-init leftmenu avatar.
                CELeftMenuViewController.sharedInstance.resetUI()
                
            }else{
                // TODO: error MSG pop up
            }
            self.updateIndicator.stopAnimating()
            self.updateButton.setTitle("UPDATE CONTACT INFO", for: .normal)
            SlideNavigationController.sharedInstance().popToRootAndSwitch(to: CEMainPageVC(), withCompletion: nil)
        }

    }
    
}

extension CEContactVC : SlideNavigationControllerDelegate{
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool {
        return true
    }
}
