
import SwiftUI

final class HapticManager {
  
  static let shared = HapticManager()
  
  private init() {}
  
//  func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
//    let generator = UINotificationFeedbackGenerator()
//    generator.notificationOccurred(type)
//  }
//
//  func haptic(style: UIImpactFeedbackGenerator.FeedbackStyle) {
//    let generator = UIImpactFeedbackGenerator(style: style)
//    generator.impactOccurred()
//  }
  
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
