//
//  API Module.swift
//  Now Listening
//
//  Created by Clark on 1/12/17.
//  Copyright © 2017 Clark Xie. All rights reserved.
//

import Foundation

class APIModule: NSObject {
    
    //API and user info
    let appKey = "kid_B1GY52NLe"
    let apiSecret = "3074121c6dd34b7ebf1bb6f72a2cbde0"
    var user: NSString? = "Basic a2lkX0IxR1k1Mk5MZTpjYTU2ZmFmZGNhZDU0NGUzYjk1ZDAxNWI4NTBhYzZlZg=="
    var data: [NSDictionary] = []
    var fTitle: String = "Loading..."
    
    var urlSession: URLSession?
    var dataTask: URLSessionDataTask?

    static let sharedModule = APIModule()
/*
    func login (completionHandler: @escaping (Data)->Void, errorHandler: @escaping (Error)->Void) {
        let username = "test_user"
        let password = "12345678"
        
        var request = NSMutableURLRequest()
        let urlStr = "https://baas.kinvey.com/user/\(appKey)/login"
        request.url = URL(string: urlStr)
        request.httpMethod = "POST"
        
        //let body: String? = track
        //let opt: JSONSerialization.WritingOptions? = .prettyPrinted
        let jsonBody = ["username": username, "password": password]
        
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: jsonBody as Any)
            request.httpBody = bodyData
            request.addValue(self.user as! String, forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            self.urlSession = URLSession.init(configuration: URLSessionConfiguration.default)
            self.dataTask = self.urlSession!.dataTask(with: request as URLRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in print ("request completed")
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
*/
    func upload (track: String?, index: Int, completionHandler: @escaping (Data)->Void, errorHandler: @escaping (Error)->Void) {
        var self_id: String
        var f_id: String
        if (index == 0) {
            self_id = "5877aa811abe9fc334bb10ef"
            f_id = "5877a8499bf867084e2b6783"
        } else {
            f_id = "5877aa811abe9fc334bb10ef"
            self_id = "5877a8499bf867084e2b6783"
        }
        
        var request = NSMutableURLRequest()
        let urlStr = "https://baas.kinvey.com/appdata/\(appKey)/tracks/\(self_id as String)"
        request.url = URL(string: urlStr)
        request.httpMethod = "PUT"
        
        //let body: String? = track
        //let opt: JSONSerialization.WritingOptions? = .prettyPrinted
        let jsonBody = ["title": track]
        
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: jsonBody as Any)
            request.httpBody = bodyData
            request.addValue(self.user as! String, forHTTPHeaderField: "Authorization")
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
        var self_id: String
        var f_id: String
        if (index == 0) {
            self_id = "5877aa811abe9fc334bb10ef"
            f_id = "5877a8499bf867084e2b6783"
        } else {
            f_id = "5877aa811abe9fc334bb10ef"
            self_id = "5877a8499bf867084e2b6783"
        }
        
        var request = NSMutableURLRequest()
        let urlStr = "https://baas.kinvey.com/appdata/\(appKey)/tracks/\(f_id as String)"
        print(urlStr)
        request.url = URL(string: urlStr)
        request.httpMethod = "GET"
        
        //let body: String? = track
        //let opt: JSONSerialization.WritingOptions? = .prettyPrinted
        //let jsonBody = ["title": track]
        
        do {
            //let bodyData = try JSONSerialization.data(withJSONObject: jsonBody as Any)
            //request.httpBody = bodyData
            request.addValue(self.user as! String, forHTTPHeaderField: "Authorization")
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
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
