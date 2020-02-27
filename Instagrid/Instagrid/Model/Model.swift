//
//  Model.swift
//  Instagrid
//
//  Created by Elodie Desmoulin on 26/02/2020.
//  Copyright © 2020 Elodie Desmoulin. All rights reserved.
//

import Foundation

enum Layout {
    case topRectangle, bottomRectangle, fourSquare
}

class Model {
    var layout: Layout = .fourSquare {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("layoutUpdated"), object: nil)
        }
    }

    var emptyBoxes: [Int: Bool] = [1: true, 2: true, 3: true, 4: true] {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("imageUpdated"), object: nil)
        }
    }

    var hasCentralViexEmptyBox: Bool {
        switch layout {
        case .topRectangle:
            return emptyBoxes[1]! || emptyBoxes[3]! || emptyBoxes[4]!
        case .bottomRectangle:
            return emptyBoxes[1]! || emptyBoxes[2]! || emptyBoxes[3]!
        case .fourSquare:
            return emptyBoxes[1]! || emptyBoxes[2]! || emptyBoxes[3]! || emptyBoxes[4]!
        }
    }
}
