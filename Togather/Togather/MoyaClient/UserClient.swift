import Foundation
import Moya

enum UserService {
    //계정 관련
    case login(accountID: String, password: String)
    case signup(password: String, email: String, name: String)
    case logout
    case quitAccount
    
    //메일 관련
    case mailDuplicate(email: String)
    case mailSignup(email: String)
    case mailVerify(email: String, authCode: String)
    
    //토큰 재발급
    case tokenReissue
    
    //유저 정보 관련
    case changeMyInfo(name: String, picture: String)
    case changePassword(oldPassword: String, newPassword: String)
    case getMyprofile
}

extension UserService: TargetType {
    var baseURL: URL {
        return URL(string: "http://44.209.75.36:8080/users")!
    }
    
    var path: String {
        switch self {

        case .login:
            return "/auth"
        case .signup:
            return ""
        case .mailDuplicate:
            return "/mail/duplicate"
        case .mailSignup:
            return "/mail/signup"
        case .mailVerify:
            return "/mail/verify"
        case .tokenReissue:
            return "/auth"
        case .changeMyInfo:
            return ""
        case .changePassword:
            return "/password"
        case .getMyprofile:
            return ""
        case .logout:
            return "/logout"
        case .quitAccount:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        case .login, .signup, .mailDuplicate, .mailSignup, .mailVerify:
            return .post
        case .tokenReissue:
            return .put
        case .changeMyInfo, .changePassword:
            return .patch
        case .getMyprofile:
            return .get
        case .logout, .quitAccount:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
            
        case .tokenReissue, .getMyprofile, .logout, .quitAccount:
            return .requestPlain
        case .mailDuplicate(let email):
            return .requestParameters(
                parameters:
                    [
                        "email" : email
                    ],
                encoding: JSONEncoding.default)
            
        case .mailSignup(let email):
            return .requestParameters(
                parameters:
                    [
                        "email" : email
                    ],
                encoding: JSONEncoding.default)
            
        case .mailVerify(let email, let authCode):
            return .requestParameters(
                parameters:
                    [
                        "email" : email,
                        "auth_code" : authCode
                    ],
                encoding: JSONEncoding.default)
            
        case .changeMyInfo(let name, let picture):
            return .requestParameters(
                parameters:
                    [
                        "name" : name,
                        "picture" : picture
                    ],
                encoding: JSONEncoding.default)

        case .changePassword(let oldPassword, let newPassword):
            return .requestParameters(
                parameters:
                    [
                        "old_password" : oldPassword,
                        "new_password" : newPassword
                    ],
                encoding: JSONEncoding.default)
            
        case .login(let ID, let PW):
            return .requestParameters(
                parameters:
                    [
                        "email" : ID,
                        "password" : PW
                    ],
                encoding: JSONEncoding.default)
            
        case .signup(let password, let email, let name):
            return .requestParameters(
                parameters:
                    [
                        "password" : password,
                        "name" : name,
                        "email" : email
                    ],
                encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .mailSignup, .mailVerify, .mailDuplicate, .signup, .login, .changeMyInfo, .changePassword:
            return Header.tokenIsEmpty.header()
            
        case  .tokenReissue:
            return Header.refreshToken.header()
            
        case .getMyprofile, .logout, .quitAccount:
            return Header.accessToken.header()
        }
    }
}
