//
//  Date+Ext.swift
//  LikeTok
//
//  Created by Daniel on 23.01.22.
//

import Foundation

extension Date {
    func days(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: sinceDate, to: self).day
    }
}
