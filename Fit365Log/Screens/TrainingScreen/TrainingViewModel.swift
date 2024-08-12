import Foundation
import CoreData
import SwiftUI

final class TrainingViewModel: ObservableObject {
    
    @Published var trainings: [Training] = []
    
    @Published var name: String = ""
    @Published var repetitions: String = ""
    @Published var approaches: String = ""
    @Published var weight: String = ""
    @Published var trainingMinutes: Int = 0
    @Published var trainingSeconds: Int = 0
    @Published var restMinutes: Int = 0
    @Published var restSeconds: Int = 0
    @Published var desc: String = ""
    @Published var id: UUID?
    
    private let viewContext = PersistenceController.shared.container.viewContext
    
    init() {
        fetchTrainings()
    }
    
    func fetchTrainings() {
        let request: NSFetchRequest<Training> = Training.fetchRequest()
        do {
            trainings = try viewContext.fetch(request)
        } catch {
            print("Error fetching trainings: \(error)")
        }
    }
    
    func addTraining() {
        let newTraining = Training(context: viewContext)
        newTraining.name = name
        newTraining.repetitions = repetitions
        newTraining.approaches = approaches
        newTraining.weight = weight
        newTraining.trainingTime = formatTime(minutes: trainingMinutes, seconds: trainingSeconds)
        newTraining.restTime = formatTime(minutes: restMinutes, seconds: restSeconds)
        newTraining.desc = desc
        newTraining.id = UUID()
        saveContext()
        resetFields()
    }
    
    private func resetFields() {
        name = ""
        repetitions = ""
        approaches = ""
        weight = ""
        trainingMinutes = 0
        trainingSeconds = 0
        restMinutes = 0
        restSeconds = 0
        desc = ""
    }
    
    private func formatTime(minutes: Int, seconds: Int) -> String {
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func deleteAllTrainings() {
           let request: NSFetchRequest<NSFetchRequestResult> = Training.fetchRequest()
           let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
           
           do {
               try viewContext.execute(deleteRequest)
               try viewContext.save()
               fetchTrainings()
           } catch {
               print("Error deleting trainings: \(error)")
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
