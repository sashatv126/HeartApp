//
//  Array + Extension.swift
//  Heart
//
//  Created by Александр Александрович on 29.07.2022.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array where Element == Int? {
    var max : Int? {
        var max = self.first!
        for element in self {
            if element! > max! {
                max = element
            }
        }
        return max
    }
    
    var min : Int? {
        var min = self.first!
        for element in self {
            if element! < min! {
                min = element
            }
        }
        return min
    }
    
    var average : Int? {
        guard self.count > 2 else { return nil }
        return self.max! + self.min! / 2
    }
}


