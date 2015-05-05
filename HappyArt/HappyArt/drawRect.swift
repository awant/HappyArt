//
//  drawRect.swift
//  HappyArt
//
//  Created by Admin on 02.05.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//
//
//

let maxBeziersForCancel = 10
let maxBeziersInLayer = 20

import UIKit

class DrawRect: UIView, ColorChanging {
    
    var nBezier: Int
    
    var bezierBuffer: [CustomBezier] = []
    var tool: Tool
    var isFirstCall: Bool
    
    var delegate: ColorChanging?
    var backgroundDelegate: BackgroundProtocol!
    
    required init(coder aDecoder: NSCoder)
    {
        tool = Tool()
        isFirstCall = true
        nBezier = 0
        super.init(coder: aDecoder)
        setupGestures()
        self.backgroundColor = self.backgroundColor?.colorWithAlphaComponent(0.0)
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
            nBezier--;
            self.setNeedsDisplay()
        }
    }
    
    func removeAll()
    {
        bezierBuffer.removeAll()
        backgroundDelegate?.removeAll()
        nBezier = 0
        self.changeToolColor(UIColor.blackColor())
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
        bezierBuffer.last!.color = bezierBuffer.last!.color.colorWithAlphaComponent(tool.transparent)
        bezierBuffer.last?.bezier.moveToPoint(tool.start)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        tool.end = (touches.first as! UITouch).locationInView(self)
        tool.setPoint(bezierBuffer.last!)
        tool.isDrawing = false
        self.setNeedsDisplay()
        nBezier++
        if nBezier == maxBeziersInLayer
        {
            turnCurrentLayerIntoBackground()
            nBezier -= maxBeziersInLayer-maxBeziersForCancel
        }
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
            nBezier++
            if nBezier == maxBeziersInLayer
            {
                turnCurrentLayerIntoBackground()
                nBezier -= maxBeziersInLayer-maxBeziersForCancel
            }
        }
    }
    
    func drawing(pointInView: CGPoint)
    {
        tool.end = pointInView
        tool.changeLastBezier(bezierBuffer.last!)
        tool.isDrawing = true
        self.setNeedsDisplay()
    }
    
    func changeBackColor(color: UIColor)
    {
        backgroundDelegate?.changeBackColor(color)
        delegate?.changeBackColor(color)
    }
    
    func changeToolColor(color: UIColor)
    {
        tool.color = color
        delegate?.changeToolColor(color)
    }
    
    func changeBackTransparentLevel(alpha: CGFloat) {
        delegate?.changeBackTransparentLevel(alpha)
    }
    
    func changeToolTransparentLevel(alpha: CGFloat) {
        tool.transparent = alpha
        delegate?.changeToolTransparentLevel(alpha)
    }
    
    func turnCurrentLayerIntoBackground()
    {
        backgroundDelegate?.drawBezierBuffer(Array(bezierBuffer[0...maxBeziersInLayer-maxBeziersForCancel-1]))
        bezierBuffer.removeRange(0...maxBeziersInLayer-maxBeziersForCancel-1)
    }
    
    func flushToBackground()
    {
        nBezier = 0
        backgroundDelegate?.drawBezierBuffer(bezierBuffer)
        bezierBuffer.removeAll()
        self.changeToolColor(UIColor.blackColor())
        self.setNeedsDisplay()
    }
    
}










