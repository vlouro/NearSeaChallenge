//
//  ViewController.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 18/12/2022.
//

import UIKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = ThemeColors.tabBarColor
        self.tabBar.barTintColor = ThemeColors.tabBarColor
        self.tabBar.tintColor = ThemeColors.tabBarTintColor
        self.tabBar.unselectedItemTintColor = ThemeColors.tabBarUnselectedItem
        self.setupTabControllers()
    }
    
    func setupTabControllers(){
        // Set up View Controllers for Tab
        let navigationController1 = UINavigationController(rootViewController: CharacterListViewController())
        let navigationController2 = UINavigationController(rootViewController: AboutViewController())
        //Icons
        let aboutImage = UIImage(named: "tab_about")
        let homePageImage = UIImage(named: "tab_homepage")
        let homepageItem = UITabBarItem(title: "", image: homePageImage, selectedImage: homePageImage)
        let aboutItem = UITabBarItem(title: "", image: aboutImage, selectedImage: aboutImage)
        
        navigationController1.tabBarItem = homepageItem
        navigationController2.tabBarItem = aboutItem
        
        let controllers = [navigationController1, navigationController2]
        //First, remove the default top line and background
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        lineView.addGradient()
        self.tabBar.addSubview(lineView)
        
        self.viewControllers = controllers
    }
    
    
}

extension ViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true;
    }
}
