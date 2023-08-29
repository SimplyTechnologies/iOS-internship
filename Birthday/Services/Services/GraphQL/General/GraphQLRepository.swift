
import Apollo
import Combine
import Foundation

protocol GraphQLRepository { }

extension GraphQLRepository {
  
  func request<T: GraphQLQuery>(
    query: T,
    client: ApolloClient = ApolloManager.shared.client
  ) -> AnyPublisher<T.Data, Error> {
    return Future { promise in
      client.fetch(
        query: query,
        cachePolicy: .fetchIgnoringCacheCompletely
      ) { result in
        switch result {
        case .success(let response):
          do {
            guard let data = response.data else {
              if let graphQLError = response.errors?.first {
                return promise(.failure(graphQLError))
              }
              return promise(
                .failure(
                  GraphQLError.error(with: "Unknown error 400")
                )
              )
            }
            return promise(.success(data))
          }
        case .failure(let error):
          return promise(.failure(error))
        }
      }
    }
    .eraseToAnyPublisher()
  }
  
  func request<T: GraphQLMutation>(
    mutation: T,
    client: ApolloClient = ApolloManager.shared.client
  ) -> AnyPublisher<T.Data, Error> {
    
    return Future { promise in
      client.perform(mutation: mutation) { result in
        switch result {
        case .success(let response):
          do {
            guard let data = response.data, response.errors == nil else {
              print("asd response data: \(response.data), errors: \(response.errors?.first)")
              
              if let graphQLError = response.errors?.first {
                print("asd graphQLError", graphQLError)
                return promise(.failure(graphQLError))
              }
              
              return promise(
                .failure(
                  GraphQLError.error(with: "Unknown error 400")
                )
              )
            }
            print("asd success data: \(response.data), errors: \(response.errors)")
            return promise(.success(data))
          }
        case .failure(let error):
          print(error)
          return promise(.failure(error))
        }
      }
    }
    .eraseToAnyPublisher()
  }
  
}
