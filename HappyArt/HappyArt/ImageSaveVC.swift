//
//  ImageSaveVC.swift
//  HappyArt
//
//  Created by Jenny on 01.05.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//

import UIKit

protocol ImageSaving {
    func takeImage() -> UIImage
    func imageSaved(imageName: NSString)
}

class ImageSaveVC: UIViewController {
    
    @IBOutlet weak var imageName: UITextField!
    var delegate: ImageSaving?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveImage(sender: UIButton) {
        let imageData = NSData(data: UIImagePNGRepresentation(delegate?.takeImage()))
        if var newImageName = imageName.text {
            newImageName = newImageName.stringByAppendingString(".png")
            imageData.writeToFile(newImageName, atomically: true)
            delegate?.imageSaved(newImageName)
        }
        self.navigationController?.popViewControllerAnimated(false)
    }
}