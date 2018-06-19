//
//  APIService.swift
//  EzParseandCoreData
//
//  Created by MacMiniCorei5-26Ghz on 6/18/18.
//  Copyright © 2018 GVN. All rights reserved.
//

import UIKit

class APIService: NSObject {
    let baseUrl : String! = "http://worldcup.thienthan.vn/v1/groups"
    
    func getData(completion: @escaping (_ any: Groups) -> Void) {
        var urlRequest = URLRequest(url: URL(string: baseUrl)!)        
        urlRequest.httpMethod = "GET"
        let getDataSession = URLSession.shared
        
        getDataSession.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let responseHTTP = response as? HTTPURLResponse{
                    if responseHTTP.statusCode == 200 {
                        guard let data = data else {
                            print("Error: No data to decode")
                            return
                        }
                        
                        guard let datas = try? JSONDecoder().decode(Datas.self, from: data) else {
                            print("Error: Couldn't decode data into Group")
                            return
                        }
                        completion(datas.datas)
                    } else {
                        print(responseHTTP.statusCode)
                    }
                } 
            }
        }.resume()
    }
}
