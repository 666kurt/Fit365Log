import SwiftUI

struct WorkoutRowStatsView: View {
    
    let value: String
    let name: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(name)
                .font(.subheadline)
                .foregroundColor(Color.theme.background.second)
            
            Text(value)
                .font(.title3.weight(.semibold))
                .foregroundColor(Color.theme.text.second)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
    }
    
}

struct WorkoutRowView: View {
    
    let workout: Workout
    
    var body: some View {
        VStack(spacing: 15) {
            
            
            HStack {
                Text(workout.name)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(Color.theme.text.main)
                
                Spacer()
                
                Text("#\(workout.bodyPart)")
                    .font(.headline)
                    .foregroundColor(Color(hex: "#3EAF49"))
            }
            
            HStack(spacing: 0) {
                TrainingRowStatsView(value: workout.target,
                                     name: "Core muscle")
                
                Spacer()
                Rectangle()
                    .frame(width: 1, height: 52)
                    .foregroundColor(Color.theme.background.second)
                Spacer()
                
                TrainingRowStatsView(value: workout.secondaryMuscles[0],
                                     name: "Secondary muscles")
                
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Instructions")
                    .font(.callout.weight(.semibold))
                    .foregroundColor(Color.theme.text.main)
                Text(workout.instructions[0])
                    .lineLimit(2)
                    .font(.footnote)
                    .foregroundColor(Color.theme.background.second)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(15)
        .background(Color.theme.background.light)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.bottom, 15)
        
    }
    
}
