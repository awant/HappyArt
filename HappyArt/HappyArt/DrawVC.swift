//
//  ViewController.swift
//  HappyArt
//
//  Created by Jenny on 30.04.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//

import UIKit

class DrawVC: UIViewController, ImageSaving, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var drawRect: DrawRect!
    @IBOutlet weak var sizeOfBrush: UISlider!
    
    @IBOutlet weak var drawView: UIView!
    var tools: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tools = ["Brush", "Line", "Rect", "Oval", "Rubber", "StrongSprayer", "SoftSprayer"]
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tools.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(tools[row])"
    }
    
    func  pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch(row) {
            case 0:
                drawRect.tool.mainTool = .Brush
            case 1:
                drawRect.tool.mainTool = .Line
            case 2:
                drawRect.tool.mainTool = .Rect
            case 3:
                drawRect.tool.mainTool = .Oval
            case 4:
                drawRect.tool.mainTool = .Rubber
            case 5:
                drawRect.tool.mainTool = .StrongSprayer
            case 6:
                drawRect.tool.mainTool = .SoftSprayer
            default:
                println("I hate your way to realize it")
        }
    }
}

