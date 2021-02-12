//
//  Provider.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 10/02/2021.
//

import Foundation
import Alamofire

class Provider {
    
    
    //MARK: Public implementation
    func request(from url: String,params:[String:Any] ,success: @escaping ([String:Any]) -> Void, failure:@escaping (NSError) -> Void ) {
        
        if !isConnectedToInternet() {
            failure(NSError(domain: "Sin conexión a internet", code:ErrorConstants.errorCodes.noInternet.rawValue, userInfo: nil))
        }
        
        var urlString = "\(ProviderConstants.baseUrl)\(url)\(ProviderConstants.apiKey)"
        
        for (key, value) in params {
            urlString.append("&\(key)=\(value)")
        }
        

        guard let encodedUrl:URLConvertible = URL(string: urlString) else {
            failure (NSError(domain: "Url erronea", code: ErrorConstants.errorCodes.invalidUrl.rawValue, userInfo: nil))
            return
        }
        
        
        
        AF.request(encodedUrl, method: .get , parameters: nil , encoding: JSONEncoding.default).responseJSON{ response in
            
            switch response.result {
                
                case .success(let value):
                    
                    guard let mdict = value as? NSDictionary, let jsonData = mdict["data"] as? [String:Any] else {
                        failure(NSError(domain: "Error al recuperar los personajes", code: ErrorConstants.errorCodes.fetchedDataError.rawValue, userInfo: nil))
                        return
                    }
                    
                    success(jsonData)

                case .failure:
                    failure(NSError(domain: "Error al recuperar los personajes", code: ErrorConstants.errorCodes.serviceError.rawValue, userInfo: nil))
            }
            
        }
    }
    
    func getImage(fromUrl url: String, success: @escaping (UIImage) -> Void) {
        
        guard let encodedUrl: URLConvertible = URL(string: url) else { return }
        
        AF.request(encodedUrl, method: .get).response { response in
            
            switch response.result {
                
                case .success(let value):
                    
                    if let value = value, let image = UIImage(data: value) {
                            success(image)
                    }
                    
                case .failure:
                    break
            }
            
        }
    }
    
    private func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    

}
