//
//  ViewController.swift
//  HappyArt
//
//  Created by Jenny on 30.04.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//

import UIKit

protocol ColorChanging {
    func changeBackColor(color: UIColor)
    func changeToolColor(color: UIColor)
}

class DrawVC: UIViewController, ImageSaving, UIPickerViewDelegate, UIPickerViewDataSource, ColorChanging {

    @IBOutlet weak var drawRect: DrawRect!
    @IBOutlet weak var sizeOfBrush: UISlider!
    
    @IBOutlet weak var toolsView: UIView!
    @IBOutlet weak var drawView: UIView!
  
    @IBOutlet weak var colorView: ColorView!
    
    @IBOutlet weak var backColor: UIButton!
    @IBOutlet weak var toolColor: UIButton!
    var tools: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tools = ["Brush", "Line", "Rect", "Oval", "Rubber", "StrongSprayer", "SoftSprayer"]
        self.colorView.hidden = true
        self.colorView.delegate = self.drawRect
        self.drawRect.delegate = self
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

    @IBAction func setColorViewBackColor(sender: UIButton) {
        showColorView("setBackColor:")
    }
    
    @IBAction func hideColorView(sender: UIButton) {
         self.colorView.hidden = true
    }
   
    
    @IBAction func setColorViewToolColor(sender: UIButton) {
        showColorView("setToolColor:")
    }
    
    func showColorView(action: Selector) {
        self.colorView.hidden = false
        var buttonFrame = CGRect(x: 0, y: 0, width: 20, height: 20)
        var i:CGFloat = 1.0
        while i > 0{
            self.colorView.makeRainbowButtons(buttonFrame, sat: i ,bright: 1.0, action: action)
            i = i - 0.2
            buttonFrame.origin.y = buttonFrame.origin.y + buttonFrame.size.height
        }
    }
    
    func changeBackColor(color: UIColor) {
        self.backColor.backgroundColor = color
    }
    
    func changeToolColor(color: UIColor) {
        self.toolColor.backgroundColor = color
    }
    
}

