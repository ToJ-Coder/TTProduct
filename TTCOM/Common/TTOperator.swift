//
//  TTOperator.swift
//  TTProduct
//
//  Created by Toj on 1/14/21.
//

import Foundation

infix operator =+ : AdditionPrecedence
extension String {
    @inlinable public static func =+(lhs: inout String, rhs: String) {
        lhs = rhs + lhs
    }
}


