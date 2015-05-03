//
//  Tool.swift
//  HappyArt
//
//  Created by Admin on 02.05.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//

import UIKit

let multipleForBrush = CGFloat(30)
let minSizeForBrush = CGFloat(0.1)
let sizeOfStrongSprayer = CGFloat(0.2)
let sizeOfSoftSprayer = CGFloat(2)

enum MainTool
{
    case Brush
    case Line
    case Rect
    case Oval
    case Rubber
    case StrongSprayer
    case SoftSprayer
}

class Tool {
    
    var mainTool: MainTool
    var color: UIColor
    var size: CGFloat
    
    var start: CGPoint
    var end: CGPoint
    
    var isDrawing: Bool
    
    init()
    {
        color = UIColor.blackColor()
        start = CGPoint(x: 0, y: 0)
        end = CGPoint(x: 0, y: 0)
        mainTool = .Brush
        isDrawing = false
        size = defaultLineWidth
    }
    
    func changeLastBezier(pathCustom: CustomBezier)
    {
        var path = pathCustom.bezier
        switch mainTool {
        case .Brush:
            path.addLineToPoint(end)
        case .Line:
            path.removeAllPoints()
            path.moveToPoint(start)
            path.addLineToPoint(end)
        case .Rect:
            path.removeAllPoints()
            path.appendPath(UIBezierPath(rect: CGRect(origin: start, size: CGSize(width: end.x - start.x, height: end.y - start.y))))
        case .Oval:
            path.removeAllPoints()
            path.appendPath(UIBezierPath(ovalInRect: CGRect(origin: start, size: CGSize(width: end.x - start.x, height: end.y - start.y))))
        case .Rubber:
            pathCustom.color = UIColor.whiteColor()
            path.addLineToPoint(end)
        case .StrongSprayer:
            addStrongSprayer(path)
        case .SoftSprayer:
            addSoftSprayer(path)
        default:
            println("I hate swift because of 'default' things")
        }
    }
    
    func setPoint(pathCustom: CustomBezier)
    {
        var path = pathCustom.bezier
        if (abs(end.x - start.x) < size) || (abs(end.y - start.y) < size)
        {
            end = CGPoint(x: start.x, y: start.y+size)
        }
        path.addLineToPoint(end)
    }
    
    func addLine(path: UIBezierPath) -> UIBezierPath
    {
        path.moveToPoint(start)
        path.addLineToPoint(end)
        return path
    }
    
    func addStrongSprayer(path: UIBezierPath)
    {
        var r: CGFloat = CGFloat(arc4random())
        r = (r / CGFloat(UINT32_MAX))*size/2
        var phi: CGFloat = CGFloat(arc4random())
        phi = (phi / CGFloat(UINT32_MAX))*CGFloat(2*M_PI)
        
        path.moveToPoint(CGPoint(x: end.x+r*cos(phi), y: end.y+r*sin(phi)))
        path.addLineToPoint(CGPoint(x: end.x+r*cos(phi)+sizeOfStrongSprayer, y: end.y+r*sin(phi)+sizeOfStrongSprayer))
    }
    
    func addSoftSprayer(path: UIBezierPath)
    {
        path.lineWidth = sizeOfSoftSprayer
        var r: CGFloat = CGFloat(arc4random())
        r = (r / CGFloat(UINT32_MAX))*size*4
        var phi: CGFloat = CGFloat(arc4random())
        phi = (phi / CGFloat(UINT32_MAX))*CGFloat(2*M_PI)
        
        path.moveToPoint(CGPoint(x: end.x+r*cos(phi), y: end.y+r*sin(phi)))
        path.addLineToPoint(CGPoint(x: end.x+r*cos(phi)+sizeOfSoftSprayer, y: end.y+r*sin(phi)+sizeOfSoftSprayer))
    }
}








