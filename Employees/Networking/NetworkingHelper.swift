
import Foundation

class NetworkingHelper {
    
    public func loginRequest(success: @escaping (_ user: User?)->(), failure: @escaping (_ msg: String?)->(), parameters: Parameters) {
        AF.request("http://kurokiji.com/api/login", method: .put, parameters: parameters).responseDecodable(of: Body.self) { response in
            if response.value?.status == 1 {
                success(response.value?.user!)
            } else {
                failure(response.value?.msg)
            }
        }
    }

    
}
