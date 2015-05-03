//
//  Tool.swift
//  HappyArt
//
//  Created by Admin on 02.05.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//

import UIKit

let multipleForBrush = 10
let minForBrush = 0.1

enum MainTool
{
    case Brush
    case Line
    case Rect
    case Oval
    case Rubber
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
        mainTool = .Oval
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
        default:
            println("I hate swift because of 'default' things")
        }
    }
    
    func addLine(path: UIBezierPath) -> UIBezierPath
    {
        path.moveToPoint(start)
        path.addLineToPoint(end)
        return path
    }
}

