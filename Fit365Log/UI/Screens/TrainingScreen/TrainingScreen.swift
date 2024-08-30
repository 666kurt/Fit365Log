import SwiftUI

struct TrainingScreen: View {
    
    @EnvironmentObject var trainingViewModel: TrainingViewModel
    @StateObject var workoutViewModel = WorkoutViewModel()
    @State private var showNewTraining: Bool = false
    @State private var selectedControl: Int = 0
    
    @State private var showAchievementCard: Bool = false
    @State private var animateCard: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 30) {
                    
                    trainingPicker
                    
                    if selectedControl == 0 {
                        workoutList
                    } else {
                        if trainingViewModel.trainings.isEmpty {
                            trainingEmptyView
                        } else {
                            ScrollView(showsIndicators: false) {
                                LazyVStack(spacing: 15) {
                                    ForEach(trainingViewModel.trainings, id: \.id) { training in
                                        TrainingRowView(training: training)
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("My Training")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showNewTraining.toggle()
                        } label: {
                            Text(hasAdd)
                        }
                    }
                }
                .sheet(isPresented: $showNewTraining, onDismiss: {
                    handleAchievementDisplay()
                }) {
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
                
                if showAchievementCard {
                    AchievementView()
                        .offset(x: animateCard ? UIScreen.main.bounds.width / 2 - 40 : 0,
                                y: animateCard ? UIScreen.main.bounds.height / 2 - 40 : 0)
                        .opacity(animateCard ? 0.0 : 1.0)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .colorScheme(.light)
    }
    
    private var hasAdd: String {
        return (!trainingViewModel.trainings.isEmpty && selectedControl == 1)
        ? "Add"
        : ""
    }
    
    private func handleAchievementDisplay() {
        let today = Calendar.current.startOfDay(for: Date())
        
        if trainingViewModel.lastAchievementDate != today {
            withAnimation(.easeInOut(duration: 1.0)) {
                showAchievementCard = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    animateCard = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showAchievementCard = false
                        animateCard = false
                        trainingViewModel.lastAchievementDate = today
                    }
                }
            }
        }
    }}

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
                    .foregroundColor(Color(hex: "#FAFAFA"))
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
        .onAppear {
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.theme.other.primary)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.white), .font: UIFont.boldSystemFont(ofSize: 13)], for: .selected)
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
                LazyVStack(spacing: 15) {
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
