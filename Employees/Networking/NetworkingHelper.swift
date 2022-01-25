
import Foundation
import Alamofire

class NetworkingHelper {
    
    public func loginRequest(success: @escaping (_ user: User?)->(), failure: @escaping (_ msg: String?)->(), parameters: Parameters) {
        AF.request("http://kurokiji.es/api/login", method: .put, parameters: parameters).validate(statusCode: 200...499).responseDecodable(of: Response.self) { response in
            if response.value?.status == 1 {
                success(response.value?.user!)
            } else {
                failure(response.value?.msg)
            }
        }
    }
    
    public func checkToken(success: @escaping (_ user: User?)->(), failure: @escaping (_ msg: String?)->(), parameters: Parameters) {
        AF.request("http://kurokiji.es/api/login", method: .put, parameters: parameters).validate(statusCode: 200...499).responseDecodable(of: Response.self) { response in
            if response.value?.status == 1 {
                success(response.value?.user!)
            } else {
                failure(response.value?.msg)
            }
        }
    }
    
    public func logoutRequest(success: @escaping (_ msg: String?)->(), failure: @escaping (_ msg: String?)->(), headers: HTTPHeaders) {     // headers = ["token": token]
        AF.request("http://kurokiji.es/api/employee/logout", method: .put, headers: headers).validate(statusCode: 200...499).responseDecodable(of: Response.self) { response in
            if response.value?.status == 1 {
                success(response.value?.msg)
            } else {
                failure(response.value?.msg)
            }
        }
    }
    
    public func sendMailRequest(success: @escaping (_ msg: String?)->(), failure: @escaping (_ msg: String?)->(), parameters: Parameters) {
        AF.request("http://kurokiji.es/api/passwordrecover", method: .put, parameters: parameters).validate(statusCode: 200...499).responseDecodable(of: Response.self) { response in
            if response.value?.status == 1 {
                success(response.value?.msg)
            } else {
                failure(response.value?.msg)
            }
        }
    }
    
    public func getUsersRequest(success: @escaping (_ users: [User]?)->(), failure: @escaping (_ msg: String?)->(), headers: HTTPHeaders) {     // headers = ["Token": token]
        AF.request("http://kurokiji.es/api/employee/getall", method: .get, headers: headers).validate(statusCode: 200...499).responseDecodable(of: Response.self) { response in
            if response.value?.status == 1 {
                success(response.value?.data)
            } else {
                failure(response.value?.msg)
            }
        }
    }
    
    public func createUserRequest(success: @escaping (_ msg: String?)->(), failure: @escaping (_ msg: String?)->(), token: String, user: Parameters) {     // headers = ["Token": token]
        let headers : HTTPHeaders =
            ["Token" : token]
        let parameters : Parameters = user
        
        AF.request("http://kurokiji.es/api/employee/add", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200...499).responseDecodable(of: Response.self) { response in
            if response.value?.status == 1 {
                success(response.value?.msg)
            } else {
                failure(response.value?.msg)
            }
        }
    }
}
