//
//  NetworkManager.swift
//  News IN
//
//  Created by PraTeek Mishra on 02/06/20.
//  Copyright © 2020 PraTeek Mishra. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkManagerDelegate {
    
    func DataAllPosts(data: [PostData])
    
    func failedToRetreiveData(error: Error)
    
}

//protocol ImageManagerDelegate {
//
//    func imgFromWeb(image: [UIImage])
//
//}


class NetworkManager {
    
    var delegate: NetworkManagerDelegate?
    
    //var imgdelegate: ImageManagerDelegate?
    
    var emptyArray = [UIImage]()
    
    func performNetworking(urlLink: String){
        
        ///1. create url
        
        if let url = URL(string: urlLink){
            
            print("Got URL String \(urlLink)")
            ///Create a url session
            
            let session = URLSession(configuration: .default)
            
            print("Created URL Session")
            ///Give session a task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                print("Inside task")
                
                if error != nil {
                    
                    print(error!.localizedDescription)
                    self.delegate?.failedToRetreiveData(error: error!)
                    
                    return
                    
                }
                
                print("Got some data back from completion handler")
                if let safeData = data{
                    //print("Here is the data in JSON Format: \(safeData)")
                    
                    let finalData = self.parseJSON(DATA: safeData)
                    self.delegate?.DataAllPosts(data: finalData)
                    
                    //self.DownloadImage(Data: safeData)
                    
                }
            }  ///Closure ends.
            
            
            ///Resume task
            
            task.resume()
            print("Task Resumed")
            
        }
    }
    
    func parseJSON(DATA: Data) -> [PostData]{
        
        print("Parsing the JSON Data in form of Swift Objects.")
        
        let decoder = JSONDecoder()
        do {
            
            let result = try decoder.decode(NewsData.self, from: DATA)
            //print("Result is \(result)")
            
            let PostArrObjects = result.articles
            //let vr = result.articles[0].url
            
            //var count = 0
            
            
            
            
            //print("Array of PostData objects")
            
            return PostArrObjects
            
        } catch {
            
            print("Inside catch block")
            
            print(error)
            
            return [PostData]()
        }
    }
    
}





//    func DownloadImage(Data: Data) {
//
//        let decoder = JSONDecoder()
//        do {
//
//            let decodedData = try decoder.decode(NewsData.self, from: Data)
//            let PostArrObjects = decodedData.articles
//
//
//
//
//    }           catch {
//
//            print("Inside catch block")
//
//            print(error)
//
//            //return [PostData]()
//        }
//
//    }

