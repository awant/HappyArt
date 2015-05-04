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

class Background: UIView, BackgroundProtocol {
    
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
        println("background \(self.bezierBuffer.count)")
        self.setNeedsDisplay()
    }
    
    func changeBackColor(color: UIColor)
    {
        self.backgroundColor = color
    }
    
    func removeAll()
    {
        bezierBuffer.removeAll()
        self.setNeedsDisplay()
    }
    
    
}



