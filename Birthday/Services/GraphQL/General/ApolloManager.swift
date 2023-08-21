//
//  ApolloManager.swift
//  Birthday
//
//  Created by Edgar Arakelyan on 17.08.23.
//

import Foundation
import Apollo

class ApolloManager {

    static let shared = ApolloManager()

    let client: ApolloClient

    init() {
        let sessionClient = URLSessionClient()
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let provider = LegacyInterceptorProvider(client: sessionClient, store: store)
        let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: RequestServices.GraphQL.API.baseUrl)
        client = ApolloClient(networkTransport: transport, store: store)
    }
}
