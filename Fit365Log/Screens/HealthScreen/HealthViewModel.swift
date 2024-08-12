import Foundation
import CoreData
import SwiftUI

final class HealthViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var taskLabel: String = ""
    
    @Published var name: String = ""
    @Published var age: String = ""
    @Published var weight: String = ""
    @Published var height: String = ""
    @Published var waist: String = ""
    @Published var heartRate: String = ""
    @Published var caloriesPerDay: String = ""
    @Published var diseases: String = ""
    
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
                name = data.name
                age = data.age
                weight = data.weight
                height = data.height
                waist = data.waist
                heartRate = data.heartRate
                caloriesPerDay = data.calories
                diseases = data.diseases
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
            
            data.name = name
            data.age = age
            data.weight = weight
            data.height = height
            data.waist = waist
            data.heartRate = heartRate
            data.calories = caloriesPerDay
            data.diseases = diseases
            
            try viewContext.save()
        } catch {
            print("Error saving health data: \(error)")
        }
    }
    
    func deleteAllData() {
            let taskFetchRequest: NSFetchRequest<NSFetchRequestResult> = Task.fetchRequest()
            let taskDeleteRequest = NSBatchDeleteRequest(fetchRequest: taskFetchRequest)
            
            let healthDataFetchRequest: NSFetchRequest<NSFetchRequestResult> = HealthData.fetchRequest()
            let healthDataDeleteRequest = NSBatchDeleteRequest(fetchRequest: healthDataFetchRequest)
            
            do {
                try viewContext.execute(taskDeleteRequest)
                try viewContext.execute(healthDataDeleteRequest)
                
                try viewContext.save()
                viewContext.reset()
                
                fetchTasks()
                fetchHealthData()
            } catch {
                print("Error deleting all data: \(error)")
            }
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
