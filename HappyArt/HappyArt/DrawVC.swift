//
//  ViewController.swift
//  HappyArt
//
//  Created by Jenny on 30.04.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//

import UIKit

class DrawVC: UIViewController, ImageSaving {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var drawView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func saveImage(sender: UIButton) {
        let imageSaveVC: ImageSaveVC = self.storyboard?.instantiateViewControllerWithIdentifier("imageSaveVC") as! ImageSaveVC
        imageSaveVC.delegate = self // set
        self.navigationController?.pushViewController(imageSaveVC, animated: true)
    }
    
    func takeImage() -> UIImage {
        UIGraphicsBeginImageContext(self.drawView.frame.size)
        self.drawView.drawRect(self.drawView.frame)
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }

}

