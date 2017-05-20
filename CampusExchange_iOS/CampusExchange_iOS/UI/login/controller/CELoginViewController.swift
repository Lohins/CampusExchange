//
//  CELoginViewController.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-02-24.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit
import iOS_Slide_Menu

class CELoginViewController: UIViewController {
    
    var introView: CETutorialView?
    
    // variables
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge()
        
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "intro_view") == nil{
            let frame = GlobalValue.SCREENBOUND
            let pics = [UIImage.init(named: "welcome_page1"), UIImage.init(named: "welcome_page2") , UIImage.init(named: "welcome_page3")]
            let blk = {[weak self]() -> Void in
                if let weakSelf = self{
                    if let view = weakSelf.introView{
                        UIView.animate(withDuration: 1.0, animations: { 
                            view.alpha = 0
                        }, completion: { (finished) in
                            view.removeFromSuperview()
                        })
                    }
                }
            }
            self.introView = CETutorialView.init(frame: frame, pictures: pics as! [UIImage], finishBlock: blk)
            self.view.addSubview(self.introView!)
        }

    }


    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        // TODO: Input fileds format check
        
        
        // TODO: Get studentid from campus API
        self.loginButton.setTitle("", for: .normal)
        self.loginIndicator.startAnimating()
        let service = CELoginService()
        let temp_studentid = "b0baee9d279d34fa1dfd71aadb908c3f"
    
        // Get user data from server
        service.loginToServerWith(studentID: temp_studentid){(status) in
            if status == true{
                let mpVC = CEMainPageVC()
                self.navigationController?.pushViewController(mpVC, animated: true)
            }
            self.loginIndicator.stopAnimating()
            self.loginButton.setTitle("LOGIN", for: .normal)
        }
        
        
        
    }
}


