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
                        if hasUnread {
                            HStack {
                                Spacer()
                                // Has read button
                                Button("Markeren als gelezen") {
                                    notificationManager.markAllAsRead()
                                }
                                .font(.subheadline)
                                .foregroundColor(.black)
                            }
                            .padding(.trailing)
                        }
                    }
                    .padding(.top, 16)
                    
                    ForEach(notificationManager.notifications.filter { !$0.isRead }) { notif in
                        NotificationRow(
                            message: notif.message,
                            customName: notif.customName,
                            imageUrl: notif.imageUrl
                        )
                    }
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
