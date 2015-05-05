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
    func changeBackTransparentLevel(alpha: CGFloat)
    func changeToolTransparentLevel(alpha: CGFloat)
}

class DrawVC: UIViewController, ImageSaving, UIPickerViewDelegate, UIPickerViewDataSource, ColorChanging {
    
    @IBOutlet weak var drawRect: DrawRect!
    @IBOutlet weak var sizeOfBrush: UISlider!
    @IBOutlet weak var background: Background!
    @IBOutlet weak var toolsView: UIView!
    @IBOutlet weak var drawView: UIView!
    
    @IBOutlet weak var colorView: ColorView!
    
    @IBOutlet weak var hide: UIButton!
    @IBOutlet weak var backColor: UIButton!
    @IBOutlet weak var toolColor: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var tool: UIButton!
    
    @IBOutlet weak var currColor: UIButton!
    
    //var tools: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.colorView.hidden = true
        self.pickerView.hidden = true
        self.colorView.delegate = self.drawRect
        self.drawRect.delegate = self
        self.drawRect.backgroundDelegate = self.background
        self.tool.setTitle("Brush", forState: UIControlState.Normal)
        currColor.layer.borderWidth = 1
        currColor.layer.borderColor = UIColor.blackColor().CGColor
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
        self.drawRect.flushToBackground()
        UIGraphicsBeginImageContext(self.background.bounds.size)
        self.background.layer.renderInContext(UIGraphicsGetCurrentContext())
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
        return tools[row]
    }
    
    func  pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        drawRect.tool.mainTool = tools[row]
        self.tool.setTitle(tools[row], forState: UIControlState.Normal)
        self.pickerView.hidden = true
    }
    
    @IBAction func setColorViewBackColor(sender: UIButton) {
        //self.hide.hidden = false
        self.currColor.backgroundColor = self.background.backgroundColor
        showColorView(setBackColorSelector)
    }
    
    @IBAction func hideColorView(sender: UIButton) {
        for view in colorView.subviews {
            if ((view as? UIButton != currColor) && (view as? UIButton != hide)) {
                view.removeFromSuperview()
            }
        }
        self.colorView.hidden = true
    }
    
    
    @IBAction func setColorViewToolColor(sender: UIButton) {
        //self.hide.hidden = true
        self.currColor.backgroundColor = self.drawRect.tool.color
        showColorView(setToolColorSelector)
    }
    
    func showColorView(action: Selector) {
        self.colorView.hidden = false
        var buttonFrame = CGRect(x: 0, y: 0, width: setColorButtonWidth(action), height: setColorButtonHeight(action))
        var i: CGFloat = 1.0
        var k: CGFloat = i/numberOfSatLevels
        while i >= 0 {
            self.colorView.makeRainbowButtons(buttonFrame, sat: i, bright: 1.0, action: action)
            i -= k
            buttonFrame.origin.y = buttonFrame.origin.y + buttonFrame.size.height
        }
        buttonFrame = CGRect(x: self.currColor.frame.origin.x - 55, y: self.currColor.frame.origin.y + 23, width: 20, height: 20)
        self.colorView.makeTransparentStepper(buttonFrame, action: action)
    }
    
    func changeBackColor(color: UIColor) {
        self.backColor.backgroundColor = color
        self.currColor.backgroundColor = color
    }
    
    func changeToolColor(color: UIColor) {
        self.toolColor.backgroundColor = color
        self.currColor.backgroundColor = color
    }
    
    @IBAction func cancelAll(sender: UIButton) {
        self.drawRect.removeAll()
        self.drawRect.changeBackColor(UIColor.whiteColor())
        self.drawRect.changeToolColor(UIColor.blackColor())
    }
    
    @IBAction func changeTool(sender: UIButton) {
        self.pickerView.hidden = false
    }
    
    
    func setColorButtonWidth(action: Selector) -> CGFloat {
        return (self.colorView.frame.width - (self.hide.frame.width + 75))/numberOfColors
    }
    
    func setColorButtonHeight(action: Selector) -> CGFloat {
        return self.colorView.frame.height/(numberOfSatLevels + 1)
    }
    
    func changeBackTransparentLevel(alpha: CGFloat) {
        let color = self.currColor.backgroundColor?.colorWithAlphaComponent(alpha)
        self.background.backgroundColor = color
        self.currColor.backgroundColor = color
        self.backColor.backgroundColor = color
    }
    
    func changeToolTransparentLevel(alpha: CGFloat) {
        let color = self.currColor.backgroundColor?.colorWithAlphaComponent(alpha)
        self.currColor.backgroundColor = color
        self.toolColor.backgroundColor = color
    }
}











