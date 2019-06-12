//
//  FavoriteViewController.swift
//  MyMovies
//
//  Created by Hazem on 6/4/19.
//  Copyright (c) 2019 Hazem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import PKHUD

protocol FavoriteDisplayLogic: MainDisplayLogic{
    func displayFavoriteMovies(viewModel: Favorite.Something.ViewModel)
}

class FavoriteViewController: UIViewController, FavoriteDisplayLogic,UICollectionViewDelegate,UICollectionViewDataSource
{
    
    @IBOutlet weak var moviesCollection: UICollectionView!
    
    
    private var moviesList : [LocalMovieDetails] = [LocalMovieDetails]()
    var interactor: FavoriteBusinessLogic?
    var router: (NSObjectProtocol & FavoriteRoutingLogic & FavoriteDataPassing)?
    var selectedCellIndex :Int = -1
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = FavoriteInteractor()
        let presenter = FavoritePresenter()
        let router = FavoriteRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let sender = sender as! FavoriteCell
        selectedCellIndex = moviesCollection?.indexPath(for: sender)?.row ?? -1
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    // MARK: Do Loadind favorite
    
    func loadFavorites()
    {
        let request = Favorite.Something.Request()
        interactor?.loadFavoriteMovies(request: request)
    }
    
    func displayFavoriteMovies(viewModel: Favorite.Something.ViewModel)
    {
        self.moviesList = viewModel.moviesList!
        self.moviesCollection.reloadData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as! FavoriteCell
        let movie = moviesList[(indexPath as NSIndexPath).row]
        cell.moviePoster.kf.indicatorType = .activity
        let posterUrl = URL(string: movie.posterImage!)
        cell.moviePoster.kf.setImage(with: posterUrl)
        cell.movieTitle.text = movie.title!
        cell.removeFromFav = {
            self.interactor?.removeFromFavorite(movie.id!) {
                self.moviesList.remove(at: (indexPath as NSIndexPath).row)
                self.moviesCollection.reloadData()
            }
        }
        if movie.isFavorite {
            cell.favoriteIcon.setImage(UIImage(named: "baseline_favorite_black_48pt_1x.png"), for: .normal)
        } else {
            cell.favoriteIcon.setImage(UIImage(named: "outline_favorite_border_black_48pt_1x.png"), for: .normal)
        }
        return cell
    }
    
}
