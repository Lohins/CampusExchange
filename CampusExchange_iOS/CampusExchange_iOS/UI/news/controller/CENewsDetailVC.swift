//
//  CENewsDetailVC.swift
//  CampusExchange_iOS
//
//  Created by Weibo Wang on 2017/3/21.
//  Copyright © 2017年 UBIELIFE Inc. All rights reserved.
//

import UIKit

class CENewsDetailVC: UIViewController {
    
    var news: CENewsItem!
    
    @IBOutlet weak var PicVIew: UIImageView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var PosttimeLabel: UILabel!
    
    @IBOutlet weak var ContentLabel: UITextView!
    
    @IBOutlet weak var AuthorLabel: UILabel!
    
    init(news: CENewsItem){
        super.init(nibName: nil, bundle: nil)
        self.news = news
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateData(){
        self.TitleLabel.text = news.title
        self.PosttimeLabel.text = news.createDate
        self.ContentLabel.text = news.content
        self.AuthorLabel.text = news.author
        if let url = URL.init(string: news.photoUrl){
            self.PicVIew.setImageWith(url)
        }
    }
    
    @IBAction func BackAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }

    
}
