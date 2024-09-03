import Foundation
import SwiftUI
import CoreData

final class HealthViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var taskLabel: String = ""
    
    @Published var age: String = ""
    @Published var weight: String = ""
    @Published var height: String = ""
    @Published var experience: String = ""
    
    @Published var myHorseImageData: Data? = nil
    @Published var additionalHorseImageData: Data? = nil
    
    private let viewContext = PersistenceController.shared.container.viewContext
    
    init() {
        fetchTasks()
        fetchHealthData()
    }
    
    // MARK: - Tasks
    func fetchTasks() {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            tasks = try viewContext.fetch(request)
        } catch {
            print("Error fetching tasks: \(error)")
        }
    }
    
    func addTask() {
        let newTask = Task(context: viewContext)
        newTask.title = taskLabel
        newTask.id = UUID()
        saveContext()
        taskLabel = ""
    }
    
    func deleteAllTasks() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Task.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(deleteRequest)
            viewContext.reset()
            
            fetchTasks()
            
        } catch {
            print("Error deleting all tasks: \(error)")
        }
    }
    
    
    
    func deleteTask(task: Task) {
        viewContext.delete(task)
        saveContext()
    }
    
    // MARK: - Health Data
    func fetchHealthData() {
        let request: NSFetchRequest<HealthData> = HealthData.fetchRequest()
        do {
            let healthData = try viewContext.fetch(request)
            if let data = healthData.first {
                self.age = data.age
                self.weight = data.weight
                self.height = data.height
                self.experience = data.experience
                self.myHorseImageData = data.horseImage
                self.additionalHorseImageData = data.additionalImage
            }
        } catch {
            print("Error fetching user health: \(error)")
        }
    }
    
    func saveUserHealth() {
        let request: NSFetchRequest<HealthData> = HealthData.fetchRequest()
        do {
            let healthData = try viewContext.fetch(request)
            let data = healthData.first ?? HealthData(context: viewContext)
            
            data.age = age
            data.weight = weight
            data.height = height
            data.experience = experience
            data.horseImage = myHorseImageData
            data.additionalImage = additionalHorseImageData
            
            try viewContext.save()
        } catch {
            print("Error saving health data: \(error)")
        }
    }
    
    func deleteUserData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = HealthData.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(deleteRequest)
            viewContext.reset()
            
            age = ""
            weight = ""
            height = ""
            experience = ""
            myHorseImageData = nil
            additionalHorseImageData = nil
            
            fetchHealthData()
        } catch {
            print("Error deleting user data: \(error)")
        }
    }
    
    // MARK: - Image Selection
    func handleImageSelection(image: UIImage) {
        myHorseImageData = image.jpegData(compressionQuality: 1.0)
    }

    func handleImageSelection2(image: UIImage) {
        additionalHorseImageData = image.jpegData(compressionQuality: 1.0)
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
            fetchTasks()
            fetchHealthData()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
