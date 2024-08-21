import Foundation
import CoreData
import SwiftUI

final class TrainingViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var coreMuscle: String = ""
    @Published var secondaryMuscles: String = ""
    @Published var desc: String = ""
    @Published var tag: String = ""
    @Published var tagColor: Color = .red
    @Published var id: UUID?
    
    @Published var trainings: [Training] = []
    
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
    
    func addTraining(alpha: Double, red: Double, green: Double, blue: Double) {
        let newTraining = Training(context: viewContext)
        newTraining.name = name
        newTraining.coreMuscle = coreMuscle
        newTraining.secondaryMuscles = secondaryMuscles
        newTraining.desc = desc
        newTraining.tag = tag
        newTraining.alpha = alpha
        newTraining.red = red
        newTraining.green = green
        newTraining.blue = blue
        newTraining.id = UUID()
        saveContext()
        resetFields()
    }
    
    private func resetFields() {
        name = ""
        coreMuscle = ""
        secondaryMuscles = ""
        desc = ""
        tag = ""
        tagColor = .red
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
