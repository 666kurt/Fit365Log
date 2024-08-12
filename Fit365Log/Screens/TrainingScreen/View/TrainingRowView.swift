import SwiftUI

struct TrainingRowStatsView: View {
    
    let value: String
    let name: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(value)
                .font(.title.weight(.bold))
                .foregroundColor(Color.theme.text.second)
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(maxWidth: 75)
            Text(name)
                .font(.subheadline)
                .foregroundColor(Color.theme.background.second)
        }
        .frame(maxWidth: .infinity)
    }
    
}

struct TrainingRowTimeView: View {
    
    let name: String
    let value: String
    
    var body: some View {
        HStack(spacing: 5) {
            Text(name)
                .font(.footnote)
                .foregroundColor(Color.theme.background.second)
            Text(value)
                .font(.callout.weight(.semibold))
                .foregroundColor(Color.theme.text.second)
                .lineLimit(1)
        }
    }
    
}


struct TrainingRowView: View {
    
    let training: Training
    
    var body: some View {
        VStack(spacing: 15) {
            
            Text(training.name)
                .font(.subheadline.weight(.semibold))
                .foregroundColor(Color.theme.text.main)
            
            HStack(spacing: 0) {
                TrainingRowStatsView(value: training.repetitions,
                                     name: "Repetitions")
                
                Spacer()
                
                TrainingRowStatsView(value: training.approaches,
                                     name: "Approaches")
                
                Spacer()
                
                TrainingRowStatsView(value: training.weight,
                                     name: "Weight")
            }
            
            HStack(spacing: 10) {
                TrainingRowTimeView(name: "Training time",
                                    value: training.trainingTime)
                TrainingRowTimeView(name: "Rest time",
                                    value: training.restTime)
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
        .padding(10)
        .background(Color.theme.background.light)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.bottom, 15)
        
    }
    
}

#Preview {
    
    let context = PersistenceController.preview.container.viewContext
    let sampleTraining = Training(context: context)
    sampleTraining.name = "Sample Training"
    sampleTraining.repetitions = "32"
    sampleTraining.approaches = "12"
    sampleTraining.weight = "666"
    sampleTraining.trainingTime = "12:12"
    sampleTraining.restTime = "14:48"
    sampleTraining.desc = "Description"
    
    return TrainingRowView(training: sampleTraining)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.theme.background.main)
}
