//
//  ViewController.swift
//  FGTwoOptionsPopUp
//
//  Created by Filippo Giove on 29/05/18.
//  Copyright © 2018 Filippo Giove. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var twoOptionsButton: UIButton!
    @IBOutlet var twoOptionButtonMiddle: UIButton!
    @IBOutlet var twoOptionButtonBottom: UIButton!
    var twoOptionPopUp_UP : FGTwoOptionsPopUp!
    var twoOptionPopUp_MIDDLE : FGTwoOptionsPopUp!
    var twoOptionPopUp_DOWN : FGTwoOptionsPopUp!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func clickOnTwoOptionsButton(_ sender: UIButton) {
        
        if(self.twoOptionPopUp_UP == nil){
            //POPUP UP
            self.twoOptionPopUp_UP = FGTwoOptionsPopUp(anchorView: self.twoOptionsButton)
            self.twoOptionPopUp_UP.getLeftButton().setTitle("LEFT", for: UIControlState())
            self.twoOptionPopUp_UP.getRightButton().setTitle("RIGHT", for: UIControlState())
            self.twoOptionPopUp_UP.getLeftButton().addTarget(self, action: #selector(self.openORClose_UP), for:.touchUpInside)
            self.twoOptionPopUp_UP.getRightButton().addTarget(self, action: #selector(self.openORClose_UP), for:.touchUpInside)
            self.view.addSubview(self.twoOptionPopUp_UP)
            //IMPORTANT! Put this after adding popup to superview
            self.twoOptionPopUp_UP.addAllConstraints()
        }
        
    }
    
    @IBAction func clickOnTwoOptionsButtonMiddle(_ sender: UIButton) {
        if(self.twoOptionPopUp_MIDDLE == nil){
            self.twoOptionPopUp_MIDDLE = FGTwoOptionsPopUp(anchorView: twoOptionButtonMiddle)
            self.twoOptionPopUp_MIDDLE.getLeftButton().setTitle("LEFT", for: UIControlState())
            self.twoOptionPopUp_MIDDLE.getRightButton().setTitle("RIGHT", for: UIControlState())
            self.twoOptionPopUp_MIDDLE.getLeftButton().addTarget(self, action: #selector(self.openORClose_MIDDLE), for:.touchUpInside)
            self.twoOptionPopUp_MIDDLE.getRightButton().addTarget(self, action: #selector(self.openORClose_MIDDLE), for:.touchUpInside)
            self.view.addSubview(self.twoOptionPopUp_MIDDLE)
            self.twoOptionPopUp_MIDDLE.addAllConstraints()
            
        }
        
    }
    
    @IBAction func clickOnTwoOptionsButtonBottom(_ sender: UIButton) {
        if(self.twoOptionPopUp_DOWN == nil){
            self.twoOptionPopUp_DOWN = FGTwoOptionsPopUp(anchorView: twoOptionButtonBottom)
            self.twoOptionPopUp_DOWN.getLeftButton().setTitle("LEFT", for: UIControlState())
            self.twoOptionPopUp_DOWN.getRightButton().setTitle("RIGHT", for: UIControlState())
            self.twoOptionPopUp_DOWN.getLeftButton().addTarget(self, action: #selector(self.openORClose_DOWN), for:.touchUpInside)
            self.twoOptionPopUp_DOWN.getRightButton().addTarget(self, action: #selector(self.openORClose_DOWN), for:.touchUpInside)
            self.view.addSubview(self.twoOptionPopUp_DOWN)
            self.twoOptionPopUp_DOWN.addAllConstraints()
        }
        
    }
    
    
    
    //MARK: action methods
    @objc func openORClose_UP(){
        self.twoOptionPopUp_UP.removeFromSuperview()
        self.twoOptionPopUp_UP = nil
    }
    @objc func openORClose_MIDDLE(){
        self.twoOptionPopUp_MIDDLE.removeFromSuperview()
        self.twoOptionPopUp_MIDDLE = nil
    }
    @objc func openORClose_DOWN(){
        self.twoOptionPopUp_DOWN.removeFromSuperview()
        self.twoOptionPopUp_DOWN = nil
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

