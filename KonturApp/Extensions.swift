//
//  Extensions.swift
//  KonturApp
//
//  Created by Никита Дмитриев on 21.03.2022.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
