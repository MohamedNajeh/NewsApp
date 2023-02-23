//
//  NewsAPI.swift
//  NewsApp
//
//  Created by MohamedNajeh on 22/02/2023.
//

import Foundation
protocol NewsAPIProtocol {
    func getNews(completion: @escaping (Result<News?, ErrorMessages>) -> Void)
}

class NewsAPI: BaseAPI<NewsNetworking>, NewsAPIProtocol {
    func getNews(completion: @escaping (Result<News?, ErrorMessages>) -> Void) {
        self.fetchData(target: .getNews, responseClass: News?.self) { result in
            completion(result)
        }
    }
}
