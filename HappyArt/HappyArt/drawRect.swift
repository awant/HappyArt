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
        if tool.isDrawing == false
        {
            mainBezier.moveToPoint(tool.start)
        }
        else
        {
            mainBezier.addLineToPoint(tool.end)
        }
        mainBezier.stroke()
    }
    
    func setupGestures()
    {
        var pan = UIPanGestureRecognizer(target: self, action: Selector("pan:"))
        self.addGestureRecognizer(pan)
        var tap = UITapGestureRecognizer(target: self, action: Selector("tap:"))
        self.addGestureRecognizer(tap)
    }
    
    func startedDrawing(pointInView: CGPoint)
    {
        if bezierArray.count == cNumber
        {
            mainBezier.appendPath(bezierArray[0])
            bezierArray.removeAtIndex(0)
        }
        bezierArray.append(UIBezierPath())
        tool.start = pointInView
    }
    
    func drawing(pointInView: CGPoint)
    {
        
        tool.end = pointInView
        tool.isDrawing = true
        self.setNeedsDisplay()
    }
    
    func endedDrawing(pointInView: CGPoint)
    {
        
    }
    
    func tap(tapGesture: UITapGestureRecognizer)
    {
        println("tap")
        var pointInView = tapGesture.locationInView(self)
        startedDrawing(pointInView)
        self.setNeedsDisplay()
    }
    
    func pan(panGesture: UIPanGestureRecognizer)
    {
        var pointInView = panGesture.locationInView(self)
        if panGesture.state == UIGestureRecognizerState.Changed
        {
            tool.end = pointInView
            tool.isDrawing = true
            self.setNeedsDisplay()
        }
        else if panGesture.state == UIGestureRecognizerState.Began
        {
            if (isFirstCall || tool.isDrawing == false)
            {
                startedDrawing(pointInView)
                self.setNeedsDisplay()
            }
        }
        else if panGesture.state == UIGestureRecognizerState.Ended
        {
            //tool.end = pointInView
            println("ended")
            tool.isDrawing = false
        }
    }
    
}
