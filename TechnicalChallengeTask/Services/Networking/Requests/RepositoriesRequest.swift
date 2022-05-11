//
//  TechnicalChallengeTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import Foundation

 class RepositoriesRequest: APIService {

     func getRepositories(completion: @escaping (Result<[RepositoriesListEntity.Response.RepositoriesResponse], Error>) -> Void) {
         let url = APIEndpoints.baseURL
         
         httpClient.request(url: url) { [weak self] (result) in
             guard let self = self else { return }
             self.handleResponseResult(result: result, responseModels: [RepositoriesListEntity.Response.RepositoriesResponse].self, completion: completion)
         }
     }
 }
