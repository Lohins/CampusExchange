//
//  CELeftMenuViewController.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-02-24.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit
import iOS_Slide_Menu

class CELeftMenuViewController: UIViewController {
    
    static let sharedInstance = CELeftMenuViewController()
    
    // variables
    
    var logoImageView: UIImageView!
    
    var avatarImageView : UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(){
        self.view.backgroundColor = UIColor.init(RGBWithRed: 211, green: 17, blue: 69, alpha: 1)
        
        let rate = CGFloat( 0.7 )
        let section_width = GlobalValue.SCREENBOUND.width * rate
        
        let mainView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: section_width, height: GlobalValue.SCREENBOUND.height))
        self.view.addSubview(mainView)
        
        // back ground image view
        let bgImageView = UIImageView.init(frame: mainView.frame)
        bgImageView.image = UIImage.init(named: "leftmenu_bgpic")
        bgImageView.contentMode = .scaleAspectFill
        mainView.addSubview(bgImageView)
        
        // logo image view
        logoImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 88, height: 72))
        logoImageView.image = UIImage.init(named: "login_logo")
        logoImageView.center = CGPoint.init(x: section_width / 2, y: 10)
        logoImageView.top = CGFloat(45)
        mainView.addSubview(logoImageView)
        
        // CAMPUS EXCHANGE text label
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: section_width, height: 24))
        titleLabel.text = "CAMPUS EXCHANGE"
        titleLabel.font = UIFont.init(name: "CollegeBold", size: 24)
        titleLabel.top = logoImageView.bottom + 6
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        mainView.addSubview(titleLabel)
        
        // user avatar
        avatarImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 120, height: 120))
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.width / 2
        avatarImageView.center = CGPoint.init(x: section_width / 2, y: 10)
        avatarImageView.top = titleLabel.bottom + 21
        let userphoto = CEAppCenter.sharedInstance().getUserPhoto()
        if let url = URL.init(string: userphoto){
            avatarImageView.setImageWith(url)
        }

        mainView.addSubview(avatarImageView)
        
        // Right reserved
        let botLabel1 = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: section_width, height: 12))
        botLabel1.textColor = UIColor.white
        botLabel1.textAlignment = .center
        botLabel1.text = "Copyright © 2017"
        botLabel1.font = UIFont.init(name: "SFUIText-Regular", size: 10)
        botLabel1.center = CGPoint.init(x: section_width / 2, y: 10)
        
        let botLabel2 = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: section_width, height: 12))
        botLabel2.textColor = UIColor.white
        botLabel2.textAlignment = .center
        botLabel2.text = "Fountain Valley School Of Colorado"
        botLabel2.font = UIFont.init(name: "SFUIText-Regular", size: 10)
        botLabel2.center = CGPoint.init(x: section_width / 2, y: 10)
        botLabel2.bottom = GlobalValue.SCREENBOUND.height - 30
        botLabel1.bottom = botLabel2.top
        
        mainView.addSubview(botLabel1)
        mainView.addSubview(botLabel2)
        
        // linear scroll view
        let tmp_height = GlobalValue.SCREENBOUND.height - avatarImageView.bottom - 20 - botLabel1.top  - 10
        let optionView = CELinearScrollView.init(frame: CGRect.init(x: 0, y: 0, width: section_width, height: tmp_height))
        optionView.top = avatarImageView.bottom + 20
        optionView.backgroundColor = UIColor.clear
        
        mainView.addSubview(optionView)
        
        // home page
        let homeAction = {()-> Void in
            
            let vc = CEMainPageVC()
            SlideNavigationController.sharedInstance().popToRootAndSwitch(to: vc, withCompletion: nil)
        }
        let HomePageOption = CELeftMenuOptionView.init(frame: CGRect.init(x: 0, y: 0, width: section_width, height: 40), text: "Homepage", action: homeAction)
        
        // book marks
        let bookmarkAction = {()-> Void in
            
            let vc = CEBookMarkVC()
            SlideNavigationController.sharedInstance().popToRootAndSwitch(to: vc, withCompletion: nil)
        }
        let BookmarkOption = CELeftMenuOptionView.init(frame: CGRect.init(x: 0, y: 0, width: section_width, height: 40), text: "Bookmarks", action: bookmarkAction)
        
        // contact info
        let contactAction = {()-> Void in

            let vc = CEContactVC()
            SlideNavigationController.sharedInstance().popToRootAndSwitch(to: vc, withCompletion: nil)
        }
        let ContactOption = CELeftMenuOptionView.init(frame: CGRect.init(x: 0, y: 0, width: section_width, height: 40), text: "Contact Information", action: contactAction)
        
        
        // log out
        let logoutActio = {
            CEAppCenter.sharedInstance().logout()
            let loginVC = CELoginViewController()
            SlideNavigationController.sharedInstance().popToRootAndSwitch(to: loginVC, withCompletion: nil)
        }
        let LogOutOption = CELeftMenuOptionView.init(frame: CGRect.init(x: 0, y: 0, width: section_width, height: 40), text: "Logout", action: logoutActio)
        
        let line1 = UIView.init(frame: CGRect.init(x: 9, y: 0, width: section_width - 18, height: 1))
        line1.backgroundColor = UIColor.white
        
        let line2 = UIView.init(frame: CGRect.init(x: 9, y: 0, width: section_width - 18, height: 1))
        line2.backgroundColor = UIColor.white
        
        let line3 = UIView.init(frame: CGRect.init(x: 9, y: 0, width: section_width - 18, height: 1))
        line3.backgroundColor = UIColor.white
        
        optionView.linear_addSubview(HomePageOption, paddingTop: 0, paddingBottom: 0)
        optionView.linear_addSubview(line1, paddingTop: 0, paddingBottom: 0)
        optionView.linear_addSubview(BookmarkOption, paddingTop: 0, paddingBottom: 0)
        optionView.linear_addSubview(line2, paddingTop: 0, paddingBottom: 0)
        optionView.linear_addSubview(ContactOption, paddingTop: 0, paddingBottom: 0)
        optionView.linear_addSubview(line3, paddingTop: 0, paddingBottom: 0)
        optionView.linear_addSubview(LogOutOption, paddingTop: 0, paddingBottom: 0)


    }
    
    func resetUI(){
        self.cleanUI()
        self.setupUI()
    }
    
    func cleanUI(){
        let views = self.view.subviews
        for view in views{
            view.removeFromSuperview()
        }
    }


}
