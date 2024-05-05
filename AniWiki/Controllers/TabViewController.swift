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
    }
    
    private func configureTabs() {
        let vc1 = AnimeViewController()
        let vc2 = TopViewController()
        let vc3 = CharactersViewController()
        
        //Set tab bar items images
        vc1.tabBarItem.image = UIImage(systemName: "movieclapper")
        vc2.tabBarItem.image = UIImage(systemName: "star.fill")
        vc3.tabBarItem.image = UIImage(systemName: "figure.cooldown")
        
        //Set Title
        vc1.tabBarItem.title = "Anime"
        vc2.tabBarItem.title = "Top"
        vc3.tabBarItem.title = "Characters"
        vc1.title = "Anime"
        vc2.title = "Top"
        vc3.title = "Characters"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }


}

