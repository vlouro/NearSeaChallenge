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
    var nextPage = 0
    var isLoading = false
    var endOfPages = false
    
    var characterCellViewModels = [CharacterCellViewModel]()
    
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
    
    func getCharacterBySearching(stringToSearch: String) {
       
    }
    
    func getMoreCharacters() {
        
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
