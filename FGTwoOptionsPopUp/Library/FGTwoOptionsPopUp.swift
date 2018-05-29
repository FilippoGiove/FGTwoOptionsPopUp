//
//  FGTwoOptionBezierPopUp.swift
//  FGBezierPopup
//
//  Created by Filippo Giove on 29/05/18.
//  Copyright © 2018 Filippo Giove. All rights reserved.
//

import UIKit
import Foundation


class FGTwoOptionsPopUp: UIView {

    private var leftButton:FGTwoOptionsButton!
    private var rightButton:FGTwoOptionsButton!
    
    private var type: PopUpType!
    
    private var anchorView: UIView!
    
    
    
    /*************************************************************************************************************************************/
    //MARK: INIT
    required init(anchorView: UIView) {
        let xPopUp = anchorView.frame.origin.x + ((anchorView.frame.size.width - FGTwoOptionsPopUp.getSize().width) / 2)
        let yPopUp:CGFloat = anchorView.frame.origin.y - FGTwoOptionsPopUp.getSize().height;
        let frame = CGRect(x: xPopUp, y:yPopUp, width: FGTwoOptionsPopUp.getSize().width, height: FGTwoOptionsPopUp.getSize().height)
        
        super.init(frame: frame)
        
        
        
       

        self.anchorView = anchorView
        self.type = PopUpType.up
        self.popUpSettings()
        self.buttonsSettings()
        
    }
    
    static func getSize()->CGSize{
        var width = FGTWOOPTIONS_WIDTH
        var height = FGTWOOPTIONS_HEIGHT
        let actualScaleFactor = FGTWOOPTIONS_HEIGHT / FGTWOOPTIONS_WIDTH
        let maxWidth = (UIScreen.main.nativeBounds.size.width * 0.8) / UIScreen.main.nativeScale

        if(FGTWOOPTIONS_WIDTH > maxWidth){
            width = maxWidth
            height = width * actualScaleFactor
            
        }
       
        return CGSize(width: width, height: height)
    }
    
