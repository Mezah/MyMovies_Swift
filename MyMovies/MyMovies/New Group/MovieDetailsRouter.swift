//
//  MovieDetailsRouter.swift
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

@objc protocol MovieDetailsRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MovieDetailsDataPassing
{
  var dataStore: MovieDetailsDataStore? { get }
}

class MovieDetailsRouter: NSObject, MovieDetailsRoutingLogic, MovieDetailsDataPassing
{
  weak var viewController: MovieDetailsViewController?
  var dataStore: MovieDetailsDataStore?
}
