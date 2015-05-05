//
//  ImageSet.swift
//  HappyArt
//
//  Created by Jenny on 05.05.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//

import UIKit

struct Images {
    var image = [UIImage]()
    var path = [String]()
}

class ImageSet : NSObject {
   
    var images = Images()
    
    override init() {
        super.init()
    }
    
    func contentsOfDirectoryAtPath(path: String) -> [String]? {
        let fileManager = NSFileManager.defaultManager()
        let contents = fileManager.contentsOfDirectoryAtPath(path, error: nil)
        return contents as! [String]?
    }

    func setImages() -> Void {
        let directory = documentsDirectory()
        if let imageNames = contentsOfDirectoryAtPath(directory) {
            for i in 0..<imageNames.count {
                let path = directory.stringByAppendingPathComponent(imageNames[i])
                if let image = openImage(path) {
                    self.images.image.append(image)
                    self.images.path.append(path)
                }
            }
        }
    }

    func openImage(path: String) -> UIImage? {
        println(UIImage(contentsOfFile: path))
        println(path)
        return UIImage(contentsOfFile: path)
    }
}

//
//  ImageOpenVC.swift
//  HappyArt
//
//  Created by Jenny on 30.04.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//
/*
import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    let width = 200
}

class ImageOpenVC: UICollectionViewController,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    var imageSet = ImageSet()
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfItemsInSection() -> Int {
        return 1 //Int(self.imageCell.frame.width  / self.collectionView!.frame.width)
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1 //Int(imageSet.images.count / numberOfItemsInSection()) + 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /*  let maxNumberOfItems = numberOfItemsInSection()
        let numberOfItems = imageSet.images.count - (section + 1)*maxNumberOfItems
        if (numberOfItems > maxNumberOfItems) {
        return maxNumberOfItems
        }
        return numberOfItems */
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        println("\(imageSet.images.count)")
        self.imageView.image = self.imageSet.images[indexPath.row]
        // cell.imageView.image = imageSet.images[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
        cell.backgroundColor = UIColor.blackColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            /* if (indexPath.row > imageSet.images.count) {
            return CGSize(width: 100, height: 100)
            }
            var size = imageSet.images[indexPath.row].size
            size.width += 10
            size.height += 10
            return size*/
            return CGSize(width: 100, height: 100)
            
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            
            return UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    }
    
}
*/