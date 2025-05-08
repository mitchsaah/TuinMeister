import SwiftUI
import FirebaseCore
import GoogleSignIn
import FBSDKCoreKit

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    
    // Initializes Facebook SDK
    ApplicationDelegate.shared.application(
        application,
        didFinishLaunchingWithOptions: launchOptions
    )
    return true
  }
    
    // Google sign-in callback
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        // Facebook SDK handler
        let handledByFB = ApplicationDelegate.shared.application(
            app,
            open: url,
            options: options
        )
        if handledByFB {
            return true
        }
        // If not handled by Facebook, it gets passed to Google sign-in
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct TuinMeisterApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppState.shared)
                .font(.custom("Poppins-Regular", size: 16))
        }
    }
}
