//
//  TextView.swift
//  MovingExclusionPath
//
//  Created by Imanou Petit on 07/08/2017.
//  Copyright © 2017 Imanou Petit. All rights reserved.
//

import UIKit

class TextView: UITextView {
    
    convenience init() {
        self.init(frame: .zero, textContainer: nil)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setContentAndStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setContentAndStyle()
    }
    
    func setContentAndStyle() {
        isEditable = false
        isScrollEnabled = false
        isSelectable = false
        textContainerInset = .zero
        
        let text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        let attributes = [NSAttributedStringKey.font : UIFont.preferredFont(forTextStyle: .title1)]
        attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
}
