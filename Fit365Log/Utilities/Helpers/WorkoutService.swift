import Foundation
import Combine

final class WorkoutService {
    private let baseURL = "https://exercisedb.p.rapidapi.com/exercises?limit=20&offset=0"
    private let apiKey = "6fdf0c64damsh30297f1cda2d674p1c6239jsn6e0ba281794a"
    private let apiHost = "exercisedb.p.rapidapi.com"

    func fetchWorkouts() -> AnyPublisher<[Workout], Error> {
        guard let url = URL(string: baseURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue(apiHost, forHTTPHeaderField: "x-rapidapi-host")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Workout].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
