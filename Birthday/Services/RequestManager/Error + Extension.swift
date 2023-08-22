
import Apollo

extension Error {
  
  static func error(with message: String) -> GraphQLError {
    GraphQLError(["message": message])
  }
  
}
