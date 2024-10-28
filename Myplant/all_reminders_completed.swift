import SwiftUI

struct all_reminders_completed: View {
    @ObservedObject var viewModel: AllRemindersCompletedViewModel
    @State private var isShowingSetReminderSheet = false

    var body: some View {
        VStack {
           // Text("My Plants 🌱")
               // .font(.largeTitle)
                //.fontWeight(.bold)
               // .padding()
              //  .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            
            VStack {
                Image("plant") // استبدل باسم صورتك
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 20)
                
                Text("All Done! 🎉")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Text("All Reminders Completed")
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    isShowingSetReminderSheet = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("New Reminder")
                    }
                    .font(.title2)
                    .foregroundColor(.green)
                }
                .padding(.leading)
                .sheet(isPresented: $isShowingSetReminderSheet) {
                    Set_Reminder(viewModel: viewModel.plantViewModel) // تمرير PlantViewModel بشكل صحيح
                }
                
                Spacer()
            }
            .padding(.bottom, 40)
        }
        .foregroundColor(.white)
    }
}

#Preview {
    let plantViewModel = PlantViewModel()
    let viewModel = AllRemindersCompletedViewModel(plantViewModel: plantViewModel)
    all_reminders_completed(viewModel: viewModel)
}

