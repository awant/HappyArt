//
//  ImageOpenVC.swift
//  HappyArt
//
//  Created by Jenny on 30.04.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePath: String?
    var delegate: ImageDeleting?
    
    func deleteImage() {
        delegate?.deleteImage(imagePath!)
    }
}

protocol ImageOpening {
    func openImage(image: UIImage, name: String)
}

protocol ImageDeleting {
    func deleteImage(path: String)
}

struct OpenedImage {
    var openedImageExists = false
    var image: UIImage?
    var name: String?
}

class ImageOpenVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ImageDeleting {
    
    var imageSet = ImageSet()
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var isEmpty: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateImageCollection()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageSet.images.image.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
        cell.imageView.image = self.imageSet.images.image[indexPath.row]
        cell.imagePath = self.imageSet.images.path[indexPath.row]
        cell.delegate = self
        
        let longPressRec = UILongPressGestureRecognizer()
        longPressRec.addTarget(cell, action: "deleteImage")
        cell.imageView.addGestureRecognizer(longPressRec)
        cell.imageView.userInteractionEnabled = true
        
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
    
    func updateImageCollection() -> Void {
        self.imageSet.setImages()
        if (self.imageSet.images.image.count == 0) {
            self.collectionView.hidden = true
            self.isEmpty.hidden = false
        }
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        imageSet.clear()
    }
    
    func deleteImage(path: String) {
        let tapAlert = UIAlertController(title: "Delete \(path.lastPathComponent)?", message: "You won't be able to cancel this action!", preferredStyle: UIAlertControllerStyle.Alert)
        tapAlert.addAction(UIAlertAction(title: "YES", style: .Destructive, handler: { action in
            let fileManager = NSFileManager.defaultManager()
            fileManager.removeItemAtPath(path, error: nil)
            
            self.imageSet.clear()
            self.updateImageCollection()
        }))
        tapAlert.addAction(UIAlertAction(title: "NO", style: .Destructive, handler: nil))
        self.presentViewController(tapAlert, animated: true, completion: nil)
       
    }
    

}
