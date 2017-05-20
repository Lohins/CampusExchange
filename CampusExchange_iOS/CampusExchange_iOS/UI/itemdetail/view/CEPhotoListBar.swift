//
//  CEPhotoListBar.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-03-03.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

protocol CellDelegate {
    func getImageFromSystem() -> UIImage?
    
    func updateDataAt(Index: Int, image: UIImage) -> Void
}

class CEPhotoListBar: UIView, CellDelegate {
    
    var dataList: [Any?] = [nil,nil,nil,nil,nil]
    
    var existImageUrl = [String]()
    
    var subViews = [PhotoCell]()
    // 每个cell 的宽
    let cell_width = CGFloat(60)
    
    // 左右边的间隔
    let gap = CGFloat(8)
    
    // cell 之间的 间距
    let margin = CGFloat(10)

    var scrollView: UIScrollView!
    
    let imagePickerController = UIImagePickerController.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
    }
    
    convenience init(images: [String]){

        
        let frame = CGRect.init(x: 0, y: 0, width: GlobalValue.SCREENBOUND.width, height: 60)
        self.init(frame: frame)
        
        
        for url in images{
            let index = images.index(of: url)
            dataList[index!] = url
        }
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI(){

        self.scrollView = UIScrollView.init(frame: self.frame)
        self.addSubview(self.scrollView)
        
        let content_width = gap * 2 + cell_width * 5 + margin * 4
        let suitable_width = content_width > GlobalValue.SCREENBOUND.width ? content_width :  GlobalValue.SCREENBOUND.width
        self.scrollView.contentSize = CGSize.init(width: suitable_width, height: cell_width)
        
        var offset_x = CGFloat(8)
        for i in 0...4{
            let view = PhotoCell.init(frame: CGRect.init(x: offset_x, y: 0, width: cell_width, height: cell_width))
            view.id = i
            
            self.scrollView.addSubview(view)
            offset_x = offset_x + cell_width + margin
            
            view.delegate = self
            self.subViews.append(view)
        }
        
        for i in 0..<self.dataList.count{
            let item = self.dataList[i]
            if let urlStr = item as? String{
                if let url = URL.init(string: urlStr){
                    let view = self.subViews[i] 
                    view.setImage(url: url)
                }
            }
        }
        
    }
    
    // 获取 已经选择好的图片
    
    func getImages() -> [UIImage]{
        var result = [UIImage]()
        for view in self.subViews{
            if let image = view.getImage(){
                result.append(image)
            }
        }
        return result
    }
    
    func getData() -> [Any?]{
        return self.dataList
    }
    
    func getImageFromSystem() -> UIImage? {
        return nil
    }
    
    func updateDataAt(Index: Int, image: UIImage) {
        self.dataList[Index] = image
    }
    
}


extension CEPhotoListBar{
    class PhotoCell: UIView {
        override init(frame: CGRect){
            super.init(frame: frame)
            
            self.setupUI()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        var id: Int!
        
        private var imageView: UIImageView!
        
        private var editImageView:UIImageView!
        
        private var button: UIButton!
        
        var delegate : CellDelegate?
        
        func setupUI(){
            
            self.imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: self.width))
            self.imageView.layer.borderColor = UIColor.init(RGBWithRed: 83, green: 88, blue: 96, alpha: 1).cgColor
            self.imageView.layer.cornerRadius = 12
            self.imageView.layer.borderWidth = 0.5
            self.imageView.contentMode = .scaleAspectFill
            self.imageView.clipsToBounds = true
            self.addSubview(self.imageView)
            
            self.editImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
            self.editImageView.center = CGPoint.init(x: self.width / 2, y: self.height / 2)
            self.editImageView.image = UIImage.init(named: "add_new_picture")
            self.editImageView.contentMode = .scaleAspectFit
            self.addSubview(self.editImageView)
            
            self.button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: self.width))
            self.button.addTarget(self, action: #selector(self.tapAction), for: .touchUpInside)
            self.addSubview(self.button)
        }
        
        func setImage(image: UIImage){
            self.imageView.image = image
            self.editImageView.frame =  CGRect.init(x: 0, y: 0, width: 24, height: 24)
            self.editImageView.center = CGPoint.init(x: self.width / 2, y: self.height / 2)
            self.editImageView.image = UIImage.init(named: "remove_new_picture")
            
            // update image to parent view
            if let delegate = self.delegate{
                delegate.updateDataAt(Index: self.id, image: image)
            }
        }
        
        func setImage(url: URL){
            self.imageView.setImageWith(url)
            self.editImageView.frame =  CGRect.init(x: 0, y: 0, width: 24, height: 24)
            self.editImageView.center = CGPoint.init(x: self.width / 2, y: self.height / 2)
            self.editImageView.image = UIImage.init(named: "remove_new_picture")

        }
        
        func removeImage(){
            
            let alertVC = UIAlertController.init(title: "Message", message: "Do you really want to remve the photo?", preferredStyle: .alert)
            let sureAction = UIAlertAction.init(title: "Sure", style: .default, handler: {(_) -> Void in
                self.imageView.image = nil
                self.editImageView.frame =  CGRect.init(x: 0, y: 0, width: 40, height: 40)
                self.editImageView.center = CGPoint.init(x: self.width / 2, y: self.height / 2)
                self.editImageView.image = UIImage.init(named: "add_new_picture")
            })
            
            let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
            alertVC.addAction(sureAction)
            alertVC.addAction(cancelAction)
            
            self.getCurrentViewController()?.navigationController?.present(alertVC, animated: true, completion: nil)
        }
        
        func addImage(){
            if let nav = self.getCurrentViewController()?.navigationController{
                CEPhotoMediaManager.sharedInstance.show(in: nav, finishBlock: { (image: UIImage) -> Void in
                    self.setImage(image: image)
                })
            }

        }
        
        func tapAction(){
            if let _ = self.imageView.image{
                self.removeImage()
            }
            else{
                self.addImage()
            }
        }
        
        // 获取 图片
        func getImage() -> UIImage?{
            return self.imageView.image
        }
        
        
    }
}
