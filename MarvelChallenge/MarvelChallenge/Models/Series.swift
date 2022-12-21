//
//  Series.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 20/12/2022.
//

import Foundation

// MARK: - SeriesAPIResponse
struct SeriesAPIResponse: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: SeriesData
}

// MARK: - DataClass
struct SeriesData: Codable {
    let offset, limit, total, count: Int
    let results: [SeriesResult]
}

// MARK: - Result
struct SeriesResult: Codable {
    let id: Int
    let title: String
    let resultDescription: String?
    let resourceURI: String
    let urls: [URLElement]
    let startYear, endYear: Int
    let rating, type: String
    let modified: Date
    let thumbnail: Thumbnail
    let creators: Creators
    let characters: Characters
    let stories: Stories
    let comics, events: Characters
    let next, previous: SeriesSummary?

    enum CodingKeys: String, CodingKey {
        case id, title
        case resultDescription = "description"
        case resourceURI, urls, startYear, endYear, rating, type, modified, thumbnail, creators, characters, stories, comics, events, next, previous
    }
}


// MARK: - CharactersItem
struct CharactersItem: Codable {
    let resourceURI: String
    let name: String
}

struct SeriesSummary: Codable {
    let resourceURI: String
    let name: String
}
