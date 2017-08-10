//
//  CircleView.swift
//  MovingExclusionPath
//
//  Created by Imanou Petit on 10/08/2017.
//  Copyright © 2017 Imanou Petit. All rights reserved.
//

import UIKit

//@IBDesignable
class CircleView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        tintColor.setFill()
        let circlePath = UIBezierPath(ovalIn: bounds)
        circlePath.fill()
    }
    
}
