//
//  ViewController.swift
//  HappyArt
//
//  Created by Jenny on 30.04.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//

import UIKit

class DrawVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func saveImage(sender: UIButton) {
        let imageSaveVC: ImageSaveVC = self.storyboard?.instantiateViewControllerWithIdentifier("imageSaveVC") as! ImageSaveVC
        self.navigationController?.pushViewController(imageSaveVC, animated: true)
    }

}

