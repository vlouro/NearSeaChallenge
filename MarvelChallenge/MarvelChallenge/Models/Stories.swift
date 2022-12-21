//
//  Stories.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 18/12/2022.
//

import Foundation

typealias StoriesList = [StoryResult]

struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: String
}


// MARK: - StoriesAPIResponse
struct StoriesAPIResponse: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: StoryData
}

struct StoryData: Codable {
    let offset, limit, total, count: Int
    let results: [StoryResult]
}

struct StoryResult: Codable {
    let id: Int
    let title, resultDescription: String
    let resourceURI: String
    let type: String
    let modified: String
    let thumbnail: Thumbnail?
    let creators: Creators
    let characters, series, comics, events: Characters
    let originalIssue: OriginalIssue

    enum CodingKeys: String, CodingKey {
        case id, title
        case resultDescription = "description"
        case resourceURI, type, modified, thumbnail, creators, characters, series, comics, events, originalIssue
    }
}

// MARK: - OriginalIssue
struct OriginalIssue: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Item
struct Item: Codable {
    let resourceURI: String
    let name, role: String
}
