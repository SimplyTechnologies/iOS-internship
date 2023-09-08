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
    textField.keyboardType = .numberPad
    textField.addDoneCancelToolbar()
    
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
      parent.text = textField.text ?? ""
    }
    
  }
  
}


extension UITextField {
  
  func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
    let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
    let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
    
    let toolbar: UIToolbar = UIToolbar()
    toolbar.barStyle = .default
    toolbar.items = [
      UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
      UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
      UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
    ]
    toolbar.sizeToFit()
    
    self.inputAccessoryView = toolbar
  }
  
  // Default actions:
  @objc func doneButtonTapped() { self.resignFirstResponder() }
  @objc func cancelButtonTapped() { self.resignFirstResponder() }
  
}
