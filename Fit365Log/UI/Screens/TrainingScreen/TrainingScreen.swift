import SwiftUI

struct TrainingScreen: View {
    
    @EnvironmentObject var trainingViewModel: TrainingViewModel
    @State private var showNewTraining: Bool = false
    
    @State private var showAchievementCard: Bool = false
    @State private var animateCard: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 30) {
                    

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
        return !trainingViewModel.trainings.isEmpty
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
    
}

#Preview {
    TrainingScreen()
        .environmentObject(TrainingViewModel())
}
