//
//  MovieDetailsInteractor.swift
//  MyMovies
//
//  Created by Hazem on 6/7/19.
//  Copyright (c) 2019 Hazem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieDetailsResponse :class {
    func showMovieDetails(_ movieDetails:LocalMovieDetails)
    func showError()
}


protocol MovieDetailsBusinessLogic
{
    func loadMovieDetails(request: MovieData.MovieInformation.Request)
    func addMovieToFavorite(_ completion: @escaping (_ isFav:Bool) -> ())
}

protocol MovieDetailsDataStore
{
    var movieId: Int { get set }
    var movieDetails: LocalMovieDetails? { get set }
}

class MovieDetailsInteractor: MovieDetailsBusinessLogic, MovieDetailsDataStore
{
    
    var movieId: Int = 0
    
    var presenter: MovieDetailsPresentationLogic?
    var worker: MovieDetailsWorker?
    var movieDetails:LocalMovieDetails? = nil
    
    // MARK: Do something
    
    func loadMovieDetails(request: MovieData.MovieInformation.Request)
    {
        worker = MovieDetailsWorker()
        presenter?.presentLoadingState(true)
        
        worker?.loadMovieDetails(movieId){
            (details,error) in
            
            self.presenter?.presentLoadingState(false)
            
            if error {
                self.presenter?.presentError()
                return
            }
            
            if let movieDetails = details {
                self.presenter?.presentMovieDetails(movieDetails: movieDetails)
                 self.movieDetails = movieDetails
            }
        }
    }
    
    func addMovieToFavorite(_ completion: @escaping (_ isFav:Bool) -> ()) {
        presenter?.presentLoadingState(true)
        worker?.addMovieToFavortie(movieId, (movieDetails?.isFavorite)!){
            (added) in
            self.presenter?.presentLoadingState(false)
            completion(added)
        }
    }
   
}
