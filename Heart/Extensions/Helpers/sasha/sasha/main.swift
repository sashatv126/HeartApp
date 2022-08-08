//
//  main.swift
//  sasha
//
//  Created by Александр Александрович on 06.08.2022.
//

import Foundation

print("Hello, World!")

let a = Int16(readLine()!)
let b = Int16(readLine()!)

func sumAB(a: Int16?, B:Int16?) -> Int32? {
    guard let a = a, let b = b else { return nil }
    let sum: Int32? = Int32(a) + Int32(b)
    guard let sum = sum else { return nil }
    return sum
}

if let sum = sumAB(a: a, B: b) {
    print(sum)
}

