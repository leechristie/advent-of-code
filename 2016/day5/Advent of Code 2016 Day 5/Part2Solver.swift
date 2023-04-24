//
//  Part2Solver.swift
//  Advent of Code 2016 Day 5
//
//  Created by 0x1ac on 2023-04-24.
//

import Foundation
import CryptoKit

public class Part2Solver {
    
    private func hash(doorID: String, index: Int) -> String {
        let text = "\(doorID)\(index)"
        let ascii: [UInt8] = Array(text.utf8)
        let hash = Insecure.MD5.hash(data: ascii)
        return String(hash.description.split(separator: " ")[2])
    }
    
    let doorID: String
    let prefix: String

    init(doorID: String, difficulty: Int) {
        self.doorID = doorID
        self.prefix = String(repeating: "0", count: difficulty)
    }
    
    public func solvePart2(callback: (Int, Character) async -> Void) async {
        
        let doorID = self.doorID
                
        var result: [Character?] = [nil, nil, nil, nil, nil, nil, nil, nil]
        var found = 0
        
        var index = 0
        while (found < 8) {
            let hashStr = hash(doorID: doorID, index: index)
            if hashStr.starts(with: "00000") {
                let positionIndicator = hashStr[hashStr.index(hashStr.startIndex, offsetBy: 5)]
                if let i = Int(String(positionIndicator)) {
                    if i < 8 {
                        if result[i] == nil {
                            let char = hashStr[hashStr.index(hashStr.startIndex, offsetBy: 6)]
                            result[i] = char
                            await callback(i, char)
                            found += 1
                        }
                    }
                }
            }
            index += 1
        }

    }
    
}
