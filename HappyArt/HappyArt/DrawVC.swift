//
//  ViewController.swift
//  HappyArt
//
//  Created by Jenny on 30.04.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//

import UIKit

class DrawVC: UIViewController, ImageSaving {

    @IBOutlet weak var drawRect: DrawRect!
    @IBOutlet weak var sizeOfBrush: UISlider!
    
    @IBOutlet weak var drawView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func saveImage(sender: UIButton) {
        let imageSaveVC: ImageSaveVC = self.storyboard?.instantiateViewControllerWithIdentifier("imageSaveVC") as! ImageSaveVC
         imageSaveVC.delegate = self
        self.navigationController?.pushViewController(imageSaveVC, animated: true)
    }
    
    func takeImage() -> UIImage {
      /*  UIGraphicsBeginImageContext(self.drawView.frame.size)
        self.drawView.drawRect(self.drawView.frame)
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()*/
        
        UIGraphicsBeginImageContext(self.drawView.bounds.size)
        self.drawView.layer.renderInContext(UIGraphicsGetCurrentContext())
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    @IBAction func cancelAction(sender: AnyObject)
    {
        drawRect.removeLast()
    }
    
    @IBAction func changedSizeOfBrush(sender: AnyObject)
    {
        drawRect.tool.size = multipleForBrush * CGFloat(sizeOfBrush.value) + minSizeForBrush
    }

    func imageSaved(imageName: NSString) {
        self.navigationItem.title = imageName as String
    }
}

