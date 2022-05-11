//
//  TechnicalChallengeTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import Foundation

class APIService {
    let httpClient: HTTPClientProvider
    let jsonParser: JSONParserServiceProtocol
    
    init() {
        self.httpClient = HTTPClient()
        self.jsonParser = HTTPClient().jsonParser
    }
    
    func handleResponseResult<T: BaseModelProtocol>(result: Result<Data, Error>, responseModels: [T].Type, completion: @escaping (Result<[T], Error>) -> Void) {
        
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                print(String(decoding: data, as: UTF8.self))
                
                self.jsonParser.parseJSON(of: responseModels.self, from: data) { (result) in
                    switch result {
                    case .success(let response):
                        completion(.success(response))
                    case .failure(let error):
                        completion(.failure(error))
                        print(error)
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
