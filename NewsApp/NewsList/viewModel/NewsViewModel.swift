//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by MohamedNajeh on 22/02/2023.
//

import Foundation
protocol NewsViewModelProtocol {
    func getNews()
    func setError(_ message: ErrorMessages)
    var news: Observable<News?> { get  set }
    var errorMessage: Observable<String?> { get set }
    var errorType: Observable<ErrorMessages?> { get set }
    var isLoading: Observable<Bool> { get set }
}

class NewsViewModel : NewsViewModelProtocol {
    
    
    var news: Observable<News?>                     = Observable(nil)
    
    var errorMessage: Observable<String?>           = Observable(nil)
    
    var errorType: Observable<ErrorMessages?>       = Observable(nil)
    
    var isLoading: Observable<Bool>                 = Observable(false)
    
    var api:NewsAPIProtocol?
    
    init(){
        self.api = NewsAPI()
    }
    
    func getNews() {
        self.isLoading.value = true
        self.api?.getNews(completion: { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let news):
                self?.news.value = news
            case .failure(let error):
                self?.setError(error)
            }
        })
    }
    
    func setError(_ message: ErrorMessages) {
        self.errorType.value = message
        self.errorMessage.value = message.rawValue
    }
}
