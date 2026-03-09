//
//  StatisticViewModel.swift
//  GoalsTrackerApp
//
//  Created by Кирилл on 07.03.2026.
//

import Foundation
internal import Combine
import CoreData

protocol GoalsReadable {
    func readAllGoals() -> [Goal]
}

@MainActor
final class StatisticViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var hasAnyData: Bool = false
    @Published var bestStreakDays: Int = 0
    @Published var perfectDays: Int = 0
    @Published var trackersCompleted: Int = 0
    @Published var averageValue: Int = 0
    
    // MARK: - Private Properties
    private let dataManager: DataManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
        setupNotifications()
        calculateAllStatistics()
    }
    
    @MainActor
    convenience init() {
        self.init(dataManager: DataManager.shared)
    }
    
    // MARK: - Public Methods
    func refreshStatistics() {
        calculateAllStatistics()
    }
    
    // MARK: - Private Methods
    private func setupNotifications() {
        NotificationCenter.default.publisher(for: NSManagedObjectContext.didSaveObjectsNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.calculateAllStatistics()
            }
            .store(in: &cancellables)
    }
    
    private func calculateAllStatistics() {
        let allRecords = dataManager.readAllGoalRecords()

        if !allRecords.isEmpty && allRecords.count >= 2 { hasAnyData = true }
        
        let goalsCount: Int
        if let dm = dataManager as? (any GoalsReadable) {
            goalsCount = dm.readAllGoals().count
        } else {
            let uniqueGoalIDs: Set<UUID> = Set(allRecords.compactMap { $0.goal?.id })
            goalsCount = uniqueGoalIDs.count
        }
        
        bestStreakDays = calculateBestStreak(from: allRecords)
        perfectDays = calculatePerfectDays(records: allRecords, goalsCount: goalsCount)
        trackersCompleted = allRecords.count
        averageValue = Int(calculateAveragePerDay(records: allRecords, goalsCount: goalsCount))
    }
    
    private func calculateBestStreak(from records: [GoalRecord]) -> Int {
        let calendar = Calendar.current
        var uniqueDays = Set<Date>()
        
        for record in records {
            let date = record.date
            let startOfDay = calendar.startOfDay(for: date)
            uniqueDays.insert(startOfDay)
        }
        
        let sortedDays = uniqueDays.sorted()
        
        guard !sortedDays.isEmpty else { return 0 }
        
        var currentStreak = 1
        var maxStreak = 1
        
        for i in 1..<sortedDays.count {
            let prevDay = sortedDays[i-1]
            let currentDay = sortedDays[i]
            
            if let nextDay = calendar.date(byAdding: .day, value: 1, to: prevDay) {
                if calendar.isDate(currentDay, inSameDayAs: nextDay) {
                    currentStreak += 1
                    maxStreak = max(maxStreak, currentStreak)
                } else {
                    currentStreak = 1
                }
            } else {
                currentStreak = 1
            }
        }
        
        return maxStreak
    }
    
    private func calculatePerfectDays(records: [GoalRecord], goalsCount: Int) -> Int {
        guard goalsCount > 0 else { return 0 }
        
        let calendar = Calendar.current
        var recordsByDay: [Date: Set<String>] = [:]
        
        for record in records {
            let date = record.date
            let goalIdentifier: String = {
                if let uuid = record.goal?.id {
                    return uuid.uuidString
                }
                if let goalObjectID = record.goal?.objectID.uriRepresentation().absoluteString {
                    return goalObjectID
                }
                if let recordManagedObjectID = record.objectID.uriRepresentation().absoluteString as String? {
                    return recordManagedObjectID
                }
                return String(describing: ObjectIdentifier(record as AnyObject))
            }()
            
            let startOfDay = calendar.startOfDay(for: date)
            recordsByDay[startOfDay, default: []].insert(goalIdentifier)
        }
        
        return recordsByDay.values.filter { $0.count == goalsCount }.count
    }
    
    private func calculateAveragePerDay(records: [GoalRecord], goalsCount: Int) -> Double {
        guard goalsCount > 0 else { return 0 }
        
        let calendar = Calendar.current
        var recordsByDay: [Date: Int] = [:]
        
        for record in records {
            let date = record.date
            let startOfDay = calendar.startOfDay(for: date)
            recordsByDay[startOfDay, default: 0] += 1
        }
        
        guard !recordsByDay.isEmpty else { return 0 }
        
        let totalDays = recordsByDay.count
        let totalRecords = records.count
        
        return Double(totalRecords) / Double(totalDays)
    }
    
}

