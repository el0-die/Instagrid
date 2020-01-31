//
//  GridView.swift
//  Instagrid
//
//  Created by Elodie Desmoulin on 23/01/2020.
//  Copyright © 2020 Elodie Desmoulin. All rights reserved.
//

import UIKit

class GridView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet private var button1: UIButton!
    @IBOutlet private var button2: UIButton!
    @IBOutlet private var button3: UIButton!
    
    @IBOutlet private var selected1: UIImageView!
    @IBOutlet private var selected2: UIImageView!
    @IBOutlet private var selected3: UIImageView!
}
