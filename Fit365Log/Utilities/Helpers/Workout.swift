import Foundation

struct Workout: Identifiable, Decodable {
    
    let id: String
    let name: String
    let bodyPart: String
    let equipment: String
    let gifUrl: String
    let target: String
    let secondaryMuscles: [String]
    let instructions: [String]
    
}
