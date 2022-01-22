//
//  Utils.swift
//  CinemaView
//
//  Created by Monica Galan de la Llana on 14/1/22.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

enum CustomTargets: Int {
    case DEV = 0
    case PRE = 1
    case PRO = 2
}

struct RequestDTO {
    var params: [String: Any]?
    var arrayParams: [[String: Any]]?
    var method: HTTPMethods
    var urlContext: URLEndpoint.BaseURLContext
    var endpoint: String
}

struct URLEndpoint {
    #if DEV
    static let targetDefault: CustomTargets = CustomTargets.DEV
    #elseif PRE
    static let targetDefault: CustomTargets = CustomTargets.PRE
    #else
    static let targetDefault: CustomTargets = CustomTargets.PRO
    #endif
    
    enum BaseURLContext {
        case webService
        case firebase
    }
    
    // Movies
    static let endpointMoviesGenre = "genre/movie/list?api_key=\(Constants.Api.apiKey)"
    static let endpointDetailMoviesGenre = "/discover/movie?api_key=\(Constants.Api.apiKey)&with_genres=%@"
    
}

extension URLEndpoint {
    static func getUrlBase(with urlContext: BaseURLContext) -> String {
        switch urlContext {
        case .webService:
            switch self.targetDefault{
            case .DEV:
                return ""
            case .PRE:
                return ""
            case .PRO:
                return "https://api.themoviedb.org/3/"
            }
            
        case .firebase:
            switch self.targetDefault{
            case .DEV:
                return ""
            case .PRE:
                return ""
            case .PRO:
                return ""
            }
        }
    }
}
