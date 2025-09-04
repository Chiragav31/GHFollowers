//
//  SceneDelegate.swift
//  GHFollowers
//
//  Created by Shetty, Chirag Ranjit on 11/05/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        

        
        guard let windowScene = (scene as? UIWindowScene) else { return } //1. creating a window
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)  //2. fill the full window screen with the window(bounds means fill)
        window?.windowScene = windowScene //3. every window has a window scene
        window?.rootViewController = createTabBarController()//4. every window needs a view controller to show the content
        window?.makeKeyAndVisible() //5. show it on the phone screen
        
        //6. now when you run the app, you should see the tab bar on the screen
    }
    //creating the search navigation
    func createSearchNavigationController() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        return UINavigationController(rootViewController: searchVC)
    }
    //creating the favourites navigation
    func createFavouritesNavigationController() -> UINavigationController {
        let favoritesListVC = FavoritesListVC()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem.image = UIImage(systemName: "star")
        return UINavigationController(rootViewController: favoritesListVC)
    }
    
    //create the tab bar after you made the induvidual nav bars above
    func createTabBarController() -> UITabBarController {
        let tabBar = UITabBarController()
        //tabBar.tabBar.backgroundColor = .systemGreen
        UITabBar.appearance().tintColor = .systemGreen
        tabBar.viewControllers = [createSearchNavigationController(), createFavouritesNavigationController()]
        return tabBar
    }
    
    //So after this we know that our tab bar controllers are holding the navigation controllers which are holding the view controllers2

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


