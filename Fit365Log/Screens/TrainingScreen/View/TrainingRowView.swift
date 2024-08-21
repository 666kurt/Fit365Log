import SwiftUI

struct TrainingRowStatsView: View {
    
    let value: String
    let name: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(name)
                .font(.subheadline)
                .foregroundColor(Color.theme.background.second)
                .lineLimit(1)
            
            Text(value)
                .font(.title3.weight(.semibold))
                .foregroundColor(Color.theme.text.second)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
    }
    
}

struct TrainingRowView: View {
    
    let training: Training
    
    var body: some View {
        VStack(spacing: 15) {
            
            
            HStack {
                Text(training.name)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(Color.theme.text.main)
                    .frame(maxWidth: UIScreen.main.bounds.width / 2 - 50, alignment: .leading)
                    .lineLimit(1)
                
                Spacer()
                
                Text("#\(training.tag)")
                    .font(.headline)
                    .foregroundColor(Color(red: training.red, green: training.green, blue: training.blue))
                    .frame(maxWidth: UIScreen.main.bounds.width / 2 - 50, alignment: .trailing)
                    .lineLimit(1)
            }
            
            HStack(spacing: 0) {
                TrainingRowStatsView(value: training.coreMuscle,
                                     name: "Core muscle")
                
                Spacer()
                Rectangle()
                    .frame(width: 1, height: 52)
                    .foregroundColor(Color.theme.background.second)
                Spacer()
                
                TrainingRowStatsView(value: training.secondaryMuscles,
                                     name: "Secondary muscles")
                
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Description")
                    .font(.callout.weight(.semibold))
                    .foregroundColor(Color.theme.text.main)
                Text(training.desc)
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

#Preview {
    
    let context = PersistenceController.preview.container.viewContext
    let sampleTraining = Training(context: context)
    sampleTraining.name = "Pull-push +legs"
    sampleTraining.tag = "cardio"
    sampleTraining.coreMuscle = "Gluteus maximus"
    sampleTraining.secondaryMuscles = "Calf muscle"
    sampleTraining.desc = "Description"
    sampleTraining.red = 0
    sampleTraining.green = 240
    sampleTraining.blue = 0
    
    return TrainingRowView(training: sampleTraining)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.theme.background.main)
}
