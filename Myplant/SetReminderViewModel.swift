import SwiftUI

class SetReminderViewModel: ObservableObject {
    @Published var plantReminder: PlantReminder // بيانات التذكير المؤقتة التي سيتم إضافتها
    @Published var plantReminders: [PlantReminder] // قائمة التذكيرات الأصلية
    
    init(plantReminders: [PlantReminder]) {
        self.plantReminders = plantReminders
        self.plantReminder = PlantReminder(plantName: "", room: "Bedroom", wateringDays: "Every day", waterAmount: "20-50 ml", light: "Full sun")
    }
    
    // دالة لحفظ التذكير الجديد في القائمة
    func saveReminder() {
        plantReminders.append(plantReminder)
    }
    
    // دالة للإلغاء
    func cancel() {
        // هنا يمكن تنفيذ أي منطق عند الإلغاء إذا لزم الأمر
    }
}

