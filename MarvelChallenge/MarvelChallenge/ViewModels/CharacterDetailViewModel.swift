//
//  CharacterDetailViewModel.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 20/12/2022.
//

import Foundation

struct DetailsContent {
    let name : String
    var items : [Any]
}

class CharacterDetailViewModel: NSObject {
    
    var detailsContent = [DetailsContent]()
    var stories = StoriesList()
    var events = EventsList()
    var series = SeriesList()
    var comics = ComicsList()
    var nextPage = 0
    var isLoading = false
    var endOfPages = false
    
    var comicsCellViewModels = [ComicsCellViewModel]()
    var storyCellViewModels = [DetailContentCellViewModel]()
    var seriesCellViewModels = [DetailContentCellViewModel]()
    var eventsCellViewModels = [DetailContentCellViewModel]()
    
    func getComics(characterId: Int, completionHandler: @escaping (Bool) -> Void)  {
        NetworkRequests.shared.getComicsForCharacter(characterId: characterId, limit: 5, offset: 0, completionHandler: { (result) in
            switch result {
                //
            case let .success(comicsList):
                self.comics = comicsList
                var vms = [ComicsCellViewModel]()
                for comic in comicsList {
                    vms.append(self.createComicCellModel(comic: comic))
                }
                self.comicsCellViewModels = vms
                
                if self.comicsCellViewModels.count > 0 {
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
                
                break
            case .error(_):
                print("There was an error")
                completionHandler(false)
            }
        })
        
    }
    
    
    func downloadDetails(characterId: Int, completionHandler: @escaping (Bool) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        NetworkRequests.shared.getStoriesForCharacter(characterId: characterId, limit: 4, offset: 0) { (result) in
            switch result {
                //
            case let .success(storyList):
                self.stories = storyList
                var vms = [DetailContentCellViewModel]()
                for story in storyList {
                    vms.append(self.createStoryCellModel(story: story))
                }
                self.storyCellViewModels = vms
                let stories = DetailsContent(name: "Stories", items: self.storyCellViewModels)
                self.detailsContent.append(stories)
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()   // <<----
                }
                
                break
            case .error(_):
                print("There was an error")
                DispatchQueue.main.async {
                    dispatchGroup.leave()   // <<----
                }
            }
        }
        
        dispatchGroup.enter()
        NetworkRequests.shared.getSeriesForCharacter(characterId: characterId, limit: 4, offset: 0) { (result) in
            switch result {
                //
            case let .success(seriesList):
                self.series = seriesList
                var vms = [DetailContentCellViewModel]()
                for series in seriesList {
                    vms.append(self.createSeriesCellModel(series: series))
                }
                self.seriesCellViewModels = vms
                let series = DetailsContent(name: "Series", items: self.seriesCellViewModels)
                self.detailsContent.append(series)
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
                
                break
            case .error(_):
                print("There was an error")
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }
        
        
        dispatchGroup.enter()   // <<---
        NetworkRequests.shared.getEventsForCharacter(characterId: characterId, limit: 4, offset: 0) { (result) in
            switch result {
                //
            case let .success(eventsList):
                self.events = eventsList
                var vms = [DetailContentCellViewModel]()
                for event in eventsList {
                    vms.append(self.createEventsCellModel(event: event))
                }
                self.eventsCellViewModels = vms
                let events = DetailsContent(name: "Events", items: self.eventsCellViewModels)
                self.detailsContent.append(events)
                
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
                
                break
            case .error(_):
                print("There was an error")
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completionHandler(true)
        }
    }
    
    
    
    
    func createComicCellModel(comic: ComicResult) -> ComicsCellViewModel {
        
        let comicName = comic.title
        let comicImage = comic.thumbnail.path+"."+comic.thumbnail.thumbnailExtension
        
        
        return ComicsCellViewModel(name: comicName, imageUrl: comicImage)
    }
    
    func createStoryCellModel(story: StoryResult) -> DetailContentCellViewModel {
        
        let storyName = story.title
        let storyDescription = story.resultDescription
        var storyImage = ""
        
        if let thumbnail = story.thumbnail {
            storyImage = thumbnail.path+"."+thumbnail.thumbnailExtension
        }
        
        return DetailContentCellViewModel(name: storyName, imageUrl: storyImage, description: storyDescription)
    }
    
    func createSeriesCellModel(series: SeriesResult) -> DetailContentCellViewModel {
        
        let seriesName = series.title
        let seriesDescription = series.resultDescription ?? "No Description"
        let seriesImage = series.thumbnail.path+"."+series.thumbnail.thumbnailExtension
        
        
        return DetailContentCellViewModel(name: seriesName, imageUrl: seriesImage, description: seriesDescription)
    }
    
    func createEventsCellModel(event: EventsResult) -> DetailContentCellViewModel {
        
        let eventName = event.title
        let eventDescription = event.resultDescription
        let eventImage = event.thumbnail.path+"."+event.thumbnail.thumbnailExtension
        
        
        return DetailContentCellViewModel(name: eventName, imageUrl: eventImage, description: eventDescription)
    }
    
    
    
}
