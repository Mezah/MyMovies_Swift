//
//  FavoriteInteractor.swift
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

protocol FavoriteBusinessLogic
{
  func loadFavoriteMovies(request: Favorite.Something.Request)
    func removeFromFavorite(_ movieID:String,_ completion:@escaping (()-> ()))
}

protocol FavoriteDataStore
{
var moviesList: [LocalMovieDetails] { get set }
    
}

class FavoriteInteractor: FavoriteBusinessLogic, FavoriteDataStore
{
    func removeFromFavorite(_ movieID: String,_ completion:@escaping (()->())) {
        presenter?.presentLoadingState(true)
        worker.removeMovieFromFavortie(movieID){
           self.presenter?.presentLoadingState(false)
           completion()
        }
        
    }
    
    var moviesList: [LocalMovieDetails] = [LocalMovieDetails]()
    
  var presenter: FavoritePresentationLogic?
  var worker = FavoriteWorker()
  
    fileprivate func loadFavoriteMovies() {
        worker.loadFavoriteMovies {
            movies,error in
            self.presenter?.presentLoadingState(false)
            if let error = error {
                self.presenter?.presentError()
                return
            }
            self.moviesList = movies
            let response = Favorite.Something.Response(movies)
            
            self.presenter?.presentFavoriteList(response: response)
            
        }
    }
    
    func loadFavoriteMovies(request: Favorite.Something.Request)
  {
    
    presenter?.presentLoadingState(true)
    loadFavoriteMovies()

  }
}
