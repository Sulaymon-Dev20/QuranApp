//
//  Int.swift
//  QuranApp
//
//  Created by Sulaymon on 25/05/23.
//

import Foundation

extension Int {
    var usefulDigits: Int {
        var length = 0;
        var temp = 1;
        while (temp <= self) {
            length += 1;
            temp *= 10;
        }
        return length;
    }
}
