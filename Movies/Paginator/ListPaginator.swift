//
//  ListPaginator .swift
//  Movies
//
//  Created by Pablo de la Rosa Michicol on 6/14/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import Foundation
import UIKit

// Pagination is used most in get method instead of post.
class ListPaginator {
    // RequestContract contains your value like url, method, and when you execute somewhere, you just need to use contract to run.
    // can change the contract in some specific case also
    var contract: RequestContract?
    
    // some api will support page, others support startIndex and endIndex
    // I found the api support page so use page here. you can uncomment to use startIndex and endIndex
    //    var startIndex = 0
    //    var endIndex = 0
    var page = 1
    var isLoading = false // check isLoading so that we don't call many apis at the same time
    var canLoadMore = true // check if there is more result or not.
    
    func setList(_ list: [AnyObject]) {
        //        startIndex = endIndex
        //        endIndex += list.count
        page += 1
        contract?.params = ["page": page] // this is what I'm still thinking.
        canLoadMore = list.isEmpty == false // empty list -> no more result
    }
    
    func executeRequest(completion: @escaping ((Result<[String : [MovieLocation]]>) -> Void)) {
        if isLoading { return }
        if canLoadMore == false { return }
        guard var contract = contract else { return }
        
        isLoading = true
        NetworkingClient.shared.getMovies { (result) in
            switch result {
            case .success(let moviesLocation):
                self.isLoading = false
                break
            case .failure(let error):
                self.isLoading = false
                print(error)
                break
            }
        }
    }
}

struct RequestContract {
    var url: String
    var method: String
    var params: [String: Any]?
}
