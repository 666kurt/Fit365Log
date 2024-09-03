import SwiftUI

struct HealthScreen: View {
    
    @EnvironmentObject var healthViewModel: HealthViewModel
    
    @State private var showTaskSheet: Bool = false
    @State private var showEditSheet: Bool = false
    @State private var isLandscape: Bool = false
    
    var body: some View {
        NavigationView {
            if isLandscape {
                ScrollView(showsIndicators: false) {
                    content
                        .orientationReader(isLandscape: $isLandscape)
                }
            } else {
                content
                    .orientationReader(isLandscape: $isLandscape)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .colorScheme(.light)
    }
    
}

extension HealthScreen {
    
    private var content: some View {
        VStack {
            staticticsView
            taskView
            
            if healthViewModel.tasks.isEmpty {
                taskTextView
            } else {
                taskListView
            }
        }
        .navigationTitle("My information")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showEditSheet.toggle()
                } label: {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $showTaskSheet) {
            taskSheet
        }
        .sheet(isPresented: $showEditSheet) {
            editSheet
        }
        .onAppear {
            healthViewModel.fetchTasks()
            healthViewModel.fetchHealthData()
        }
        .customVStackStyle()
    }
    
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
                HealthCardView(title: "Experience",
                               value: healthViewModel.experience.isEmpty ? "no data" : healthViewModel.experience)
            }
            
            
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("My horse")
                        .font(.title3.weight(.semibold))
                        .foregroundColor(Color.theme.text.second)
                    if let imageData = healthViewModel.myHorseImageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 154, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } else {
                        Image(systemName: "photo")
                            .frame(width: 154, height: 120)
                            .background(Color.theme.other.separator)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.theme.background.light)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Additional horse")
                        .font(.title3.weight(.semibold))
                        .foregroundColor(Color.theme.text.second)
                    if let imageData = healthViewModel.additionalHorseImageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 154, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } else {
                        Image(systemName: "photo")
                            .frame(width: 154, height: 120)
                            .background(Color.theme.other.separator)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.theme.background.light)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }

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
    
    private var taskSheet: some View {
        CustomSheet(title: "New tasks") {
            HealthTaskView()
                .environmentObject(healthViewModel)
        }
    }
    
    private var taskTextView: some View {
        Text("Write down your tasks and\naccomplish them")
            .font(.callout)
            .foregroundColor(Color.theme.text.notActive)
            .frame(maxHeight: .infinity)
            .multilineTextAlignment(.center)
    }
    
    private var taskListView: some View {
        ScrollView(showsIndicators: false) {
            ForEach(healthViewModel.tasks, id: \.id) { task in
                TaskRowView(title: task.title, action: {
                    healthViewModel.deleteTask(task: task)
                })
            }
        }
    }
    
    private var editSheet: some View {
        CustomSheet(title: "Edit") {
            HealthEditView()
                .environmentObject(healthViewModel)
        }
    }
}

#Preview {
    HealthScreen()
        .environmentObject(HealthViewModel())
}
