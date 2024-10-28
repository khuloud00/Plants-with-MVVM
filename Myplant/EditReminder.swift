import SwiftUI

struct EditReminder: View {
    @ObservedObject var viewModel: EditReminderViewModel // استخدام EditReminderViewModel للتحكم في البيانات
    @Environment(\.presentationMode) var presentationMode // للتحكم في إغلاق الصفحة

    var body: some View {
        NavigationView {
            Form {
                // قسم اسم النبات مع التعديل
                Section {
                    HStack {
                        Text("Plant Name")
                        TextField("Enter plant name", text: $viewModel.plantReminder.plantName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }

                Section {
                    Picker("Room", selection: $viewModel.plantReminder.room) {
                        Text("Bedroom").tag("Bedroom")
                        Text("Living Room").tag("Living Room")
                        Text("Kitchen").tag("Kitchen")
                        Text("Balcony").tag("Balcony")
                        Text("Bathroom").tag("Bathroom")
                    }
                    
                    Picker("Light", selection: $viewModel.plantReminder.light) {
                        Text("Full sun").tag("Full sun")
                        Text("Partial sun").tag("Partial sun")
                        Text("Low light").tag("Low light")
                    }
                }

                Section {
                    Picker("Watering Days", selection: $viewModel.plantReminder.wateringDays) {
                        Text("Every day").tag("Every day")
                        Text("Every 2 days").tag("Every 2 days")
                        Text("Every 3 days").tag("Every 3 days")
                        Text("Once a week").tag("Once a week")
                        Text("Every 10 days").tag("Every 10 days")
                        Text("Every 2 weeks").tag("Every 2 weeks")
                    }
                    
                    Picker("Water Amount", selection: $viewModel.plantReminder.waterAmount) {
                        Text("20-50 ml").tag("20-50 ml")
                        Text("50-100 ml").tag("50-100 ml")
                        Text("100-150 ml").tag("100-150 ml")
                        Text("200-300 ml").tag("200-300 ml")
                    }
                }
                
                // زر الحذف
                Section {
                    Button(action: {
                        viewModel.deleteReminder() // حذف التذكير عبر ViewModel
                        presentationMode.wrappedValue.dismiss() // إغلاق الصفحة بعد الحذف
                    }) {
                        Text("Delete Reminder")
                            .foregroundColor(.pink) // لون النص
                            .frame(maxWidth: .infinity) // لجعل الزر يمتد بالكامل
                            .padding()
                            .background(Color.black.opacity(0.8)) // خلفية داكنة مع شفافية
                            .cornerRadius(10) // زوايا منحنية
                    }
                }
            }
            .navigationBarTitle("Edit Reminder", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss() // إغلاق الشاشة عند النقر على "Cancel"
                    }
                    .foregroundColor(Color("green")) // استبدل "YourCancelColor" باسم اللون في الـ Assets
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.saveReminder() // حفظ التغييرات في ViewModel
                        presentationMode.wrappedValue.dismiss() // إغلاق الشاشة بعد الحفظ
                    }
                    .foregroundColor(Color("green")) // استبدل "YourSaveColor" باسم اللون في الـ Assets
                }
            }
        }
    }
}

#Preview {
    // استخدام PlantViewModel في المعاينة
    let sampleReminder = PlantReminder(plantName: "Rose", room: "Living Room", wateringDays: "Every day", waterAmount: "50-100 ml", light: "Full sun")
    let plantViewModel = PlantViewModel()
    plantViewModel.addReminder(sampleReminder)
    return EditReminder(viewModel: EditReminderViewModel(plantReminder: sampleReminder, viewModel: plantViewModel))
}

