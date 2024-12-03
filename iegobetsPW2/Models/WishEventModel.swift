//
//  WishEventModel.swift
//  iegobetsPW2
//
//  Created by Ivan on 03.12.2024.
//

import Foundation

struct WishEventModel {
    let title: String
    let description: String
    let startDate: Date
    let endDate: Date
    
    init(title: String, description: String, startDate: Date, endDate: Date) {
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }
}
