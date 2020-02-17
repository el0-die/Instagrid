//
//  CentralView.swift
//  Instagrid
//
//  Created by Elodie Desmoulin on 06/02/2020.
//  Copyright © 2020 Elodie Desmoulin. All rights reserved.
//

import UIKit

class CentralView: UIView {
    @IBOutlet var addButton1: UIButton!
    @IBOutlet var addButton2: UIButton!
    @IBOutlet var addButton3: UIButton!
    @IBOutlet var addButton4: UIButton!

    enum Layout {
        case topRectangle, bottomRectangle, fourSquare
    }

    var layout: Layout = .fourSquare {
        didSet {
            setLayout(layout)
        }
    }

    func setLayout(_ layout: Layout) {
        switch layout {
        case .topRectangle:
            addButton1.isHidden = false
            addButton2.isHidden = true
            addButton3.isHidden = false
            addButton4.isHidden = false
        case .bottomRectangle:
            addButton1.isHidden = false
            addButton2.isHidden = false
            addButton3.isHidden = false
            addButton4.isHidden = true
        case .fourSquare :
            addButton1.isHidden = false
            addButton2.isHidden = false
            addButton3.isHidden = false
            addButton4.isHidden = false
        }
    }

}
