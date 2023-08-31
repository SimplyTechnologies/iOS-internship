
extension TextFieldModel: Equatable {
  
  static func == (lhs: TextFieldModel, rhs: TextFieldModel) -> Bool {
    return lhs.text == rhs.text
  }
  
}
