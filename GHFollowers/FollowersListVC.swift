//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Shetty, Chirag Ranjit on 15/05/25.
//

import UIKit

class FollowersListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var collectionview: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>! //data source for the collection view
    var followers: [Follower] = [] //array of followers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false //make sure navigation bar is not hidden
        // Do any additional setup after loading the view.
        getFollowers()
        setupCollectionView()
        configureDataSource() //configure the data source for the collection view
    }
    
    func setupCollectionView() {
        //setup the collection view and major params like background color, frame, register cell
        
        collectionview = UICollectionView(frame:view.bounds , collectionViewLayout: createThreeCollectionFlowLayout()) //frame of the collection view just fill up the whole view
        view.addSubview(collectionview)
        collectionview.backgroundColor = .systemBackground //set the background color of the collection view
        collectionview.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.followerCellId)
    }
    
    func createThreeCollectionFlowLayout() -> UICollectionViewFlowLayout {
        //create a flow with major params being section inset and item size
        
        let width = view.bounds.width
        let padding:CGFloat            = 12
        let minimumItemSpacing:CGFloat = 10
        let availableWidth             = width - (2 * padding) - (minimumItemSpacing * 2)
        let itemWidth                  = availableWidth / 3
        
        let layout                    = UICollectionViewFlowLayout()
        layout.sectionInset           = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize               = CGSize(width: itemWidth, height: itemWidth + 40)  //+40 to accomodate the git user label for every cell
        return layout
    }
    
    func getFollowers() { //the network call
        NetworkManager.shared.getFollowers(for: username, page: 1) { (followers, errorMessage) in //(followers, errorMessage) from the completion handler
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: errorMessage!.rawValue, buttonTitle: "Ok")
                return
            }
            
            print("Number of followers: \(followers.count)")
            print(followers)
            guard followers.count > 0 else {
                self.presentGFAlertOnMainThread(title: "No followers found", message: "This user has no followers.", buttonTitle: "Ok")
                return
            }
            self.followers = followers //set the followers array to the followers from the network call
            self.updateData() //update the data source with the new followers
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionview, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.followerCellId, for: indexPath) as! FollowerCell //here we need to cast this as a follower cell
            cell.set(follower: follower) //set the follower for the cell. Set function is in the FollowerCell.swift
            return cell
        })
        
    }
        
        //Now we need to create a snapshot of the data source
        func updateData() {
            var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>() //create a new snapshot
            snapshot.appendSections([.main]) //append the main section -> initial snapshot
            snapshot.appendItems(followers) //append the items to the section
            DispatchQueue.main.sync {
                self.dataSource.apply(snapshot, animatingDifferences: true) //apply the snapshot to the data source
            }
        }
        
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
}
