//
//  WishCalendarViewController.swift
//  iegobetsPW2
//
//  Created by Ivan on 03.12.2024.
//

import UIKit

protocol WishCalendarViewControllerDelegate: AnyObject {
    func didPressEvenCreationButton()
    func didCreateEvent(_ event: CalendarEventModel) 
}

final class WishCalendarViewController: UIViewController, WishCalendarViewControllerDelegate {
    // MARK: - Variables
    private var calendarView = WishCalendarView()
    private var events: [CalendarEventModel] = []
    private var defaults = UserDefaults.standard
    private var eventsKey = "savedEventsKey"
    
    // MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView = WishCalendarView(frame: view.bounds)
        view.addSubview(calendarView)
        
        calendarView.delegate = self
        calendarView.getCollectionView().delegate = self
        calendarView.getCollectionView().dataSource = self
        
        loadEvents()
        calendarView.updateEvents(events)
    }
    
    // MARK: -Methods
    func didPressEvenCreationButton() {
        let vc = WishEventCreationViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func didCreateEvent(_ event: CalendarEventModel) {
        events.append(event)
        saveEvents()
        calendarView.updateEvents(events)
    }
    
    // MARK: - Private methods
    private func loadEvents() {
        if let storedEventsData = defaults.array(forKey: eventsKey) as? [[String: Any]] {
            events = storedEventsData.compactMap { dict in
                guard let title = dict["title"] as? String,
                      let startDate = dict["startDate"] as? Date,
                      let endDate = dict["endDate"] as? Date else { return nil }
                return CalendarEventModel(title: title, startDate: startDate, endDate: endDate)
            }
        }
    }
    
    private func saveEvents() {
        let eventsToSave = events.map { event -> [String: Any] in
            return [
                "title": event.title,
                "startDate": event.startDate,
                "endDate": event.endDate,
                "note": event.note ?? ""
            ]
        }
        defaults.set(eventsToSave, forKey: eventsKey)
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return events.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseIdentifier, for: indexPath)
        
        guard let eventCell = cell as? WishEventCell else {
            return cell
        }
        
        let event = events[indexPath.item]
        eventCell.configure(with: event)
        
        return eventCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // Adjust cell size as needed
        return CGSize(width: collectionView.bounds.width - 10, height: 100)
    }
}
