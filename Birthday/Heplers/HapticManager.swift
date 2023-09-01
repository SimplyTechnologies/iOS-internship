
import SwiftUI

final class HapticManager {
  
  static let shared = HapticManager()
  
  private init() {}
  
  func callHaptic(
    with notificationType: UINotificationFeedbackGenerator.FeedbackType,
    and impactStyle: UIImpactFeedbackGenerator.FeedbackStyle
  ) {
    let notification = UINotificationFeedbackGenerator()
    notification.notificationOccurred(notificationType)
    
    let impact = UIImpactFeedbackGenerator(style: impactStyle)
    impact.impactOccurred()
  }
  
}
