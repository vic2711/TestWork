//
//  UsersViewModel.swift
//  TestWork
//
//  Created by Viktor Miroshnychenko on 6/14/18.
//  Copyright © 2018 FoxHound. All rights reserved.
//

import Foundation
import Moya

class UsersViewModel {

    let provider = MoyaProvider<GitAPI>()

    var users = [UserElement]()

    var perPage = 10
    var since = 0
    
    var followersUsername = ""

    public var isUserFollowersList = false

    // MARK: Get Users List

    public func getUsersList(completion: @escaping () -> ()) {

        provider.request(.usersList(perPage: "\(perPage)", since: "\(since)")) { (result) in
            switch result {
            case .success(let response):
                do {
                    self.users.append(contentsOf: try User(response.mapString()))
                    completion()
                } catch let error {
                    print("An error occurred: \(error)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: Get Followers List

    public func getUserFollowers(completion: @escaping () -> ()) {

        provider.request(.userFollowers(userName: self.followersUsername)) { (result) in
            switch result {
            case .success(let response):
                do {
                    self.users.append(contentsOf: try User(response.mapString()))
                    completion()
                } catch let error {
                    print("An error occurred: \(error)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
