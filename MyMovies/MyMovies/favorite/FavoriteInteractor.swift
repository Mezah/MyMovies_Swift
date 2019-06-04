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
  func doSomething(request: Favorite.Something.Request)
}

protocol FavoriteDataStore
{
  //var name: String { get set }
}

class FavoriteInteractor: FavoriteBusinessLogic, FavoriteDataStore
{
  var presenter: FavoritePresentationLogic?
  var worker: FavoriteWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Favorite.Something.Request)
  {
    worker = FavoriteWorker()
    worker?.doSomeWork()
    
    let response = Favorite.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
