import SwiftUI

class AllRemindersCompletedViewModel: ObservableObject {
    @Published var plantViewModel: PlantViewModel
    
    init(plantViewModel: PlantViewModel) {
        self.plantViewModel = plantViewModel
    }
    
    // دالة لإضافة تذكير جديد
    func addNewReminder() {
        print("New Reminder Added") // يمكنك وضع منطق إضافة تذكير جديد هنا
    }
}

