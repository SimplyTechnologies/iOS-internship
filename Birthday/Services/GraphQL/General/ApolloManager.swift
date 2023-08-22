
import Apollo
import Foundation

final class ApolloManager {
  
  static let shared = ApolloManager()
  
  let client: ApolloClient
  
  private init() {
    let cache = InMemoryNormalizedCache()
    let store = ApolloStore(cache: cache)
    let provider = DefaultInterceptorProvider(store: store)
    let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: RequestServices.API.baseUrl)
    client = ApolloClient(networkTransport: transport, store: store)
  }
  
}
