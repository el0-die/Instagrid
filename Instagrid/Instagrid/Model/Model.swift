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

    var hasCentralViewEmptyBox: Bool {
        switch layout {
        case .topRectangle:
            return checkEmpty(dictionnary: emptyBoxes, positions: [1, 3, 4])
        case .bottomRectangle:
            return checkEmpty(dictionnary: emptyBoxes, positions: [1, 2, 3])
        case .fourSquare:
            return checkEmpty(dictionnary: emptyBoxes, positions: [1, 2, 3, 4])
        }
    }

    private func checkEmpty(dictionnary: [Int: Bool], positions: [Int]) -> Bool {
        for (key, value) in dictionnary {
            if positions.contains(key) && value {
                return true
            }
        }
        return false
    }
}
