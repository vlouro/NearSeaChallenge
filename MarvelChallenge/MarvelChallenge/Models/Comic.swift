//
//  Comic.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 20/12/2022.
//

import Foundation

typealias ComicsList = [ComicResult]

// MARK: - ComicsAPIResponse
struct ComicsAPIResponse: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: ComicData
}

// MARK: - DataClass
struct ComicData: Codable {
    let offset, limit, total, count: Int
    let results: [ComicResult]
}

// MARK: - Result
struct ComicResult: Codable {
    let id, digitalID: Int
    let title: String
    let issueNumber: Int
    let variantDescription: String
    let resultDescription: String?
    let modified: String
    let upc: String?
    let isbn, diamondCode, ean: String?
    let issn : String?
    let format: String
    let pageCount: Int
    let textObjects: [TextObject]?
    let resourceURI: String
    let urls: [URLElement]
    let series: Series
    let variants, collections, collectedIssues: [SeriesSummary]?
    let dates: [DateElement]
    let prices: [Price]
    let thumbnail: Thumbnail
    let images: [Thumbnail]
    let creators: Creators
    let characters: Characters
    let stories: Stories
    let events: Characters

    enum CodingKeys: String, CodingKey {
        case id
        case digitalID = "digitalId"
        case title, issueNumber, variantDescription
        case resultDescription = "description"
        case modified, isbn, upc, diamondCode, ean, issn, format, pageCount, textObjects, resourceURI, urls, series, variants, collections, collectedIssues, dates, prices, thumbnail, images, creators, characters, stories, events
    }
}



// MARK: - TextObject
struct TextObject: Codable {
    let type, language, text: String
}


// MARK: - Series
struct Series: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - DateElement
struct DateElement: Codable {
    let type: String
    let date: String
}

// MARK: - Price
struct Price: Codable {
    let type: String
    let price: Double
}
