//
//  WishEventCreationViewController.swift
//  iegobetsPW2
//
//  Created by Ivan on 03.12.2024.
//

import UIKit

// MARK: -Protocols
protocol WishEventCreationViewDelegate: AnyObject {
    func saveButtonPressed(with eventModel: CalendarEventModel)
}

final class WishEventCreationViewController: UIViewController, WishEventCreationViewDelegate {
    // MARK: - Constants
    private let wishEventCreationView  = WishEventCreationView()
    private let calendarManager = CalendarManager()
    
    // MARK: - Delegate
    weak var delegate: WishCalendarViewControllerDelegate?
    
    // MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(wishEventCreationView)
        wishEventCreationView.pin(to: view)
        
        wishEventCreationView.delegate = self
    }
    
    // MARK: -Methods
    func saveButtonPressed(with eventModel: CalendarEventModel) {
        let _ = calendarManager.create(eventModel: eventModel)
        delegate?.didCreateEvent(eventModel)
    }
}

