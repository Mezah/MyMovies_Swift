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

protocol MovieDetailsBusinessLogic
{
  func loadMovieDetails(request: MovieData.MovieInformation.Request)
}

protocol MovieDetailsDataStore
{
  var movieId: Int { get set }
}

class MovieDetailsInteractor: MovieDetailsBusinessLogic, MovieDetailsDataStore
{
    var movieId: Int = 0
    
  var presenter: MovieDetailsPresentationLogic?
  var worker: MovieDetailsWorker?
  
  
  // MARK: Do something
  
  func loadMovieDetails(request: MovieData.MovieInformation.Request)
  {
    worker = MovieDetailsWorker()
    worker?.loadMovieDetails(movieId)
    
//    let response = MovieDetails.MovieInformation.Response()
//    presenter?.presentMovieDetails(r)
  }
}