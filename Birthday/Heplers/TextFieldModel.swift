
struct TextFieldModel {
  
  var text: String = .emptyString
  var errorMessage: String = .emptyString
  
}

extension TextFieldModel {
  
  static func == (lhs: TextFieldModel, rhs: TextFieldModel) -> Bool {
    lhs.text == rhs.text
  }
  
}
