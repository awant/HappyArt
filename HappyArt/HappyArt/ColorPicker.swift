//
//  ColorPicker.swift
//  HappyArt
//
//  Created by Jenny on 03.05.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//

import UIKit

let numberOfRainbowColors: CGFloat = 12.0
let numberOfColors: CGFloat = 13.0
let numberOfSatLevels: CGFloat = 6.0
let setBackColorSelector: Selector = "setBackColor:"
let setToolColorSelector: Selector = "setToolColor:"

class ColorView: UIView {
    var delegate: ColorChanging?
    
    func makeRainbowButtons(buttonFrame:CGRect, sat:CGFloat, bright:CGFloat, action: Selector) {
        var myButtonFrame = buttonFrame
        for i in 0..<Int(numberOfRainbowColors) {
            let hue:CGFloat = CGFloat(i) / numberOfRainbowColors
            let color = UIColor(hue: hue, saturation: sat, brightness: bright, alpha: 1.0)
            let aButton = UIButton(frame: myButtonFrame)
            myButtonFrame.origin.x = myButtonFrame.size.width + myButtonFrame.origin.x
            aButton.backgroundColor = color
            self.addSubview(aButton)
            aButton.addTarget(self, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        }
        makeNeutralButton(myButtonFrame, sat: sat, action: action)
    }
    func makeNeutralButton(buttonFrame:CGRect, sat:CGFloat,  action: Selector) {
        var myButtonFrame = buttonFrame
        let color = UIColor(red: 1 - sat, green: 1 - sat, blue: 1 - sat, alpha: 1.0)
        let aButton = UIButton(frame: myButtonFrame)
        aButton.backgroundColor = color
        self.addSubview(aButton)
        aButton.addTarget(self, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setBackColor(sender:UIButton) {
        let color = sender.backgroundColor!
        delegate?.changeBackColor(color)
    }
    
    func setToolColor(sender:UIButton) {
        let color = sender.backgroundColor!
        delegate?.changeToolColor(color)
        self.hidden = true
    }
}