//
//  Array+Subsets.swift
//  Tests
//
//  Created by Nick Raptis on 11/22/22.
//

import Foundation

extension Array where Element: Comparable {
    func allSubsets() -> [[Element]] {
        let elements = self.sorted()
        var result = [[Element]]()
        result.append([])
        var index = 0
        while index < elements.count {
            var duplicateCount = 1
            while (index + duplicateCount) < elements.count && elements[index + duplicateCount] == elements[index] {
                duplicateCount += 1
            }
            let resultCount = result.count
            for resultIndex in 0..<resultCount {
                var array = result[resultIndex]
                for _ in 0..<duplicateCount {
                    array.append(elements[index])
                    result.append(array)
                }
            }
            index += duplicateCount
        }
        return result
    }
    
    
}
