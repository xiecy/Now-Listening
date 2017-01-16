//
//  API Module.swift
//  Now Listening
//
//  Created by Clark on 1/12/17.
//  Copyright © 2017 Clark Xie. All rights reserved.
//

import Foundation

class APIModule: NSObject {
    
    static let sharedModule = APIModule()
    
    //API and user info
    let appKey = APP_KEY
    let apiSecret = API_SECRET
    var userAuth = USER_AUTH
    var data: [NSDictionary] = []
    var fTitle: String = "Loading..."
    var fArtist: String = "Loading..."
    
    var urlSession: URLSession?
    var dataTask: URLSessionDataTask?

    func upload (title: String?, artist: String?, index: Int, completionHandler: @escaping (Data)->Void, errorHandler: @escaping (Error)->Void) {
        var self_id: String
        //var f_id: String
        if (index == 0) {
            self_id = "5877aa811abe9fc334bb10ef"
            //f_id = "5877a8499bf867084e2b6783"
        } else {
            //f_id = "5877aa811abe9fc334bb10ef"
            self_id = "5877a8499bf867084e2b6783"
        }
        
        var request = NSMutableURLRequest()
        let urlStr = "https://baas.kinvey.com/appdata/\(appKey)/tracks/\(self_id as String)"
        request.url = URL(string: urlStr)
        request.httpMethod = "PUT"
        
        //let body: String? = track
        //let opt: JSONSerialization.WritingOptions? = .prettyPrinted
        let jsonBody = ["title": title, "artist": artist]
        
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: jsonBody as Any)
            request.httpBody = bodyData
            request.addValue(self.userAuth, forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            self.urlSession = URLSession.init(configuration: URLSessionConfiguration.default)
            self.dataTask = self.urlSession!.dataTask(with: request as URLRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in print ("upload request completed")
                //data and response
                if let failure = error {
                    errorHandler(failure)
                } else {
                    completionHandler(data!)
                }
            })
            self.dataTask?.resume()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func retrieve (index: Int, completionHandler: @escaping (Data)->Void, errorHandler: @escaping (Error)->Void) {
        //var self_id: String
        var f_id: String
        if (index == 0) {
            //self_id = "5877aa811abe9fc334bb10ef"
            f_id = "5877a8499bf867084e2b6783"
        } else {
            f_id = "5877aa811abe9fc334bb10ef"
            //self_id = "5877a8499bf867084e2b6783"
        }
        
        var request = NSMutableURLRequest()
        let urlStr = "https://baas.kinvey.com/appdata/\(appKey)/tracks/\(f_id as String)"
        print(urlStr)
        request.url = URL(string: urlStr)
        request.httpMethod = "GET"
        
        do {
            //let bodyData = try JSONSerialization.data(withJSONObject: jsonBody as Any)
            //request.httpBody = bodyData
            request.addValue(self.userAuth, forHTTPHeaderField: "Authorization")
            //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            self.urlSession = URLSession.init(configuration: URLSessionConfiguration.default)
            self.dataTask = self.urlSession!.dataTask(with: request as URLRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in print ("retrieve request completed")
                //data and response
                if let failure = error {
                    errorHandler(failure)
                } else {
                    completionHandler(data!)
                }
            })
            self.dataTask?.resume()
        }
    }
    
}
