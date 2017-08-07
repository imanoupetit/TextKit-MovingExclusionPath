//
//  ViewController.swift
//  MovingExclusionPath
//
//  Created by Imanou Petit on 07/08/2017.
//  Copyright © 2017 Imanou Petit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: TextView!
    let badgeView = BadgeView()
    var gestureStartingPoint = CGPoint()
    var gestureStartingCenter = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UIPanGestureRecognizer(target: self, action: #selector(badgeViewPanned(_:)))
        badgeView.addGestureRecognizer(tapGesture)

        textView.addSubview(badgeView)
        //view.addSubview(badgeView)
        textView.textContainer.exclusionPaths = [translatedBezierPath()]
    }
    
    func translatedBezierPath() -> UIBezierPath {
        let badgeRect = badgeView.frame // use this declaration if badgeView is a subview of textView
        //let badgeRect = textView.convert(badgeView.frame, from: view) // use this declaration if badgeView is a subview of view
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
