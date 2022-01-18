
import Foundation
import Alamofire

class NetworkingHelper {
    
    public func loginRequest(success: @escaping (_ user: User?)->(), failure: @escaping (_ msg: String?)->(), parameters: Parameters) {
        AF.request("http://kurokiji.com/api/login", method: .put, parameters: parameters).validate(statusCode: 200...299).responseDecodable(of: Response.self) { response in
            if response.value?.status == 1 {
                success(response.value?.user!)
            } else {
                failure(response.value?.msg)
            }
        }
    }
    
    public func logoutRequest(success: @escaping (_ msg: String?)->(), failure: @escaping (_ msg: String?)->(), headers: HTTPHeaders) {     // headers = ["token": token]
        AF.request("http://kurokiji.com/api/employee/logout", method: .put, headers: headers).validate(statusCode: 200...299).responseDecodable(of: Response.self) { response in
            if response.value?.status == 1 {
                success(response.value?.msg)
            } else {
                failure(response.value?.msg)
            }
        }
    }
    
    public func sendMailRequest(success: @escaping (_ msg: String?)->(), failure: @escaping (_ msg: String?)->(), parameters: Parameters) {
        AF.request("http://kurokiji.com/api/passwordrecover", method: .put, parameters: parameters).validate(statusCode: 200...299).responseDecodable(of: Response.self) { response in
            if response.value?.status == 1 {
                success(response.value?.msg)
            } else {
                failure(response.value?.msg)
            }
        }
    }
    
    public func getUsersRequest(success: @escaping (_ users: [User]?)->(), failure: @escaping (_ msg: String?)->(), headers: HTTPHeaders) {     // headers = ["Token": token]
        AF.request("http://kurokiji.com/api/employee/getall", method: .get, headers: headers).validate(statusCode: 200...299).responseDecodable(of: Response.self) { response in
            if response.value?.status == 1 {
                success(response.value?.data)
            } else {
                failure(response.value?.msg)
            }
        }
    }
}
