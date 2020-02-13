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
        tappedLayoutButton(layoutButton3)
        
    // Swipe in Portrait Mode
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(whichSwipe(_:)))
        centralView.addGestureRecognizer(swipeUp)
            swipeUp.direction = .up

    //Swipe in Landscape Mode
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(whichSwipe(_:)))
        centralView.addGestureRecognizer(swipeLeft)
            swipeLeft.direction = .left

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(deviceOrientationChanged), name: Notification.Name("UIDeviceOrientationDidChangeNotification"), object: nil)
    }
    
// MARK: - Device Rotation
    
    private func didRotate(interfaceOrientation: UIInterfaceOrientation){
        switch interfaceOrientation{
        case .portrait:
            swipeMessage.text = "Swipe up to share"
        default:
            swipeMessage.text = "Swipe left to share"
        }
    }
    
    @objc func deviceOrientationChanged() {
        didRotate(interfaceOrientation: UIApplication.shared.statusBarOrientation)
    }

//    @objc func swipeCentralView(_ sender: UISwipeGestureRecognizer) {
//        switch sender.state {
//        case .began, .changed:
//            moveCentralView(self)
//        case .ended, .cancelled:
//            shareCentralView()
//        default:
//            break
//        }
//    }
    
// MARK: - Swipe CenterView

    @objc func whichSwipe(_ sender: UISwipeGestureRecognizer){
        if sender.direction != .left && UIDevice.current.orientation == .portrait {
            UIView.animate(withDuration: 1) {
            self.centralView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            }
        }else if sender.direction != .up && UIDevice.current.orientation != .portrait{
            UIView.animate(withDuration: 1) {
            self.centralView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            }
        }
    }

    func shareCentralView() {

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


