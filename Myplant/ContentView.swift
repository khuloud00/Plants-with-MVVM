import SwiftUI

struct ContentView: View {
    @StateObject private var plantViewModel = PlantViewModel() // تهيئة ViewModel
    @State private var isShowingTodayReminderSheet = false // للتحكم في عرض صفحة TodayReminder كـ sheet
    @State private var isShowingSplashScreen = true // متغير للتحكم في عرض شاشة المقدمة

    var body: some View {
        NavigationView {
            VStack {
                if isShowingSplashScreen {
                    // شاشة المقدمة
                    VStack {
                        Image("plany")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .padding()
                        
                        Text("Welcome  🌱")
                            .font(.system(.title, design: .rounded).weight(.bold)) // تعيين SF Pro مع خط عريض
                            .padding()
                            .foregroundColor(.gray)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                            withAnimation {
                                self.isShowingSplashScreen = false // إخفاء شاشة المقدمة بعد 4 ثوانٍ
                            }
                        }
                    }
                } else {
                    // عرض المحتوى الرئيسي للتطبيق بعد انتهاء المقدمة
                    if plantViewModel.plantReminders.isEmpty {
                        VStack {
                            Image("plany")
                                .resizable()
                                .frame(width: 132, height: 164)
                                .padding()
                            
                            Text("Start your plant journey!")
                                .font(.system(.title, design: .rounded)) // تعيين SF Pro
                                .padding()
                            
                            Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                                .font(.system(.body, design: .rounded)) // تعيين SF Pro للنصوص الأصغر
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            // زر لعرض صفحة TodayReminder
                            Button(action: {
                                isShowingTodayReminderSheet = true
                            }) {
                                Text("Set Plant Reminder")
                                    .font(.system(.body, design: .rounded).weight(.bold)) // تعيين SF Pro للزر مع خط عريض
                                    .foregroundColor(.black) // تغيير لون النص إلى الأسود
                                    .padding()
                                    .frame(width: 250, height: 50)
                                    .background(Color("green")) // استبدل "green" باسم اللون في الـ Assets
                                    .cornerRadius(10)
                            }
                            .padding()
                        }
                    } else {
                        TodayReminder(viewModel: plantViewModel)
                    }
                }
            }
            .sheet(isPresented: $isShowingTodayReminderSheet) {
                // استدعاء Set_Reminder لعرض واجهة إعداد تذكير جديد
                Set_Reminder(viewModel: plantViewModel)
            }
            .navigationTitle("My Plants 🌱")
            .font(.system(.body, design: .rounded)) // تعيين SF Pro كخط افتراضي لكل النصوص الأخرى
            Divider()
                .background(Color.black)
        }
    }
}

#Preview {
    ContentView()
}

