//
//  AppDelegate.swift
//  AniWiki
//
//  Created by Erik on 05.05.2024.
//

import UIKit
import youtube_ios_player_helper


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var preloadPlayerView: YTPlayerView?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        preloadYouTubePlayer()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Resources.Colors.tabbarBackgroundColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().tintColor = Resources.Colors.primaryTintColor
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().isTranslucent = false
        UITabBar.appearance().isTranslucent = false
        return true
    }
    
    private func preloadYouTubePlayer() {
        preloadPlayerView = YTPlayerView()
        preloadPlayerView?.load(withVideoId: "dQw4w9WgXcQ")
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

