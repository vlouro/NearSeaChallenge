//
//  NetworkRequests.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 19/12/2022.
//

import Foundation
import CryptoKit

enum Result<T> {
    case success(T)
    case error(String)
}

class NetworkRequests {
    
    // MARK: Variables
    static let shared = NetworkRequests()
    
    private var apiKeyPublic: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "MarveApiInfo", ofType: "plist") else {
                fatalError("Couldn't find file 'MarveApiInfo.plist'.")
            }
            
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY_PUBLIC") as? String else {
                fatalError("Couldn't find key 'API_KEY_PUBLIC' in 'MarveApiInfo.plist'.")
            }
            return value
        }
    }
    
    private var apiKeyPrivate: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "MarveApiInfo", ofType: "plist") else {
                fatalError("Couldn't find file 'MarveApiInfo.plist'.")
            }
            
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY_PRIVATE") as? String else {
                fatalError("Couldn't find key 'API_KEY_PRIVATE' in 'MarveApiInfo.plist'.")
            }
            return value
        }
        
    }
    
    
    
    // MARK: Methods
    
    /**
     // General request method
     */
    func request(baseUrl: String, encode: Bool, completionHandler: @escaping (Data) -> Void) {
        
        // Create URL
        let urlToUse: URL?
        
        if encode {
            guard let urlString = baseUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
            
            urlToUse = URL(string: urlString)
            
        } else {
            urlToUse = URL(string: baseUrl)
        }
        
        guard let url = urlToUse else {
            fatalError("Could not create URL")
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            // Check response status is 200 OK
            if let res = response as? HTTPURLResponse {
                if res.statusCode != 200 {
                }
            }
            
            // If returned data is nil
            guard let data = data else {
                return
            }
            
            completionHandler(data)
            
        }).resume()
    }

    func getCharacterList(nextResults: Int, completionHandler: @escaping (Result<([Character])>) -> Void) {
        let hash = MD5(string: "1"+apiKeyPrivate+apiKeyPublic)
        let url = "\(Constants.mainUrl)\(UrlEndpoints.charactersEndpoint)?"+"limit=\(Constants.limitPerPage)"+"&offset=\(nextResults)"+"&apikey=\(self.apiKeyPublic)&ts=1&hash=\(hash)"
   
        self.request(baseUrl: url, encode: true) { (data) in
            
            do {
                let response =  try JSONDecoder().decode(MarvelApiResponse.self, from: data)
                completionHandler(.success(response.data.results))
                
            } catch let jsonErr {
                completionHandler(.error(jsonErr.localizedDescription))
            }
        }
    }

    func getCharacterBySearching(characterString: String, nextResults: Int, completionHandler: @escaping (Result<(MarvelApiData)>) -> Void) {
       
        let hash = MD5(string: "1"+apiKeyPrivate+apiKeyPublic)
        let url = "\(Constants.mainUrl)\(UrlEndpoints.charactersEndpoint)?nameStartsWith=\(characterString)"+"&limit=\(Constants.limitPerPage)"+"&offset=\(nextResults)"+"&apikey=\(self.apiKeyPublic)&ts=1&hash=\(hash)"
        
        self.request(baseUrl: url, encode: true) { (data) in
            do {
                let response =  try JSONDecoder().decode(MarvelApiResponse.self, from: data)
                completionHandler(.success(response.data))
                
            } catch let jsonErr {
                completionHandler(.error(jsonErr.localizedDescription))
            }
        }
    }

    func getComicsForCharacter(characterId: Int, limit: Int, offset: Int,  completionHandler: @escaping (Result<([ComicResult])>) -> Void) {
        let hash = MD5(string: "1"+apiKeyPrivate+apiKeyPublic)
        let url = "\(Constants.mainUrl)\(UrlEndpoints.charactersEndpoint)/\(characterId)/comics?"+"limit=\(limit)"+"&offset=\(offset)"+"&apikey=\(self.apiKeyPublic)&ts=1&hash=\(hash)"
   
        self.request(baseUrl: url, encode: true) { (data) in
            
            do {
                let response =  try JSONDecoder().decode(ComicsAPIResponse.self, from: data)
                completionHandler(.success(response.data.results))
                
            } catch let jsonErr {
                completionHandler(.error(jsonErr.localizedDescription))
            }
        }
    }
    
    func getEventsForCharacter(characterId: Int, limit: Int, offset: Int,  completionHandler: @escaping (Result<([EventsResult])>) -> Void) {
        let hash = MD5(string: "1"+apiKeyPrivate+apiKeyPublic)
        let url = "\(Constants.mainUrl)\(UrlEndpoints.charactersEndpoint)/\(characterId)/events?"+"limit=\(limit)"+"&offset=\(offset)"+"&apikey=\(self.apiKeyPublic)&ts=1&hash=\(hash)"
   
        self.request(baseUrl: url, encode: true) { (data) in
            
            do {
                let response =  try JSONDecoder().decode(EventsAPIResponse.self, from: data)
                completionHandler(.success(response.data.results))
                
            } catch let jsonErr {
                completionHandler(.error(jsonErr.localizedDescription))
            }
        }
    }
    
    func getStoriesForCharacter(characterId: Int, limit: Int, offset: Int,  completionHandler: @escaping (Result<([StoryResult])>) -> Void) {
        let hash = MD5(string: "1"+apiKeyPrivate+apiKeyPublic)
        let url = "\(Constants.mainUrl)\(UrlEndpoints.charactersEndpoint)/\(characterId)/stories?"+"limit=\(limit)"+"&offset=\(offset)"+"&apikey=\(self.apiKeyPublic)&ts=1&hash=\(hash)"
   
        self.request(baseUrl: url, encode: true) { (data) in
            
            do {
                let response =  try JSONDecoder().decode(StoriesAPIResponse.self, from: data)
                completionHandler(.success(response.data.results))
                
            } catch let jsonErr {
                completionHandler(.error(jsonErr.localizedDescription))
            }
        }
    }
    
    func getSeriesForCharacter(characterId: Int, limit: Int, offset: Int,  completionHandler: @escaping (Result<([SeriesResult])>) -> Void) {
        let hash = MD5(string: "1"+apiKeyPrivate+apiKeyPublic)
        let url = "\(Constants.mainUrl)\(UrlEndpoints.charactersEndpoint)/\(characterId)/series?"+"limit=\(limit)"+"&offset=\(offset)"+"&apikey=\(self.apiKeyPublic)&ts=1&hash=\(hash)"
   
        self.request(baseUrl: url, encode: true) { (data) in
            
            do {
                let response =  try JSONDecoder().decode(SeriesAPIResponse.self, from: data)
                completionHandler(.success(response.data.results))
                
            } catch let jsonErr {
                completionHandler(.error(jsonErr.localizedDescription))
            }
        }
    }
    
    
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
}
