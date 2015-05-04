//
//  drawRect.swift
//  HappyArt
//
//  Created by Admin on 02.05.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//
//
//

import UIKit

class DrawRect: UIView, ColorChanging {
    
    var bezierBuffer: [CustomBezier] = []
    var tool: Tool
    var isFirstCall: Bool
    
    var delegate: ColorChanging?
    
    required init(coder aDecoder: NSCoder)
    {
        tool = Tool()
        isFirstCall = true
        super.init(coder: aDecoder)
        setupGestures()
    }
    
    override func drawRect(rect: CGRect)
    {
        if (isFirstCall) {
            isFirstCall = false
            return
        }
        // Draw bezierBuffer
        for bezier in bezierBuffer
        {
            bezier.color.setStroke()
            bezier.bezier.stroke()
        }
    }
    
    func removeLast()
    {
        if bezierBuffer.count > 0
        {
            bezierBuffer.removeLast()
            self.setNeedsDisplay()
        }
    }
    
    func removeAll()
    {
        bezierBuffer.removeAll()
        self.setNeedsDisplay()
    }
    
    func setupGestures()
    {
        var pan = UIPanGestureRecognizer(target: self, action: Selector("pan:"))
        self.addGestureRecognizer(pan)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        tool.start = (touches.first as! UITouch).locationInView(self)
        bezierBuffer.append(CustomBezier())
        bezierBuffer.last?.bezier.lineWidth = tool.size
        bezierBuffer.last?.color = tool.color
        bezierBuffer.last?.bezier.moveToPoint(tool.start)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        tool.end = (touches.first as! UITouch).locationInView(self)
        tool.setPoint(bezierBuffer.last!)
        tool.isDrawing = false
        self.setNeedsDisplay()
    }
    
    func pan(panGesture: UIPanGestureRecognizer)
    {
        var pointInView = panGesture.locationInView(self)
        if panGesture.state == UIGestureRecognizerState.Changed
        {
            drawing(pointInView)
        }
        else if panGesture.state == UIGestureRecognizerState.Ended
        {
            tool.isDrawing = false
        }
    }
    
    func drawing(pointInView: CGPoint)
    {
        tool.end = pointInView
        tool.changeLastBezier(bezierBuffer.last!)
        tool.isDrawing = true
        self.setNeedsDisplay()
    }
    
    func changeBackColor(color: UIColor) {
        self.backgroundColor = color
        delegate?.changeBackColor(color)
    }
    
    func changeToolColor(color: UIColor) {
        tool.color = color
        delegate?.changeToolColor(color)
    }
}

