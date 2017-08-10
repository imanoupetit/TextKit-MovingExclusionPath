//
//  ViewController1.swift
//  MovingExclusionPath
//
//  Created by Imanou Petit on 07/08/2017.
//  Copyright © 2017 Imanou Petit. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    @IBOutlet weak var textView: TextView!
    let badgeView = BadgeView(frame: CGRect(x: 150, y: 150, width: 120, height: 120))
    var gestureStartingPoint = CGPoint()
    var gestureStartingCenter = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Gesture
        let tapGesture = UIPanGestureRecognizer(target: self, action: #selector(badgeViewPanned(_:)))
        badgeView.addGestureRecognizer(tapGesture)
        view.addSubview(badgeView)
        
        textView.layoutManager.hyphenationFactor = 1
        textView.textContainer.exclusionPaths = [translatedBezierPath()]
    }
    
    func translatedBezierPath() -> UIBezierPath {
        let badgeRect = textView.convert(badgeView.frame, from: view)
        let newPath = badgeView.roundedPath.copy() as! UIBezierPath
        newPath.apply(CGAffineTransform(translationX: badgeRect.origin.x, y: badgeRect.origin.y))
        return newPath
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.textContainer.exclusionPaths = [translatedBezierPath()]
    }
    
    @objc func badgeViewPanned(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            gestureStartingPoint = sender.location(in: textView)
            gestureStartingCenter = badgeView.center
        case .changed:
            let currentPoint = sender.location(in: textView)
            let distanceX = currentPoint.x - gestureStartingPoint.x
            let distanceY = currentPoint.y - gestureStartingPoint.y
            let newCenter = CGPoint(x: gestureStartingCenter.x + distanceX, y: gestureStartingCenter.y + distanceY)
            badgeView.center = newCenter
            textView.textContainer.exclusionPaths = [translatedBezierPath()]
        case .ended:
            gestureStartingPoint = .zero
            gestureStartingCenter = .zero
        default:
            break
        }
    }

}
