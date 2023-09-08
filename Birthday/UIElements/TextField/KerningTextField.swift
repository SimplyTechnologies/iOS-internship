
import SwiftUI

struct KerningTextField: UIViewRepresentable {
  
  @Binding var text: String
  var placeholder: String
  var kerning: CGFloat
  
  func makeUIView(context: Context) -> UITextField {
    let textField = UITextField()
    textField.delegate = context.coordinator
    textField.textAlignment = .center
    textField.font = UIFont.init(name: Font.Karma.bold.rawValue, size: 18)
    textField.placeholder = placeholder
    textField.textColor = UIColor(Color.primaryColor)
    
    return textField
  }
  
  func updateUIView(_ uiView: UITextField, context: Context) {
    uiView.text = text
    let attributedText = NSAttributedString(
      string: text, attributes: [NSAttributedString.Key.kern: kerning]
    )
    uiView.attributedText = attributedText
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, UITextFieldDelegate {
    
    var parent: KerningTextField
    
    init(_ parent: KerningTextField) {
      self.parent = parent
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
      parent.text = textField.text ?? .emptyString
    }
  }
  
}
