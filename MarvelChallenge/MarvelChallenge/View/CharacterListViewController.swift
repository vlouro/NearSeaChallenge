//
//  CharacterListViewController.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 18/12/2022.
//

import UIKit

class CharacterListViewController: UIViewController, UISearchBarDelegate {


    private lazy var searchBar: UISearchBar = {
        let sc = UISearchBar()
        sc.delegate = self
        sc.backgroundColor = ThemeColors.aboutBackgroundColor
        sc.tintColor = .white
        sc.barTintColor = ThemeColors.aboutBackgroundColor
        sc.placeholder = "Search"
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ThemeColors.aboutBackgroundColor
        
        var image = UIImage(named: "MarvelLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: nil, action: nil)
        self.navigationItem.titleView = self.navigationController?.titleMultiLine(topText: "Avengers,", bottomText: "Assemble!")
        setupSearchBar()
    }
    
    func setupSearchBar() {
        self.view.addSubview(searchBar)
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        searchBar.textColor = .white
        searchBar.setMagnifyingGlassColorTo(color: .white)
        searchBar.setPlaceholderTextColorTo(color: .white)
        searchBar.setClearButtonColorTo(color: .white)
    }

    
}


