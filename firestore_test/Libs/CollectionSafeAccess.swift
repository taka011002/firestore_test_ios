//
//  ListSafeAccess.swift
//  relay-cars-jp-ios
//
//  Created by daiki.tanaka on 2019/01/11.
//  Copyright © 2019 RELAY.Inc. All rights reserved.
//

import Foundation

extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

}
