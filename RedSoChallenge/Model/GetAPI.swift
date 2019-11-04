//
//  GetAPI.swift
//  RedSoChallenge
//
//  Created by Henry on 2019/11/4.
//  Copyright © 2019 Henry. All rights reserved.
//

import Foundation



class APIManager {
    
    static func getTeam(team: String, page: Int, completion: @escaping ([Staff.Result]) -> Void ) {
        guard let url = URL(string: "https://us-central1-redso-challenge.cloudfunctions.net/catalog?team=\(team)&page=\(page)") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                dprint(error!.localizedDescription)
                return
            }
            guard let data = data else { return }
//            dprint(data.prettyPrintedJSONString!)
            do {
                let staff = try JSONDecoder().decode(Staff.self, from: data)
                completion(staff.results)
            } catch {
                dprint(error.localizedDescription)
            }
        }.resume()
    }
    
}


//https://gist.github.com/cprovatas/5c9f51813bc784ef1d7fcbfb89de74fe
extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

//print 檔案,行數,function
//https://gist.github.com/ytyubox/80535e8a829382acc2c861e756155db8
func dprint(_ objects:Any..., separator: String = " ", terminator: String = "\n",file:String = #file,line:Int = #line, function:String = #function){
    #if DEBUG
    print((file).split(separator: "/").last!,line.description + ":",function)
    print("🙋🏼‍♂️Debug info:  \n\t", terminator: "")
    for i in objects{
        print(i, separator: "", terminator: separator)
    }
    print(terminator)
    #endif
}
