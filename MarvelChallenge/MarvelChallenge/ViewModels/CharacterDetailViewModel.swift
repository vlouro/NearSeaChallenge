//
//  CharacterDetailViewModel.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 20/12/2022.
//

import Foundation

class CharacterDetailViewModel: NSObject {
    
    var comics = ComicsList()
    var nextPage = 0
    var isLoading = false
    var endOfPages = false
    
    var comicsCellViewModels = [ComicsCellViewModel]()

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

    
    func createComicCellModel(comic: ComicResult) -> ComicsCellViewModel {
        
        let comicName = comic.title
        let comicImage = comic.thumbnail.path+"."+comic.thumbnail.thumbnailExtension
        
        
        return ComicsCellViewModel(name: comicName, imageUrl: comicImage)
    }
    
    
    
}
