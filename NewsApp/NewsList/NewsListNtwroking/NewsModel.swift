//
//  NewsModel.swift
//  NewsApp
//
//  Created by MohamedNajeh on 22/02/2023.
//

import Foundation

import Foundation

// MARK: - News
struct News: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: ID?
    let name: Name?
}

enum ID: String, Codable {
    case googleNewsUk = "google-news-uk"
}

enum Name: String, Codable {
    case googleNewsUK = "Google News (UK)"
}
