//
//  ViewController.swift
//  AniWiki
//
//  Created by Erik on 05.05.2024.
//

import UIKit

final class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
        setInitialTab()
    }
    
    private func configureTabs() {
        let vc1 = MangaViewController()
        let vc2 = TopViewController()
        let vc3 = GameViewController()
        
        //Set tab bar items images
        vc1.tabBarItem.image = UIImage(systemName: "book.pages")
        vc2.tabBarItem.image = UIImage(systemName: "star.fill")
        vc3.tabBarItem.image = UIImage(systemName: "gamecontroller")
        
        //Set Title
        vc1.tabBarItem.title = "Manga"
        vc2.tabBarItem.title = "Top"
        vc3.tabBarItem.title = "Game"
        vc1.title = "Manga"
        vc2.title = "Top"
        vc3.title = "Game"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        tabBar.backgroundColor = Resources.Colors.tabbarBackgroundColor
        tabBar.barTintColor = Resources.Colors.tabbarBackgroundColor
        tabBar.tintColor = Resources.Colors.primaryTintColor
        tabBar.unselectedItemTintColor = Resources.Colors.unselectedItemColor
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
    
    private func setInitialTab() {
        self.selectedIndex = 1
    }


}

