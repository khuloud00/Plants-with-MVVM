import SwiftUI

class EditReminderViewModel: ObservableObject {
    @Published var plantReminder: PlantReminder // التذكير الذي سيتم تعديله
    private var viewModel: PlantViewModel // مرجع إلى PlantViewModel الرئيسي
    
    init(plantReminder: PlantReminder, viewModel: PlantViewModel) {
        self.plantReminder = plantReminder
        self.viewModel = viewModel
    }
    
    // دالة لتحديث التذكير في PlantViewModel
    func saveReminder() {
        viewModel.updateReminder(plantReminder)
    }
    
    // دالة لحذف التذكير من PlantViewModel باستخدام IndexSet
    func deleteReminder() {
        if let index = viewModel.plantReminders.firstIndex(where: { $0.id == plantReminder.id }) {
            viewModel.deleteReminder(at: IndexSet(integer: index))
        }
    }
}

