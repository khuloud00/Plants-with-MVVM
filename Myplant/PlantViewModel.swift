import SwiftUI
import Combine

class PlantViewModel: ObservableObject {
    @Published var plantReminders: [PlantReminder] = []
    
    // إضافة تذكير جديد
    func addReminder(_ reminder: PlantReminder) {
        plantReminders.append(reminder)
    }
    
    // دالة لتحديث تذكير معين
    func updateReminder(_ reminder: PlantReminder) {
        if let index = plantReminders.firstIndex(where: { $0.id == reminder.id }) {
            plantReminders[index] = reminder
        }
    }
    
    // دالة لحذف التذكير بناءً على IndexSet
    func deleteReminder(at offsets: IndexSet) {
        plantReminders.remove(atOffsets: offsets)
    }
    
    // دالة لتغيير حالة التحقق
    func toggleCheck(for reminder: PlantReminder) {
        if let index = plantReminders.firstIndex(where: { $0.id == reminder.id }) {
            plantReminders[index].isChecked.toggle()
        }
    }
    
    // خاصية للتحقق من اكتمال جميع التذكيرات
    var areAllRemindersCompleted: Bool {
        return plantReminders.allSatisfy { $0.isChecked }
    }
}

