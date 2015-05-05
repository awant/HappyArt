//
//  ImageOpenVC.swift
//  HappyArt
//
//  Created by Jenny on 30.04.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}

protocol ImageOpening {
    func openImage(image: UIImage, name: String)
}

struct OpenedImage {
    var openedImageExists = false
    var image: UIImage?
    var name: String?
}

class ImageOpenVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var imageSet = ImageSet()
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageSet.setImages()
        println(imageSet.images.image.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageSet.images.image.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
        cell.imageView.image = self.imageSet.images.image[indexPath.row]
        cell.backgroundColor = UIColor.blackColor()
        return cell
    }
    
   func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let mainVC: DrawVC = self.storyboard?.instantiateViewControllerWithIdentifier("mainVC") as! DrawVC
        mainVC.openedImage.openedImageExists = true
        mainVC.openedImage.image = self.imageSet.images.image[indexPath.row]
        mainVC.openedImage.name = self.imageSet.images.path[indexPath.row].lastPathComponent
       // println(self.imageSet.images.image[indexPath.row].description)
        self.navigationController?.pushViewController(mainVC, animated: true)
    }

}
