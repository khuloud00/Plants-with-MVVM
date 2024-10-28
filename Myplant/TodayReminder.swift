import SwiftUI

struct TodayReminder: View {
    @ObservedObject var viewModel: PlantViewModel
    @State private var isShowingSetReminderSheet = false
    @State private var isShowingEditReminderSheet = false
    @State private var selectedReminder: PlantReminder?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Today")
                .font(.title2)
                .bold()
                .padding(.leading)
                .padding(.top, 5)
            
            List {
                // ترتيب التذكيرات بحيث تأتي التذكيرات غير المكتملة أولاً
                ForEach(viewModel.plantReminders.sorted(by: { !$0.isChecked && $1.isChecked })) { plant in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: plant.isChecked ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(plant.isChecked ? .green : .gray)
                                .onTapGesture {
                                    viewModel.toggleCheck(for: plant)
                                }
                            
                            VStack(alignment: .leading) {
                                // عرض أيقونة "room" ونص الغرفة فوق اسم النبات
                                HStack(spacing: 4) {
                                    Image(systemName: "paperplane")
                                    Text("in \(plant.room)")
                                }
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                
                                Text(plant.plantName)
                                    .font(.headline)
                                    .foregroundColor(plant.isChecked ? .gray : .primary) // لون رمادي عند اكتمال التذكير
                            }
                        }
                        
                        HStack(spacing: 4) {
                            Image(systemName: "sun.max")
                                .foregroundColor(Color("Color")) // استبدل "Color" بلون الشمس من الـ Assets
                            Text(plant.light)
                            
                            Image(systemName: "drop")
                                .foregroundColor(Color("blue")) // استبدل "blue" بلون الماء من الـ Assets
                            Text(plant.waterAmount)
                        }
                        .font(.subheadline)
                    }
                    .padding()
                    .background(plant.isChecked ? Color.gray.opacity(0.2) : Color.clear) // خلفية رمادية على جميع محتويات التذكير عند اكتماله
                    .cornerRadius(8) // لجعل التضليل ذو حواف مستديرة
                    .onTapGesture {
                        selectedReminder = plant
                        isShowingEditReminderSheet = true
                    }
                }
                .onDelete(perform: viewModel.deleteReminder)
            }
            
            Spacer()
            
            Button(action: {
                isShowingSetReminderSheet = true
            }) {
                Label("New Reminder", systemImage: "plus.circle.fill")
                    .foregroundColor(Color("green")) // استبدل "green" بالاسم الفعلي للون في الـ Assets
                    .padding()
            }
            .sheet(isPresented: $isShowingSetReminderSheet) {
                Set_Reminder(viewModel: viewModel)
            }
            .sheet(item: $selectedReminder) { reminder in
                EditReminder(viewModel: EditReminderViewModel(plantReminder: reminder, viewModel: viewModel))
            }
            
            // التنقل إلى صفحة all_reminders_completed عند اكتمال جميع التذكيرات
            NavigationLink(
                destination: all_reminders_completed(viewModel: AllRemindersCompletedViewModel(plantViewModel: viewModel)),
                isActive: .constant(viewModel.areAllRemindersCompleted)
            ) {
                EmptyView() // عنصر خفي للتنقل الشرطي
            }
        }
        .padding()
    }
}

#Preview {
    TodayReminder(viewModel: PlantViewModel())
}

