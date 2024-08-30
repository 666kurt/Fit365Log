import SwiftUI

struct TimePickerSheet: View {
    @Binding var minutes: Int
    @Binding var seconds: Int
    var onDismiss: () -> Void
    
    private let minuteOptions = Array(0...59)
    private let secondOptions = Array(0...59)
    
    var body: some View {
        
        VStack {
           Text("Select time")
                .foregroundColor(Color.theme.text.main)
                .font(.headline)
                .padding(.vertical, 20)
            
            HStack {
                Picker("Minutes", selection: $minutes) {
                    ForEach(minuteOptions, id: \.self) { minute in
                        Text(String(format: "%02d", minute)).tag(minute)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                
                Picker("Seconds", selection: $seconds) {
                    ForEach(secondOptions, id: \.self) { second in
                        Text(String(format: "%02d", second)).tag(second)
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
            .preferredColorScheme(.dark)
            .padding()
        }
        .customVStackStyle()
        
    }
}
