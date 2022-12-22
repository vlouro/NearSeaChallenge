//
//  CharacterViewModel.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 19/12/2022.
//

import Foundation

class CharacterViewModel: NSObject {
    
    var reloadCollectionView: (() -> Void)?
    var character = CharactersList()
    var characterSearch = CharactersList()
    var nextPage = 0
    var nextPageForSearch = 0
    var endOfPageSearch = false
    var isLoading = false
    var endOfPages = false
    
    var characterCellViewModels = [CharacterCellViewModel]()
    var characterSearchCellViewModels = [CharacterCellViewModel]()
    
    func getCharacters(nextPage: Int, completionHandler: @escaping (Bool) -> Void)  {
        NetworkRequests.shared.getCharacterList(nextResults: nextPage) { (result) in
            switch result {
                
            case let .success(characterList):
                self.character = characterList
                var vms = [CharacterCellViewModel]()
                for character in characterList {
                    vms.append(self.createCharacterCellModel(character: character))
                }
                self.characterCellViewModels = vms
                self.nextPage += 20
                if characterList.count > 0 {
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
                
                break
            case .error(_):
                print("There was an error")
                completionHandler(false)
            }
        }
    }
    
    
    func getCharacterBySearching(stringToSearch: String, completionHandler: @escaping (Bool) -> Void) {
        NetworkRequests.shared.getCharacterBySearching(characterString: stringToSearch, nextResults: nextPageForSearch) { (result) in
            switch result {
                
            case let .success(characterData):
                if self.characterSearch.count == characterData.count {
                    completionHandler(false)
                }
                self.characterSearch.append(contentsOf: characterData.results)
                var vms = [CharacterCellViewModel]()
                for character in characterData.results {
                    vms.append(self.createCharacterCellModel(character: character))
                }
                self.characterSearchCellViewModels.append(contentsOf: vms)
                self.nextPageForSearch += 20
                
                completionHandler(true)
                
                break
            case .error(_):
                print("There was an error")
                completionHandler(false)
            }
        }
    }
    
    func getMoreCharacters(completionHandler: @escaping (Bool) -> Void) {
        if !self.isLoading || !endOfPages {
            self.isLoading = true
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
                NetworkRequests.shared.getCharacterList(nextResults: self.nextPage) { (result) in
                    switch result {
                        
                    case let .success(characterList):
                        if characterList.count == 0 {
                            completionHandler(false)
                            self.endOfPages = true
                        }
                        self.character.append(contentsOf: characterList)
                        var vms = [CharacterCellViewModel]()
                        for character in characterList {
                            vms.append(self.createCharacterCellModel(character: character))
                        }
                        self.characterCellViewModels.append(contentsOf: vms)
                        self.nextPage += 20
                        
                        if characterList.count > 0 {
                            completionHandler(true)
                        }
                        
                        break
                    case .error(_):
                        print("There was an error")
                        completionHandler(false)
                    }
                }
            }
        }
    }
    
    func createCharacterCellModel(character: Character) -> CharacterCellViewModel {
        
        let characterName = character.name
        let characterImage = character.thumbnail.path+"."+character.thumbnail.thumbnailExtension
        
        
        return CharacterCellViewModel(name: characterName, imageUrl: characterImage)
    }
    
    
    func getCharacterViewModel(at indexPath: IndexPath) -> CharacterCellViewModel {
        return characterCellViewModels[indexPath.section]
    }
    
}
