//
//  Tool.swift
//  HappyArt
//
//  Created by Admin on 02.05.15.
//  Copyright (c) 2015 com.mipt. All rights reserved.
//

import UIKit

enum MainTool
{
    case Brush
    case Line
}

let multipleForBrush = 10

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
        mainTool = .Line
        isDrawing = false
        size = 3
    }
    
    func changeLastBezier(path: UIBezierPath)
    {
        switch mainTool {
        case .Brush:
            path.addLineToPoint(end)
        case .Line:
            path.removeAllPoints()
            path.moveToPoint(start)
            path.addLineToPoint(end)
        default:
            println("I hate swift")
        }
    }
    
    func addLine(path: UIBezierPath) -> UIBezierPath
    {
        path.moveToPoint(start)
        path.addLineToPoint(end)
        return path
    }
}

