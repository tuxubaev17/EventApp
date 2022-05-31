//
//  Date+Extensions.swift
//  EventsApp
//
//  Created by Alikhan on 27.05.2022.
//

import Foundation

extension Date {
    func timeRemaining(until endDate: Date) -> String? {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.year, .month, .weekOfMonth, .day]
        dateComponentsFormatter.unitsStyle = .full
        return dateComponentsFormatter.string(from: self, to: endDate)
        
    }
}
