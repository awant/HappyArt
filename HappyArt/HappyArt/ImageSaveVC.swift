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
    func imageSaved(name: String)
}

func documentsDirectory() -> String {
    let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
    return documentsFolderPath
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
        if let newImageName = imageName.text {
            var newImagePath = documentsDirectory()//.stringByAppendingPathComponent("images")
            newImagePath = newImagePath.stringByAppendingPathComponent("\(newImageName).png")
            imageData.writeToFile(newImagePath, atomically: true)
            delegate?.imageSaved(newImagePath.lastPathComponent)
            println("\(newImagePath)")
        }
        self.navigationController?.popViewControllerAnimated(false)
    }
}