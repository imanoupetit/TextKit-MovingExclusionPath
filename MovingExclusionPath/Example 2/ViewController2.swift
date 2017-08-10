//
//  ViewController.swift
//  MovingExclusionPath
//
//  Created by Imanou Petit on 10/08/2017.
//  Copyright © 2017 Imanou Petit. All rights reserved.
//

import UIKit

final class ViewController2: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var circleView: CircleView!
    private var panOffset = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // text view interaction
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        //textView.textContainerInset = .zero

        // Load text
        let sharedTextStorage = textView.textStorage
        let url = Bundle.main.url(forResource: "lorem", withExtension: "txt")!
        let stringFromUrl = try! String(contentsOf: url)
        sharedTextStorage.replaceCharacters(in: NSRange(location: 0, length: 0), with: stringFromUrl)

        // Delegate
        textView.delegate = self

        // Gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCircle(_:)))
        circleView.addGestureRecognizer(panGesture)
        
        // Enable hyphenation
        textView.layoutManager.hyphenationFactor = 1
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Update exclusion path
        updateExclusionPath()
        
    }
    
    private func updateExclusionPath() {
        var circleFrame = textView.convert(circleView.bounds, from: circleView)
        
        // Since text container does not know about the inset, we must shift the frame to container coordinates
        circleFrame.origin.x -= textView.textContainerInset.left
        circleFrame.origin.y -= textView.textContainerInset.top
        
        // Simply set the exclusion path
        let circlePath = UIBezierPath(ovalIn: circleFrame)
        textView.textContainer.exclusionPaths = [circlePath]
    }

    @objc func panCircle(_ sender: UIPanGestureRecognizer) {
        // Capture offset in view on begin
        if case .began = sender.state {
            panOffset = sender.location(in: circleView)
        }

        // Update view location
        let location = sender.location(in: view)
        var circleCenter = circleView.center

        circleCenter.x = location.x - panOffset.x + circleView.frame.size.width / 2
        circleCenter.y = location.y - panOffset.y + circleView.frame.size.width / 2
        circleView.center = circleCenter

        // Update exclusion path
        updateExclusionPath()
    }
    
}
