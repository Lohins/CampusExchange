//
//  CEPhotoMediaManager.swift
//  CampusExchange_iOS
//
//  Created by UBIELIFE on 2017-03-03.
//  Copyright © 2017 UBIELIFE Inc. All rights reserved.
//

import UIKit

protocol PhotoMediaDelegate {
    func receiveData(image: UIImage)
}

class CEPhotoMediaManager: NSObject {
    
    static let sharedInstance = CEPhotoMediaManager.init()
    
    var imagePickerController = UIImagePickerController.init()
    
    var delegate: PhotoMediaDelegate?
    
    var feedbackBlock: ((UIImage) -> Void)?
    
    override init(){
        super.init()
        self.imagePickerController.allowsEditing = true
        self.imagePickerController.delegate = self
    }
    
    func show(in nav: UINavigationController, finishBlock: ((UIImage) -> Void)?){
        
        self.feedbackBlock = finishBlock
        
        let blk = { [weak self]  (type: UIImagePickerControllerSourceType)-> Void in
            if let weakSelf = self{
                weakSelf.imagePickerController.sourceType = type
                nav.present(weakSelf.imagePickerController, animated: true, completion: nil)
            }
        }
        
        let alert = UIAlertController.init(title: "Change Photo", message: "Select image from", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction.init(title: "Photo Library", style: .default, handler: {(action) -> Void in
                blk(UIImagePickerControllerSourceType.photoLibrary)
            })
            alert.addAction(photoLibraryAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction.init(title: "Camera", style: .default, handler: {(action) -> Void in
                blk(UIImagePickerControllerSourceType.camera)
            })
            alert.addAction(cameraAction)
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        nav.present(alert, animated: true, completion: nil)
    }
}

extension CEPhotoMediaManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            if let blk = self.feedbackBlock{
                print(image.size)
                blk(image)
            }
        } else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if let blk = self.feedbackBlock{
                blk(image)
            }
        } else {
            
        }

        picker.dismiss(animated: true, completion: nil)

    }
}
