//
//  EEAPI.swift
//  EEETravel
//
//  Created by licong on 2016/12/22.
//  Copyright © 2016年 Richard. All rights reserved.
//
import Foundation
import Moya

let EEURLScheme = "gmdoctor"
let EEURLSchemePrefix = "gmdoctor://"

func EURLSchemeAppendPath(_ path: String) -> String {
    return EEURLSchemePrefix + path
}

func EEURLCommonParams() -> String {
    #if APPSTORE
        let isDist = 1
    #else
        let isDist = 0
    #endif
    return String(format: "?platform=%@&os_version=%@&version=%@&model=%@&app_name=%@&release=%d",
                  Constant.platform,
                  Constant.systemVersion,
                  Constant.appVersion,
                  Constant.deviceModel,
                  Constant.appName,
                  isDist
    )
}

/**
 *  @brief 混合开发页面
 *
 *  @since 2.3.0
 */
struct Hybrid {
    
    static let Register                 = "/api/client/account/register"
    static let DoctorInvitation         = "/api/client/hybrid/invitation"
    static let CaseDetail               = "/api/client/hybrid/diary/%@"
    static let DoctorDetail             = "/api/client/hybrid/doctor/%@"
    static let ActivityDetail           = "/api/client/hybrid/activity/"
    static let ContentDetail            = "/api/client/hybrid/content/%@"
    static let TopicDetail              = "/api/client/topic/%@"
    static let WebAllComment            = "/api/client/comment/%@"
    static let DiaryAllComment          = "/api/client/hybrid/diary/%@/reply_list"      //某日记本下的全部评论
    static let TopicAllComment          = "/api/client/hybrid/topic/%@/reply_list"      //某帖子下的全部评论
    static let AnswerDetail             = "/api/client/hybrid/answer/%@/detail"     // 问答：回答详情
    static let QuestionDetail           = "/api/client/hybrid/question/%@/detail"   // 问答：问题详情
}

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
     //默认api,值为空
    case defaultApi
    case home(Int, Int) //page 和tagId
    case serviceFilter
    case userProfile(String)
    case userRepositories(String)
}

extension EEAPI: TargetType {
    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    public var baseURL: URL { return URL(string: "https://www.eee.com/")! }

//    public var baseURL: URL { return URL(string: "https://backend.gmei.com")! }
    public var path: String {
        switch self {
        case .defaultApi:
            return ""
        case .home(_, _):
            return "api/app/app.php"
        case .serviceFilter:
            return "/api/cache/data/service_filter/"
        case .userProfile(let name):
            return "/users/\(name.urlEscaped)"
        case .userRepositories(let name):
            return "/users/\(name.urlEscaped)/repos"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .home(let page, let tag):
            return ["page": page, "tag": tag]
        default:
            return nil
        }
    }
    
    public var task: Task {
        return .request
    }
    
    public var validate: Bool {
        switch self {
        case .serviceFilter:
            return true
        default:
            return false
        }
    }
    
    //用于单元测试
    public var sampleData: Data {
        switch self {
        default:
            return "default".data(using: String.Encoding.utf8)!
        }
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
