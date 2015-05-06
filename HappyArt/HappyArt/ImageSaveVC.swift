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
    var defaultName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageName.text = defaultName?.stringByDeletingPathExtension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveImage(sender: UIButton) {
        let imageData = NSData(data: UIImagePNGRepresentation(delegate?.takeImage()))
       
        if let newImageName = imageName.text {
            var newImagePath = documentsDirectory()//.stringByAppendingPathComponent("images")
            newImagePath = newImagePath.stringByAppendingPathComponent("\(newImageName).png")
            if (imageData.writeToFile(newImagePath, atomically: true) == true) {
                delegate?.imageSaved(newImagePath.lastPathComponent)
                println("\(newImagePath)")
            }
            else {
                let tapAlert = UIAlertController(title: "Error", message: "Can't save image in \(newImagePath)", preferredStyle: UIAlertControllerStyle.Alert)
                tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
                self.presentViewController(tapAlert, animated: true, completion: nil)
            }
        }
        self.navigationController?.popViewControllerAnimated(false)
    }
}


/*
let fileManager = NSFileManager.defaultManager()
var newImagePath = documentsDirectory()//.stringByAppendingPathComponent("images")
fileManager.removeItemAtPath(newImagePath.stringByAppendingPathComponent("\(imageName.text).png"), error: nil) */