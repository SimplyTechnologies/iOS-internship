
extension RegisterTextFieldModel: Equatable {
  
  static func == (lhs: RegisterTextFieldModel, rhs: RegisterTextFieldModel) -> Bool {
    return lhs.text == rhs.text
  }
  
}
