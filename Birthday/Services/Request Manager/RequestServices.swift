
import Foundation

enum RequestServices {
  
  enum GraphQL {
    
    struct API {
      
      static let baseUrl: URL = URL(string: "https://simply-mobile.amiryan.online/graphql")!
      static let apiQueue: DispatchQueue = .init(
        label: "org.github.api",
        qos: .default,
        attributes: .concurrent
      )
    }
    
  }
  
}
