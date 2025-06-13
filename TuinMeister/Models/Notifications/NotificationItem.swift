import Foundation

struct NotificationItem: Identifiable {
    let id: String
    let message: String
    let isRead: Bool
    let customName: String
    let imageUrl: String
}
