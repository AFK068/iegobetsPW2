//
//  CalendarEventModel.swift
//  iegobetsPW2
//
//  Created by Ivan on 03.12.2024.
//

import Foundation

extension CalendarEventModel {
    func toWishEventModel() -> WishEventModel {
        return WishEventModel(
            title: self.title,
            description: self.note ?? "",  
            startDate: self.startDate,
            endDate: self.endDate
        )
    }
}

struct CalendarEventModel {
    let title: String
    let startDate: Date
    let endDate: Date
    let note: String?
    
    init(title: String, startDate: Date, endDate: Date, note: String? = nil) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.note = note
    }
}
