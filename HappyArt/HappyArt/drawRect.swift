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

class drawRect: UIView {
    let cNumber = 5
    
    var lastPoint: CGPoint!
    var mainBezier = UIBezierPath()
    var bezierArray: [UIBezierPath] = []
    var tool: Tool
    var isFirstCall: Bool
    
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
        UIColor.blackColor().setStroke()
        mainBezier.lineWidth = tool.size
        
        mainBezier.stroke()
        println("bezierArray.count = \(bezierArray.count)")
        for bezier in bezierArray
        {
            bezier.lineWidth = tool.size
            bezier.stroke()
        }
    }
    
    func setupGestures()
    {
        var pan = UIPanGestureRecognizer(target: self, action: Selector("pan:"))
        self.addGestureRecognizer(pan)
    }
    
    func startedDrawing(pointInView: CGPoint)
    {
        tool.start = pointInView
        if bezierArray.count == cNumber
        {
            mainBezier.appendPath(bezierArray[0])
            bezierArray.removeAtIndex(0)
        }
        bezierArray.append(UIBezierPath())
        bezierArray.last?.moveToPoint(tool.start)
        self.setNeedsDisplay()
    }
    
    func drawing(pointInView: CGPoint)
    {
        tool.end = pointInView
        tool.changeLastBezier(bezierArray.last!)
        tool.isDrawing = true
        self.setNeedsDisplay()
    }
    
    func endedDrawing(pointInView: CGPoint)
    {
        
    }
    
    func removeLast()
    {
        if bezierArray.count > 0
        {
            bezierArray.removeLast()
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        println("touchesBegan")
        var pointInView = (touches.first as! UITouch).locationInView(self)
        startedDrawing(pointInView)
    }
    
    func pan(panGesture: UIPanGestureRecognizer)
    {
        println("pan")
        var pointInView = panGesture.locationInView(self)
        if panGesture.state == UIGestureRecognizerState.Changed
        {
            println("Changed")
            drawing(pointInView)
        }
        else if panGesture.state == UIGestureRecognizerState.Began
        {
            println("Began")
            drawing(pointInView)
            if (isFirstCall || tool.isDrawing == false)
            {
                drawing(pointInView)
            }
        }
        else if panGesture.state == UIGestureRecognizerState.Ended
        {
            println("ended")
            tool.end = pointInView
            tool.isDrawing = false
        }
    }
    
}