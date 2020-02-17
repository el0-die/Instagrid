//
//  GridView.swift
//  Instagrid
//
//  Created by Elodie Desmoulin on 23/01/2020.
//  Copyright © 2020 Elodie Desmoulin. All rights reserved.
//

import UIKit

class AllView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet private var selected1: UIImageView!
    @IBOutlet private var selected2: UIImageView!
    @IBOutlet private var selected3: UIImageView!

    enum Layout {
        case topRectangle, bottomRectangle, fourSquare
    }

    var layout: Layout = .bottomRectangle {
        didSet {
            setLayout(layout)
        }
    }

    private func setLayout(_ layout: Layout) {
        switch layout {
        case .topRectangle:
            selected1.isHidden = false
            selected2.isHidden = true
            selected3.isHidden = true
        case .bottomRectangle:
            selected1.isHidden = true
            selected2.isHidden = false
            selected3.isHidden = true
        case .fourSquare:
            selected1.isHidden = true
            selected2.isHidden = true
            selected3.isHidden = false
        }
    }
}
