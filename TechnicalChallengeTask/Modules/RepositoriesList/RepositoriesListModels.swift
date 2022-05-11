//
//  RepositoriesListModels.swift
//  TechnicalChallengeTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import Foundation

enum RepositoriesListEntity {
    struct Response {
        struct RepositoriesResponse: BaseModelProtocol {
            var name: String?
            var description: String?
            
            enum CodingKeys: String, CodingKey {
                case name
                case description
            }
        }
    }
    
    struct View {
        struct RepositoryInfoModel {
            var title: String?
            var subtitle: String?
        }
    }
}
