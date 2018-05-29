//
//  FGTwoOptionBezierPopup.swift
//  FGBezierPopup
//
//  Created by Filippo Giove on 29/05/18.
//  Copyright © 2018 Filippo Giove. All rights reserved.
//

import UIKit
import Foundation




class FGTwoOptionsButton: UIButton {

    fileprivate var type: PopUpButtonType
    var radius : CGFloat!
    /// MARK: - Initialization
    required init(type: PopUpButtonType, radius : CGFloat) {
        let frame = UIScreen.main.bounds
        self.type = type
        self.radius = radius
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
    }
    
    
    required init(coder aDecoder: NSCoder) {
        self.type = PopUpButtonType.left
        super.init(coder: aDecoder)!
    }
    
    
    /***************** DRAW METHODS ***********************/
    override func draw(_ rect: CGRect) {
        //NSLog("DRAW RECT")
        switch type {
        case .left:
            drawButtonLeftPopUpView(rect)
        case .right:
            drawButtonRightPopUpView(rect)
        }
    }
    /***************************** LEFT BUTTON CONDIVIDI **************************/
    func drawButtonLeftPopUpView(_ rect: CGRect) {
        //il background "esterno" a quello disegnato deve essere clear
        UIColor.clear.setStroke()
        //Disegno forma popup
        let bezierPath = getBazierPathLeftButton()
        //Coloro interno view
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        FGTWOOPTIONS_LEFT_BUTTON_COLOR.setFill()
        bezierPath.fill()
        context?.restoreGState()
        
    }
    
    fileprivate func getBazierPathLeftButton() -> UIBezierPath {
        
        let verticalLineHeight = self.frame.size.height - (2 * radius)
        let startPoint =  CGPoint(x: self.frame.size.width, y: 0)
        let path = UIBezierPath()
        
        path.home()
        path.lineWidth = 0
        path.lineCapStyle = CGLineCap.round
        path.move(to: startPoint)
        let secondPoint = CGPoint(x: self.frame.size.width, y: self.frame.size.height)
        path.addLine(to: secondPoint)
        let thirdPoint = CGPoint(x: radius, y: self.frame.size.height)
        path.bearing = 270
        path.addLine(to: thirdPoint)
        path.rightArc(radius, turn: 90)
        path.forward(verticalLineHeight)
        path.rightArc(radius, turn: 90)
        path.addLine(to: startPoint)
        return path
    }
    /***************************** RIGHT BUTTON CONDIVIDI **************************/
    func drawButtonRightPopUpView(_ rect: CGRect) {
        //il background "esterno" a quello disegnato deve essere clear
        UIColor.clear.setStroke()
        //Disegno forma popup
        let bezierPath = getBazierPathRightButton()
        //Coloro interno view
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        FGTWOOPTIONS_RIGHT_BUTTON_COLOR.setFill()
        bezierPath.fill()
        context?.restoreGState()
    }
    
    fileprivate func getBazierPathRightButton() -> UIBezierPath {
        
        let verticalLineHeight = self.frame.size.height - (2 * radius)
        let path = UIBezierPath()
        
        path.home()
        path.lineWidth = 0
        path.lineCapStyle = CGLineCap.round
        path.bearing = 90
        let secondPoint = CGPoint(x: (self.frame.size.width - radius), y: 0)
        path.addLine(to: secondPoint)
        path.rightArc(radius, turn: 90)
        
        path.bearing = 180
        path.forward(verticalLineHeight)
        path.rightArc(radius, turn: 90)
        
        let thirdPoint = CGPoint(x: 0, y: self.frame.size.height)
        path.addLine(to: thirdPoint)
        let startPoint = CGPoint(x: 0, y: 0)
        path.addLine(to: startPoint)
        
        return path
    }
}
