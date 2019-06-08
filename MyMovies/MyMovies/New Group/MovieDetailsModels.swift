//
//  MovieDetailsModels.swift
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

enum MovieData
{
    // MARK: Use cases
    
    enum MovieInformation
    {
        struct Request{
           
        }
        struct Response {
        }
        struct Gener {
            var id:Int?
            var name:String?
            
            init(_ id:Int? , _ name:String?) {
                self.id = id
                self.name = name
            }
        }
        struct MovieDetails {
            var id :Int? = -1
            var title:String? = ""
            var overView:String? = ""
            var voteCount:Double? = 0
            var posterPath:String? = ""
            var backdropPath:String? = ""
            var movieRate:Double? = 0.0
            var runTime:Int? = 0
            var geners:[Gener] = [Gener]()
            
            var rate:String {
                get {
                    return "\(String(describing:movieRate))/\(10)"
                }
            }
            func loadRuntimeAndGeners() ->String {
                var title = ""
                
                for (index,gener) in geners.enumerated() {
                    title.append(contentsOf: gener.name!)
                    if index < geners.count {
                        title.append(contentsOf: " | ")
                    }
                }
                print(title)
                return "\(String(describing: runTime)) min" + title
                
            }
            
        }
    }
    struct ViewModel{
        
    }
}
