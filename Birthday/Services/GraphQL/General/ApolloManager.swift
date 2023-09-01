
import Apollo
import Foundation

final class ApolloManager {
  
  static let shared = ApolloManager()
  
  let client: ApolloClient
  
  private init() {
    let cache = InMemoryNormalizedCache()
    let store = ApolloStore(cache: cache)
    let provider = NetworkInterceptorProvider(store: store)
    let transport = RequestChainNetworkTransport(
      interceptorProvider: provider,
      endpointURL: RequestServices.API.baseUrl
    )
    client = ApolloClient(
      networkTransport: transport,
      store: store
    )
  }
  
}

class NetworkInterceptorProvider: DefaultInterceptorProvider {
  
  override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
    var interceptors = super.interceptors(for: operation)
    
    let token: String = StoreManager.shared.getStringObject(for: UserDefaultsKeys.token.rawValue)
    
    interceptors.insert(TokenInterceptor(token: token), at: 0)
    
    return interceptors
  }
}

class TokenInterceptor: ApolloInterceptor {
  
  private let token: String
  
  init(token: String) {
    self.token = token
  }
  
  func interceptAsync<Operation: GraphQLOperation>(
    chain: RequestChain,
    request: HTTPRequest<Operation>,
    response: HTTPResponse<Operation>?,
    completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
  ) {
    request.addHeader(
      name: "Authorization",
      value: "Bearer \(token)"
    )
    chain.proceedAsync(
      request: request,
      response: response,
      completion: completion
    )
  }
}
