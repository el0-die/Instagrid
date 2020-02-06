//
//  ViewController.swift
//  Instagrid
//
//  Created by Elodie Desmoulin on 29/01/2020.
//  Copyright © 2020 Elodie Desmoulin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
// MARK: - Outlets
    @IBOutlet var centralView: CentralView!
    
    @IBOutlet var layoutButton1: UIButton!
    @IBOutlet var layoutButton2: UIButton!
    @IBOutlet var layoutButton3: UIButton!
    
    @IBOutlet var selected1: UIImageView!
    @IBOutlet var selected2: UIImageView!
    @IBOutlet var selected3: UIImageView!

    @IBOutlet var allLayoutButtons: [UIButton]!
    
    
    //    @IBOutlet weak var allLayoutButtons: UIStackView!
    
    @IBAction func tappedLayoutButton(_ sender: UIButton) {
        if sender.isSelected {
            newLayoutSelected(sender)
        }
    }
    
    private func newLayoutSelected(_ button: UIButton) {
           button.isSelected = true
           switch button {
           case layoutButton1:
                centralView.layout = .topRectangle
                selected1.isHidden = false
                selected2.isHidden = true
                selected3.isHidden = true
           case layoutButton2:
                centralView.layout = .bottomRectangle
                selected1.isHidden = true
                selected2.isHidden = false
                selected3.isHidden = true
           case layoutButton3:
                centralView.layout = .fourSquare
                selected1.isHidden = true
                selected2.isHidden = true
                selected3.isHidden = false
           default:
               break
           }
       }
    
}


