import SwiftUI

struct TrainingScreen: View {
    
    @EnvironmentObject var trainingViewModel: TrainingViewModel
    @StateObject var workoutViewModel = WorkoutViewModel()
    @State private var showNewTraining: Bool = false
    @State private var selectedControl: Int = 0
    
    var body: some View {
        VStack {
            ToolBarView(label: hasAdd, action: { showNewTraining.toggle() })
            NavigationTitleView(title: "My training")
            
            trainingPicker
            
            if selectedControl == 0 {
                workoutList
            } else {
                if trainingViewModel.trainings.isEmpty {
                    trainingEmptyView
                } else {
                    ScrollView(showsIndicators: false) {
                        ForEach(trainingViewModel.trainings, id: \.id) { training in
                            TrainingRowView(training: training)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showNewTraining) {
            CustomSheet(title: "New workouts") {
                NewTrainingView()
                    .environmentObject(trainingViewModel)
            }
        }
        .onAppear {
            trainingViewModel.fetchTrainings()
            workoutViewModel.fetchWorkouts()
        }
        .customVStackStyle()
    }
    
    private var hasAdd: String {
        return !trainingViewModel.trainings.isEmpty ? "Add" : ""
    }
    
}

extension TrainingScreen {
    private var trainingEmptyView: some View {
        VStack(spacing: 10) {
            Text("Your workouts")
                .font(.title.weight(.bold))
                .foregroundColor(Color.theme.text.main)
            Text("Record your workouts, set new\ngoals for yourself")
                .font(.subheadline)
                .foregroundColor(Color.theme.text.notActive)
                .multilineTextAlignment(.center)
            Button {
                showNewTraining.toggle()
            } label: {
                Text("Add")
                    .font(.body.weight(.bold))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 100)
                    .foregroundColor(Color.theme.text.main)
                    .background(Color.theme.other.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            }
        }
        .frame(maxHeight: .infinity)
    }
    
    private var trainingPicker: some View {
        Picker("", selection: $selectedControl) {
            Text("Training").tag(0)
            Text("Own training").tag(1)
        }
        .padding(2)
        .background(Color.white.opacity(0.25))
        .clipShape(RoundedRectangle(cornerRadius: 9))
        .pickerStyle(.segmented)
        .padding(.bottom, 20)
        .onAppear {
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.theme.other.primary)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.theme.text.main), .font: UIFont.boldSystemFont(ofSize: 13)], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.theme.text.main), .font: UIFont.boldSystemFont(ofSize: 13)], for: .normal)
        }
    }
    
    private var workoutList: some View {
        ScrollView(showsIndicators: false) {
            if workoutViewModel.isLoading {
                ProgressView("Loading workouts...")
                    .foregroundColor(Color.theme.other.primary)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.theme.other.primary))
            } else if let errorMessage = workoutViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                LazyVStack {
                    ForEach(workoutViewModel.workouts) { workout in
                        WorkoutRowView(workout: workout)
                    }
                }
            }
        }
    }
}

#Preview {
    TrainingScreen()
        .environmentObject(TrainingViewModel())
}
