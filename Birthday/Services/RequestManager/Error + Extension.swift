
import Apollo

extension Error {
  
  static func error(with message: String) -> GraphQLError {
    return GraphQLError(["message": message])
  }
  
}
