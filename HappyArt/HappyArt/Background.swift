//
//  Background.swift
//  HappyArt
//
//  Created by Admin on 04.05.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//

import UIKit

protocol BackgroundProtocol {
    func changeBackColor(color: UIColor)
    func drawBezierBuffer(bezierBuffer: [CustomBezier])
    func removeAll()
}

class Background: UIView, BackgroundProtocol, ImageOpening {
    
    var bezierBuffer: [CustomBezier] = []
    var isFirstCall: Bool
    
    required init(coder aDecoder: NSCoder)
    {
        isFirstCall = true
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect)
    {
        if (isFirstCall)
        {
            isFirstCall = false
            return
        }
        for bezier in bezierBuffer
        {
            bezier.color.setStroke()
            bezier.bezier.stroke()
        }
    }
    
    func drawBezierBuffer(bezierBuffer: [CustomBezier])
    {
        self.bezierBuffer += bezierBuffer
        self.setNeedsDisplay()
    }
    
    func changeBackColor(color: UIColor)
    {
        self.backgroundColor = color
    }
    
    func removeAll()
    {
        bezierBuffer.removeAll()
        self.changeBackColor(UIColor.whiteColor())
        self.setNeedsDisplay()
    }
    
    func openImage(image: UIImage, name: String) {
        self.backgroundColor = UIColor(patternImage: image)
    }
    
}



