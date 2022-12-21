//
//  Events.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 18/12/2022.
//

import Foundation

// MARK: - EventsAPIResponse
struct EventsAPIResponse: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: EventData
}

// MARK: - DataClass
struct EventData: Codable {
    let offset, limit, total, count: Int
    let results: [EventsResult]
}

// MARK: - Result
struct EventsResult: Codable {
    let id: Int
    let title, resultDescription: String
    let resourceURI: String
    let urls: [URLElement]
    let modified: Date
    let start, end: String
    let thumbnail: Thumbnail
    let creators: Creators
    let characters: Characters
    let stories: Stories
    let comics, series: Characters
    let next, previous: Next

    enum CodingKeys: String, CodingKey {
        case id, title
        case resultDescription = "description"
        case resourceURI, urls, modified, start, end, thumbnail, creators, characters, stories, comics, series, next, previous
    }
}

// MARK: - Characters
struct Characters: Codable {
    let available: Int
    let collectionURI: String
    let items: [Next]
    let returned: Int
}

// MARK: - Next
struct Next: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Creators
struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

// MARK: - CreatorsItem
struct CreatorsItem: Codable {
    let resourceURI: String
    let name, role: String
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

