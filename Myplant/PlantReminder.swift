
import Foundation


// نموذج البيانات لتمثيل بيانات التذكير بالنبات
struct PlantReminder: Identifiable {
    var id = UUID() // معرف فريد للتذكير
    var plantName: String
    var room: String
    var wateringDays: String
    var waterAmount: String
    var light: String
    var isChecked: Bool = false
}
