//
//  FGBezierPath.swift
//  FGBezierPopup
//
//  Created by Filippo Giove on 29/05/18.
//  Copyright © 2018 Filippo Giove. All rights reserved.
//

import UIKit
import ObjectiveC

private var bearingAssociatedKey: UInt8 = 0

extension UIBezierPath {
    
    ///0   -> North
    // 90  -> East
    // 270 -> West
    // 180 ->South
    
    var toNorth : CGFloat{
        get{
            return 0;
        }
    }
    var toEast : CGFloat{
        get{
            return 90;
        }
    }
    var toWest : CGFloat{
        get{
            return 270;
        }
    }
    var toSouth : CGFloat{
        get{
            return 180;
        }
    }
    
    var bearing: CGFloat {
        get { return objc_getAssociatedObject(self, &bearingAssociatedKey) as! CGFloat }
        set { objc_setAssociatedObject(self, &bearingAssociatedKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    func home() {
        move(to: CGPoint.zero)
        bearing = 0
    }
    
    func forward(_ distance: CGFloat) {
        addLine(to: toCartesian(distance, bearing: bearing, origin: currentPoint))
    }
    
    func leftArc(_ radius: CGFloat, turn: CGFloat) {
        arc(radius, angle: turn, clockwise: false)
    }
    
    func rightArc(_ radius: CGFloat, turn: CGFloat) {
        arc(radius, angle: turn, clockwise: true)
    }
    
    /// MARK: - Maths
    
    fileprivate func arc(_ radius: CGFloat, angle: CGFloat, clockwise: Bool) {
        var angle = angle
        let radiusTurn: CGFloat = clockwise ? 90 : -90
        let cgAngleBias: CGFloat = clockwise ? 180 : 0
        angle = clockwise ? angle : -angle
        
        let center = toCartesian(radius, bearing: bearing + radiusTurn, origin: currentPoint)
        
        let cgStartAngle = cgAngleBias + bearing
        let cgEndAngle = cgAngleBias + (bearing + angle)
        
        bearing += angle
        
        addArc(withCenter: center, radius: radius, startAngle: radians(cgStartAngle), endAngle: radians(cgEndAngle), clockwise: clockwise)
    }
    
    fileprivate func radians(_ degrees: CGFloat) -> CGFloat {
        return degrees * CGFloat(Double.pi) / 180
    }
    
    fileprivate func toCartesian(_ radius: CGFloat, bearing: CGFloat, origin: CGPoint) -> CGPoint {
        let bearingInRadians = radians(bearing)
        let vector = CGPoint(x: radius * CGFloat(sinf(Float(bearingInRadians))), y: -radius * CGFloat(cosf(Float(bearingInRadians))))
        return CGPoint(x: origin.x + vector.x, y: origin.y + vector.y)
    }
}

