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
    let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
        NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
    return documentsFolderPath
}

class ImageSaveVC: UIViewController, UIDocumentInteractionControllerDelegate {
    
    @IBOutlet weak var imageName: UITextField!
    var documentController:UIDocumentInteractionController!
    
    var delegate: ImageSaving?
    var defaultName: String?
    var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageName.text = defaultName?.stringByDeletingPathExtension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveImage(sender: UIButton) {
        image = delegate?.takeImage()
        let imageData = NSData(data: UIImagePNGRepresentation(image))
        
        if let newImageName = imageName.text {
            var newImagePath = documentsDirectory()
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
    
    @IBAction func sendToInstagram(sender: AnyObject)
    {
        postToInstagram()
    }
    
    
    
    func postToInstagram()
    {
        
        let instagramUrl = NSURL(string: "instagram://app")
        if(UIApplication.sharedApplication().canOpenURL(instagramUrl!)){
            
            //Instagram App avaible
            image = delegate?.takeImage()
            let imageData = UIImageJPEGRepresentation(image, 100)
            let captionString = "Your Caption"
            let writePath = NSTemporaryDirectory().stringByAppendingPathComponent("instagram.igo")
            
            if(!imageData.writeToFile(writePath, atomically: true)){
                //Fail to write. Don't post it
                return
            } else{
                //Safe to post
                
                let fileURL = NSURL(fileURLWithPath: writePath)
                self.documentController = UIDocumentInteractionController(URL: fileURL!)
                self.documentController.delegate = self
                self.documentController.UTI = "com.instagram.exclusivegram"
                self.documentController.annotation =  NSDictionary(object: captionString, forKey: "InstagramCaption")
                self.documentController.presentOpenInMenuFromRect(self.view.frame, inView: self.view, animated: true)
            }
        } else {
            //Instagram App NOT avaible...
        }
    }
    
    
    
    
    
    
    
    
    
}