import Foundation
import CoreData
import SwiftUI

final class TrainingViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var desc: String = ""
    @Published var tag: String = ""
    @Published var tagColor: Color = .red
    @Published var category: String = ""
    @Published var id: UUID?
    
    @Published var lastAchievementDate: Date? {
        didSet {
            if let date = lastAchievementDate {
                UserDefaults.standard.set(date, forKey: "lastAchievementDate")
            }
        }
    }
    
    @Published var trainings: [Training] = []
    
    private let viewContext = PersistenceController.shared.container.viewContext
    
    init() {
        fetchTrainings()
        loadLastAchievementDate()
    }
    
    func fetchTrainings() {
        let request: NSFetchRequest<Training> = Training.fetchRequest()
        do {
            trainings = try viewContext.fetch(request)
        } catch {
            print("Error fetching trainings: \(error)")
        }
    }
    
    func addTraining(alpha: Double, red: Double, green: Double, blue: Double) {
        let newTraining = Training(context: viewContext)
        newTraining.name = name
        newTraining.desc = desc
        newTraining.tag = tag
        newTraining.alpha = alpha
        newTraining.red = red
        newTraining.green = green
        newTraining.blue = blue
        newTraining.id = UUID()
        newTraining.date = Date()
        newTraining.category = category
        saveContext()
        resetFields()
    }
    
    private func resetFields() {
        name = ""
        desc = ""
        tag = ""
        category = ""
        tagColor = .red
    }
    
    func deleteAllTrainings() {
        let request: NSFetchRequest<NSFetchRequestResult> = Training.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
            self.lastAchievementDate = nil
            fetchTrainings()
        } catch {
            print("Error deleting trainings: \(error)")
        }
    }
    
    func consecutiveTrainingDays() -> Int {
        let sortedTrainings = trainings.compactMap { $0.date }.sorted(by: { $0 > $1 })
        
        guard let mostRecentDate = sortedTrainings.first else {
            return 0
        }
        
        var consecutiveDays = 0
        var currentDate = mostRecentDate
        
        for date in sortedTrainings {
            if Calendar.current.isDate(date, inSameDayAs: currentDate) {
                continue
            }
            
            if Calendar.current.isDate(date, inSameDayAs: Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!) {
                consecutiveDays += 1
                currentDate = date
            } else {
                break
            }
        }
        
        return consecutiveDays + 1
    }
    
    private func loadLastAchievementDate() {
        if let savedDate = UserDefaults.standard.object(forKey: "lastAchievementDate") as? Date {
            lastAchievementDate = savedDate
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
            fetchTrainings()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
