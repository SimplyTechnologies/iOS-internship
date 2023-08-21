//
//  GraphQLRepository.swift
//  Birthday
//
//  Created by Edgar Arakelyan on 17.08.23.
//

import Combine
import Apollo
import Foundation

protocol GraphQLRepository { }

extension GraphQLRepository {
    func request<T: GraphQLQuery>(query: T, client: ApolloClient = ApolloManager.shared.client, queue: DispatchQueue = RequestServices.GraphQL.API.apiQueue) -> AnyPublisher<T.Data, Error> {
        return Future { promise in
            client.fetch(query: query, cachePolicy: .fetchIgnoringCacheCompletely, queue: queue) { result in
                switch result {
                case .success(let response):
                    do {
                        guard let data = response.data else {
                            if let graphQLError = response.errors?.first {
                                return promise(.failure(RequestServiceError(graphQLError: graphQLError)))
                            }
                            return promise(.failure(RequestServiceError(message: "Unknown Error", httpStatus: "400")))
                        }
                        return promise(.success(data))
                    }
                case .failure(let error):
                    return promise(.failure(RequestServiceError(message: error.localizedDescription, httpStatus: "400")))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func request<T: GraphQLMutation>(mutation: T, client: ApolloClient = ApolloManager.shared.client, queue: DispatchQueue = RequestServices.GraphQL.API.apiQueue) -> AnyPublisher<T.Data, Error> {
        return Future { promise in
            client.perform(mutation: mutation, queue: queue) { result in
                switch result {
                case .success(let response):
                    do {
                        guard let data = response.data else {
                            if let graphQLError = response.errors?.first {
                                return promise(.failure(RequestServiceError(graphQLError: graphQLError)))
                            }
                            return promise(.failure(RequestServiceError(message: "Unknown Error", httpStatus: "400")))
                        }
                        return promise(.success(data))
                    }
                case .failure(let error):
                    return promise(.failure(RequestServiceError(message: error.localizedDescription, httpStatus: "400")))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