    func addAllConstraints(){
        if(type == .down){
            NSLayoutConstraint(item: self,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: self.anchorView,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: 0).isActive = true
        }
        else{
            NSLayoutConstraint(item: self,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: self.anchorView,
                               attribute: .top,
                               multiplier: 1,
                               constant: 0).isActive = true
        }
        
        NSLayoutConstraint(item: self,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self.anchorView,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: self,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: FGTwoOptionsPopUp.getSize().width).isActive = true
        
        NSLayoutConstraint(item: self,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: FGTwoOptionsPopUp.getSize().height).isActive = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    required init(anchorView: UIView, size: CGSize, type: PopUpType) {
        let xPopUp = anchorView.frame.origin.x + ((anchorView.frame.size.width - size.width) / 2)
        var yPopUp:CGFloat = anchorView.frame.origin.y - size.height;
        if(type == .down){
            yPopUp = anchorView.frame.maxY;
        }
        else{
            yPopUp = anchorView.frame.origin.y - size.height;
        }
        let frame = CGRect(x: xPopUp, y:yPopUp, width: size.width, height: size.height)
        super.init(frame: frame)
        
        self.anchorView = anchorView
        self.type = type
        self.popUpSettings()
        self.buttonsSettings()
        
    }
    
    func popUpSettings(){
        self.checkTypeIfInBoundsAndEventuallyFixPosition()
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
        self.layer.masksToBounds = false
        self.clipsToBounds = false
    }
    
    func buttonsSettings(){
        //DIMENSION
        let widthPopUpView = self.frame.size.width
        let heightPopUpView = self.frame.size.height
        
        let radiusInternalButton:CGFloat = (FGTWOOPTIONS_CORNER_RADIUS -  FGTWOOPTIONS_BORDER)
        let verticalUnitPopView = ((heightPopUpView - (2 * FGTWOOPTIONS_CORNER_RADIUS)) / 3)
        
        var yButton:CGFloat
        if(self.type == .up){
            yButton = FGTWOOPTIONS_BORDER
        }
        else{
            yButton = FGTWOOPTIONS_BORDER + verticalUnitPopView
        }
        //draw button left
        self.leftButton = FGTwoOptionsButton(type: PopUpButtonType.left, radius: radiusInternalButton)
        let widthLeftButton : CGFloat = (widthPopUpView - (3 * FGTWOOPTIONS_BORDER)) / 2
        let heightLeftButton : CGFloat = heightPopUpView - ( verticalUnitPopView + (2 * FGTWOOPTIONS_BORDER))
        let xLeftButton = FGTWOOPTIONS_BORDER
        self.leftButton.frame = CGRect(x: xLeftButton, y: yButton, width: widthLeftButton, height: heightLeftButton)
        self.leftButton.layer.masksToBounds = false
        self.leftButton.clipsToBounds = false
        self.leftButton.titleLabel!.textAlignment = .center
        self.leftButton.setTitleColor(FGTWOOPTIONS_LEFT_BUTTON_TEXT_COLOR, for: .normal)
        self.addSubview(leftButton)
        //draw button right
        self.rightButton = FGTwoOptionsButton(type: PopUpButtonType.right, radius: radiusInternalButton)
        let widthRightButton : CGFloat = (widthPopUpView - (3 * FGTWOOPTIONS_BORDER)) / 2
        let heightRightButton : CGFloat = heightLeftButton
        let xRightButton = (FGTWOOPTIONS_BORDER * 2) + widthLeftButton
        self.rightButton.frame = CGRect(x: xRightButton, y: yButton, width: widthRightButton, height: heightRightButton)
        self.rightButton.layer.masksToBounds = false
        self.rightButton.clipsToBounds = false
        self.rightButton.titleLabel!.textAlignment = .center
        self.rightButton.setTitleColor(FGTWOOPTIONS_RIGHT_BUTTON_TEXT_COLOR, for: .normal)

        self.addSubview(rightButton)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*************************************************************************************************************************************/
    //MARK: DRAW METHODS
    override func draw(_ rect: CGRect) {
        //il background "esterno" a quello disegnato deve essere clear
        UIColor.clear.setStroke()
        //Disegno forma popup
        let bezierPath = inputPopUpViewPath()
        //Coloro interno view
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        FGTWOOPTIONS_BACKGROUND_COLOR.setFill()
        bezierPath.fill()
        context?.restoreGState()
            
    }
    
    fileprivate func inputPopUpViewPath() -> UIBezierPath {
        
        var path:UIBezierPath!
        
        
        switch self.type{
        case .up:
            path = self.drawAnAbovePopUp()
            break
        case .down:
            path = self.drawAnBelowPopUp()
            break
        default:
            path = self.drawAnAbovePopUp()
        }
        return path
    }
    
    func drawAnAbovePopUp()-> UIBezierPath{
        NSLog("drawAnAbovePopUp")

        let horizontalLineWidth = self.frame.size.width - (2 * FGTWOOPTIONS_CORNER_RADIUS)
        let verticalUnit = ((self.frame.size.height - (2 * FGTWOOPTIONS_CORNER_RADIUS)) / 3)
        let verticalLineHeight = verticalUnit * 2
        let finalPoint =  CGPoint(x: (self.frame.size.width / 2), y: self.frame.size.height)
        let path = UIBezierPath()
        
        path.home()
        path.lineWidth = 0
        path.lineCapStyle = CGLineCap.round
        path.move(to: finalPoint)
        let ySecondPoint = verticalUnit * 2 + (2 * FGTWOOPTIONS_CORNER_RADIUS)
        let xSecondPoint = self.frame.width - FGTWOOPTIONS_CORNER_RADIUS
        let secondPoint = CGPoint(x: xSecondPoint, y: ySecondPoint)
        path.addLine(to: secondPoint)
        path.bearing = 90
        path.leftArc(FGTWOOPTIONS_CORNER_RADIUS, turn: 90)
        path.forward(verticalLineHeight)
        path.leftArc(FGTWOOPTIONS_CORNER_RADIUS, turn: 90)
        path.forward(horizontalLineWidth)
        path.leftArc(FGTWOOPTIONS_CORNER_RADIUS, turn: 90)
        path.forward(verticalLineHeight)
        path.leftArc(FGTWOOPTIONS_CORNER_RADIUS, turn: 90)
        path.addLine(to: finalPoint)
        return path
    }
    
    func drawAnBelowPopUp()-> UIBezierPath{
        NSLog("drawAnBelowPopUp")
      
        let horizontalLineWidth = self.frame.size.width - (2 * FGTWOOPTIONS_CORNER_RADIUS)
        let verticalUnit = ((self.frame.size.height - (2 * FGTWOOPTIONS_CORNER_RADIUS)) / 3)
        let verticalLineHeight = verticalUnit * 2
        let finalPoint =  CGPoint(x: (self.frame.size.width / 2), y: 0)
        let path = UIBezierPath()
        
        path.home()
        path.lineWidth = 0
        path.lineCapStyle = CGLineCap.round
        path.move(to: finalPoint)
        let ySecondPoint = verticalUnit
        let xSecondPoint = FGTWOOPTIONS_CORNER_RADIUS
        let secondPoint = CGPoint(x: xSecondPoint, y: ySecondPoint)
        path.addLine(to: secondPoint)
        path.bearing = 270
        path.leftArc(FGTWOOPTIONS_CORNER_RADIUS, turn: 90)
        path.forward(verticalLineHeight)
        path.leftArc(FGTWOOPTIONS_CORNER_RADIUS, turn: 90)
        path.forward(horizontalLineWidth)
        path.leftArc(FGTWOOPTIONS_CORNER_RADIUS, turn: 90)
        path.forward(verticalLineHeight)
        path.leftArc(FGTWOOPTIONS_CORNER_RADIUS, turn: 90)
        path.addLine(to: finalPoint)
        return path
    }
    
    func checkTypeIfInBoundsAndEventuallyFixPosition(){
        if(type == .up){
            NSLog("checkTypeIfInBoundsAndEventuallyFix...UP")
            if(!isUpOk()){
                NSLog("checkTypeIfInBoundsAndEventuallyFix...UP->DOWN")
                self.frame.origin.y = self.anchorView.frame.maxY
                type = .down
            }
        }
        else if(type == .down){
            NSLog("checkTypeIfInBoundsAndEventuallyFix...DOWN")
            if(!isDownOk()){
                NSLog("checkTypeIfInBoundsAndEventuallyFix...DOWN->UP")
                self.frame.origin.y  = self.anchorView.frame.origin.y - self.frame.size.height;
                type = .up
            }
        }
    }
    
    func isUpOk()->Bool{
        return self.frame.origin.y >= 0
    }
    
    func isDownOk()->Bool{
        return self.frame.maxY < UIScreen.main.bounds.height
    }
    /*************************************************************************************************************************************/
    //MARK: GETTER/SETTER
    func getLeftButton()->FGTwoOptionsButton{
        return self.leftButton
    }
    func getRightButton()->FGTwoOptionsButton{
        return rightButton
    }
    

    
   
}
