import SwiftUI

struct HealthScreen: View {
    
    @EnvironmentObject var healthViewModel: HealthViewModel
    
    @State private var showTaskSheet: Bool = false
    @State private var showEditSheet: Bool = false
    
    var body: some View {
            VStack {
                ToolBarView(label: "Edit", action: { showEditSheet.toggle() })
                NavigationTitleView(title: "My Health")
                
                ScrollView(showsIndicators: false) {
                staticticsView
                
                taskView
                
                if healthViewModel.tasks.isEmpty {
                    Text("Write down your tasks and\naccomplish them")
                        .font(.callout)
                        .foregroundColor(Color.theme.text.notActive)
                        .frame(maxHeight: .infinity)
                        .multilineTextAlignment(.center)
                } else {
                    ScrollView(showsIndicators: false) {
                        ForEach(healthViewModel.tasks, id: \.id) { task in
                            TaskRowView(title: task.title, action: {
                                healthViewModel.deleteTask(task: task)
                            })
                        }
                    }
                }
                
            }
        }
        .sheet(isPresented: $showTaskSheet) {
            CustomSheet(title: "New tasks") {
                HealthTaskView()
                    .environmentObject(healthViewModel)
            }
        }
        .sheet(isPresented: $showEditSheet) {
            CustomSheet(title: "Edit") {
                HealthEditView(name: $healthViewModel.name,
                               age: $healthViewModel.age,
                               weight: $healthViewModel.weight,
                               height: $healthViewModel.height,
                               waist: $healthViewModel.waist,
                               heartRate: $healthViewModel.heartRate,
                               caloriesPerDay: $healthViewModel.caloriesPerDay,
                               diseases: $healthViewModel.diseases, onSave: {
                    healthViewModel.saveUserHealth()
                })
                    .environmentObject(healthViewModel)
            }
        }
        .onAppear {
            healthViewModel.fetchTasks()
            healthViewModel.fetchHealthData()
        }
        .customVStackStyle()
    }
}

extension HealthScreen {
    
    private var staticticsView: some View {
        VStack(spacing: 16) {
            HStack(spacing: 10) {
                HealthCardView(title: "Age",
                               value: healthViewModel.age.isEmpty ? "no data" : healthViewModel.age)
                HealthCardView(title: "Weight",
                               value: healthViewModel.weight.isEmpty ? "no data" : healthViewModel.weight)
            }
            HStack(spacing: 10) {
                HealthCardView(title: "Height",
                               value: healthViewModel.height.isEmpty ? "no data" : healthViewModel.height)
                HealthCardView(title: "Waist",
                               value: healthViewModel.waist.isEmpty ? "no data" : healthViewModel.waist)
            }
            HStack(spacing: 10) {
                HealthCardView(title: "Heart rate",
                               value: healthViewModel.heartRate.isEmpty ? "no data" : healthViewModel.heartRate)
                HealthCardView(title: "Calories per day",
                               value: healthViewModel.caloriesPerDay.isEmpty ? "no data" : healthViewModel.caloriesPerDay)
            }
            HealthCardView(title: "Diseases",
                           value: healthViewModel.diseases.isEmpty ? "no data" : healthViewModel.diseases)
        }
    }

    
    private var taskView: some View {
        HStack {
            Text("Tasks")
            Spacer()
            Button {
                showTaskSheet.toggle()
            } label: {
                Image(systemName: "plus")
            }
        }
        .font(.title3.weight(.semibold))
        .foregroundColor(Color.theme.text.main)
        .padding(.vertical, 15)
    }
    
}

#Preview {
    HealthScreen()
        .environmentObject(HealthViewModel())
}
