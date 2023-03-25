//
//  File.swift
//  
//
//  Created by James Wolfe on 25/03/2023.
//

import Foundation

extension Array {
    
    internal func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
}
