import Foundation
import Combine

final class WorkoutViewModel: ObservableObject {
    @Published var workouts: [Workout] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private var cancellables = Set<AnyCancellable>()
    private let workoutService = WorkoutService()

    func fetchWorkouts() {
        isLoading = true
        workoutService.fetchWorkouts()
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Failed to load workouts: \(error.localizedDescription)"
                }
            }, receiveValue: { workouts in
                self.workouts = workouts
            })
            .store(in: &cancellables)
    }
}
