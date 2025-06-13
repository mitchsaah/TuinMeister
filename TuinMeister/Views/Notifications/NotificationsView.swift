import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct NotificationsView: View {
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Title
                    VStack(spacing: 16) {
                        Text("Meldingen")
                            .font(.title2)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.top, 16)
                }
                .padding(.bottom)
            }
            .onAppear {
                notificationManager.startListening()
            }
        }
    }
    
    private var hasUnread: Bool {
        notificationManager.notifications.contains { !$0.isRead }
    }

    private var hasRead: Bool {
        notificationManager.notifications.contains { $0.isRead }
    }
}
