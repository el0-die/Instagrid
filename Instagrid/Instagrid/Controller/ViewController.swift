//
//  ViewController.swift
//  Instagrid
//
//  Created by Elodie Desmoulin on 29/01/2020.
//  Copyright © 2020 Elodie Desmoulin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

// MARK: - Outlets

    @IBOutlet weak var centralView: CentralView!
    
    @IBOutlet weak var layoutButton1: UIButton!
    @IBOutlet weak var layoutButton2: UIButton!
    @IBOutlet weak var layoutButton3: UIButton!
    
    @IBOutlet weak var swipeMessage: UILabel!
    
// MARK: - App Running
    
    override func viewDidLoad() {
        super.viewDidLoad()
    // Swipe in Portrait Mode
        let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeCentralView(_:)))
        centralView.addGestureRecognizer(swipeUpGestureRecognizer)
        
            swipeUpGestureRecognizer.direction = .up
        
    //Swipe in Landscape Mode
        let swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeCentralView(_:)))
        centralView.addGestureRecognizer(swipeLeftGestureRecognizer)
        
            swipeLeftGestureRecognizer.direction = .left
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        switch UIDevice.current.orientation{
        case .portrait:
            swipeMessage.text = "Swipe up to share"
        case .portraitUpsideDown:
            swipeMessage.text = "Not supported orientation"
        case .landscapeLeft:
            swipeMessage.text = "Swipe left to share"
        case .landscapeRight:
            swipeMessage.text = "Swipe left to share"
        default:
            swipeMessage.text = "Not supported orientation"
        }
    }
    
    @objc func swipeCentralView(_ sender: UISwipeGestureRecognizer) {
        
    }
    
// MARK: - Layout Button
    
    @IBAction func tappedLayoutButton(_ button: UIButton) {
        switch button {
            case layoutButton1:
                layoutButton1.setImage(UIImage(named: "Selected"), for: .normal)
                layoutButton2.setImage(nil, for: .normal)
                layoutButton3.setImage(nil, for: .normal)
            // Adjust CentralView on 1st Layout
                centralView.layout = .topRectangle
            case layoutButton2:
                layoutButton1.setImage(nil, for: .normal)
                layoutButton2.setImage(UIImage(named: "Selected"), for: .normal)
                layoutButton3.setImage(nil, for: .normal)
            // Adjust CentralView on 2nd Layout
                centralView.layout = .bottomRectangle
            case layoutButton3:
                layoutButton1.setImage(nil, for: .normal)
                layoutButton2.setImage(nil, for: .normal)
                layoutButton3.setImage(UIImage(named: "Selected"), for: .normal)
            // Adjust CentralView on 3rd Layout
                centralView.layout = .fourSquare
            default:
                break
        }
    }
}


