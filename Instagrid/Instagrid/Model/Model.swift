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

    // Check if CentralView is empty != sharable or it is not = sharable
    var hasCentralViewEmptyBox: Bool {
        switch layout {
        case .topRectangle:
            return isBoxEmpty(positions: [1, 3, 4])
        case .bottomRectangle:
            return isBoxEmpty(positions: [1, 2, 3])
        case .fourSquare:
            return isBoxEmpty(positions: [1, 2, 3, 4])
        }
    }

    // Check if a box is empty or not
    private func isBoxEmpty(positions: [Int]) -> Bool {
        for (key, value) in emptyBoxes {
            if positions.contains(key) && value {
                return true
            }
        }
        return false
    }
}
