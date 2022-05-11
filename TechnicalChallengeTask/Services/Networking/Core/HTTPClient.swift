//
//  TechnicalChallengeTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import UIKit

// Added protocols to be able to write unit tests for the HTTP client and URLSession.
protocol HTTPClientProvider {
    func request(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

final class HTTPClient: HTTPClientProvider {
        
    init(session: URLSessionProtocol? = nil) {
        let delegateQueue = OperationQueue()
        delegateQueue.qualityOfService = .userInteractive
        delegateQueue.maxConcurrentOperationCount = 1
        
        self.urlSession = session ?? URLSession.init(configuration: .default, delegate: nil, delegateQueue: delegateQueue)
    }
        
    let jsonParser: JSONParserServiceProtocol = JSONParserService()
            
    private let urlSession: URLSessionProtocol
    
    func request(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlRequest: URLRequest? = createRequest(url: url)
        performRequest(urlRequest, completion: completion)
    }
    
    private func performRequest(_ urlRequest: URLRequest?, completion: @escaping (Result<Data, Error>) -> Void) {
        print("url : \(String(describing: urlRequest?.url?.absoluteString))")
        
        guard let request = urlRequest else {
            return completion(.failure(HTTPClientError.emptyURL(message: "Empty URL")))
        }
                
        let dataTask = urlSession.dataTask(request: request) { (data, response, error) in
            if let error = error {
                let errorType = error as NSError
                
                switch errorType.code {
                case NSURLErrorCancelled:
                    break
                default:
                    completion(.failure(error))
                }
            } else if let data = data, let response = response as? HTTPURLResponse {
                
                switch response.statusCode {
                case 200...299:
                    completion(.success(data))
                default:
                    completion(.failure(HTTPClientError.responseStatusError(message: "Response status code: \(response.statusCode)")))
                }
                
            } else {
                completion(.failure(HTTPClientError.responseStatusError(message: "Server error")))
            }
        }
        
        dataTask.resume()
    }
        
    private func createRequest(url: String) -> URLRequest? {
        let link: URL? = URL(string: url.replacingOccurrences(of: " ", with: "%20"))
        
        guard let url = link else {  return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}

extension URLSession: URLSessionProtocol {
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
    
}
