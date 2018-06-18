//
//  GitAPI.swift
//  TestWork
//
//  Created by Viktor Miroshnychenko on 6/15/18.
//  Copyright © 2018 FoxHound. All rights reserved.
//

import Foundation
import Moya

enum GitAPI {
    case usersList(perPage: String, since: String)
    case userFollowers(userName: String)
}

extension GitAPI: TargetType {

    var baseURL: URL {
        return URL(string: "https://api.github.com/")!
    }

    var path: String {
        switch self {
        case .usersList(_, _):
            return "users"

        case .userFollowers(let userName):
            return "users/\(userName)/followers"
        }
    }

    var method: Moya.Method {
        switch self {
        case .usersList, .userFollowers:
            return .get
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .usersList, .userFollowers:
            return nil
        }
    }

    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .usersList(let perPage, let since):
            return .requestParameters(parameters: ["per_page" : perPage, "since" : since], encoding: URLEncoding.default)
            
        case .userFollowers:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
