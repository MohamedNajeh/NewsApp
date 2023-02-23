//
//  NewsNetworking.swift
//  NewsApp
//
//  Created by MohamedNajeh on 22/02/2023.
//

import Foundation

enum NewsNetworking {
    case getNews
}

extension NewsNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .getNews:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getNews:
            return "/v2/top-headlines?sources=google-news-uk&apiKey=2a8b6c4cd969401aa62f26973c653824"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getNews:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getNews:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization": "Bearer "]
        }
    }
}
