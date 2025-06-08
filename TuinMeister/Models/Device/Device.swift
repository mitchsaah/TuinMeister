import Foundation

struct Device: Identifiable, Hashable {
    let id: String 
    let customName: String
    let imageUrl: String
    let deviceName: String
    let plantDate: Date
}
