//
//  EEAPI.swift
//  EEETravel
//
//  Created by licong on 2016/12/22.
//  Copyright © 2016年 Richard. All rights reserved.
//
import Foundation
import Moya

// MARK: - Provider setup

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let EEProvider = MoyaProvider<EEAPI>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum EEAPI {
    case ServiceFilter
    case UserProfile(String)
    case UserRepositories(String)
}

extension EEAPI: TargetType {
    public var baseURL: URL { return URL(string: "https://backend.gmei.com")! }
    public var path: String {
        switch self {
        case .ServiceFilter:
            return "/api/cache/data/service_filter/"
        case .UserProfile(let name):
            return "/users/\(name.urlEscaped)"
        case .UserRepositories(let name):
            return "/users/\(name.urlEscaped)/repos"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .UserRepositories(_):
            return ["sort": "pushed"]
        default:
            return nil
        }
    }
    
    public var task: Task {
        return .request
    }
    
    public var validate: Bool {
        switch self {
        case .ServiceFilter:
            return true
        default:
            return false
        }
    }
    
    //用于单元测试
    public var sampleData: Data {
        switch self {
        case .ServiceFilter:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        case .UserProfile(let name):
            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: String.Encoding.utf8)!
        case .UserRepositories(_):
            return "[{\"name\": \"Repo Name\"}]".data(using: String.Encoding.utf8)!
        }
    }
}


public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
