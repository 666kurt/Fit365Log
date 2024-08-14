import SwiftUI

struct TrainingScreen: View {
    
    @EnvironmentObject var trainingViewModel: TrainingViewModel
    @State private var showNewTraining: Bool = false
    
    var body: some View {
        VStack {
            ToolBarView(label: hasAdd, action: { showNewTraining.toggle() })
            NavigationTitleView(title: "My training")
            
            
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
        .sheet(isPresented: $showNewTraining) {
            CustomSheet(title: "New workouts") {
                NewTrainingView()
                    .environmentObject(trainingViewModel)
            }
        }
        .onAppear {
            trainingViewModel.fetchTrainings()
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
}

#Preview {
    TrainingScreen()
        .environmentObject(TrainingViewModel())
}
