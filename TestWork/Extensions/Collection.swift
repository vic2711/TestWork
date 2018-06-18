//
//  Collection.swift
//  TestWork
//
//  Created by Viktor Miroshnychenko on 6/17/18.
//  Copyright © 2018 FoxHound. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (exist index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
