//
//  Extensions.swift
//  Nertflix
//
//  Created by Lily Tran on 8/5/24.
//

import Foundation

extension String {
    func capitalizerFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
