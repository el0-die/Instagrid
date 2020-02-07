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
    
    @IBOutlet var allLayoutButtons: [UIButton]!
    
    @IBOutlet weak var layoutButton1: UIButton!
    @IBOutlet weak var layoutButton2: UIButton!
    @IBOutlet weak var layoutButton3: UIButton!
    
    @IBOutlet weak var swipeText: UILabel!
    
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
    
    @objc func swipeCentralView(_ sender: UISwipeGestureRecognizer) {
        
    }
    
// MARK: - Layout Button
    
    
    @IBAction func tappedLayoutButton(_ sender: UIButton) {
        switch sender {
            case layoutButton1:
                layoutButton1.setImage(UIImage(named: "Selected"), for: .normal)
                layoutButton2.setImage(nil, for: .normal)
                layoutButton3.setImage(nil, for: .normal)
            case layoutButton2:
                layoutButton1.setImage(nil, for: .normal)
                layoutButton2.setImage(UIImage(named: "Selected"), for: .normal)
                layoutButton3.setImage(nil, for: .normal)
            case layoutButton3:
                layoutButton1.setImage(nil, for: .normal)
                layoutButton2.setImage(nil, for: .normal)
                layoutButton3.setImage(UIImage(named: "Selected"), for: .normal)
            default:
                break
            }

    }
}


