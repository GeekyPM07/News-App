//
//  ViewController.swift
//  News IN
//
//  Created by PraTeek Mishra on 02/06/20.
//  Copyright © 2020 PraTeek Mishra. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
  
    @IBOutlet var tableView: UITableView!
    
    
    var networkManagerData = NetworkManager()
    
    var ApiKeyData = ApiKey()
    
//    let dataArray = [Post(title: "Testing Post 1", id: nil),
//                     Post(title: "Testing Post 2", id: "hindustan times - 1"),
//                     Post(title: "Testing Post 3", id: "times of india - 1")]
    
    var AllPostsArray = [PostData]()
    
    
    
    var AllPostsUIimages = [UIImage]()
    
 //   var finalImage: UIImage?
    //var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "News"
        
        //navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
       
        //networkManagerData.imgdelegate = self
        networkManagerData.delegate = self
        
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=in&apiKey=\(ApiKeyData.Key)"
        networkManagerData.performNetworking(urlLink: urlString)
        
        
        
        var timer1 = Timer.scheduledTimer(withTimeInterval: 5.50, repeats: false) { (timer) in
              
        //    print("Post Image: \(self.AllPostsUIimages) \n \n Post Title: \(self.AllPostsArray), \n \n ----------------------------------------------------------------------------------------------------------------------------")
              //print("\(self.AllPostsUIimages),\(self.AllPostsArray)")
              //self.AllPostsUIimages = self.networkManagerData.emptyArray
              print(self.AllPostsUIimages)
            
              print("count of array objects \(self.AllPostsArray.count)")
                
              print("count of UI Images is\(self.AllPostsUIimages.count)")
        
            
              self.tableView.dataSource = self
              self.tableView.delegate = self
        }
        
        
        //tableView.register(UINib(nibName: "ReusableCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
    } ///viewdidload ends.
}

// see: stackoverflow.com/questions/26542035/create-uiimage-with-solid-color-in-swift
extension UIColor {
        func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
            
            //Creating an image from an image renderer
            return UIGraphicsImageRenderer(size: size).image { rendererContext in
                self.setFill()
                rendererContext.fill(CGRect(origin: .zero, size: size))
            }
        }
    }
    



extension ViewController: NetworkManagerDelegate {
    
    func DataAllPosts(data: [PostData]) {
        
        AllPostsArray = data
        
        var count = 0
        
        for Post in AllPostsArray {
            
         //  Data(contentsOf:) method will download the contents of the url SYNCHRONOUSLY in the same thread the code is being executed, so do not invoke this in the main thread of your application.
            
            count += 1
            
            if let safeImgURLString = Post.urlToImage {
                
                do {
                    
                        var PostImgURL = URL(string: safeImgURLString)
                        if PostImgURL != nil {
                                var imgData = try Data(contentsOf: PostImgURL!)
                                var downloadedImage = UIImage(data: imgData)
                                AllPostsUIimages.append(downloadedImage!)
                        }
                    }
                   
                    catch {
                    
                    print("problem getting \(count)th image data..")
                    var emptyimage = UIColor.white.image(CGSize(width: 110, height: 70))
                    AllPostsUIimages.append(emptyimage)
                }
                
                
            } else {
                print("\(count)th Image URL String not found!!")
                var emptyimage = UIColor.white.image(CGSize(width: 110, height: 70))
                AllPostsUIimages.append(emptyimage)
            }
            
        }
    }
    
    func failedToRetreiveData(error: Error) {
    print(error)
    
    }
}

//ASYNCHRONOUS METHOD: execute multiple things at a time and you don't have to finish executing the current thing in order to move on to next one.

//                            count += 1
//
//                            print("\(count)th image: \n \n Post Title: \(Post.title), \n \n Post Image: \(Post.urlToImage) \n \n Post Image String Count: \(Post.urlToImage?.count) \n \n ")
//
//
//
//                            let imgURL = Post.urlToImage
//
//                                if let gotURL = imgURL {
//
//
//                                //    print("Retreived \(count)th image URL STRING \n \n")
//                                    ///Create URL
//                                    if let PostImgURL = URL(string: gotURL){
//
//                                        ///Create URL Session object
//                                        let session = URLSession(configuration: .default)
//
//                                        ///Give session a task  ///// Define a download task. The download task will download the contents of the URL as a Data object.
//                                        ///When the completion handler is called, we will have a UIImage downloaded from the web.
//                                        let task = session.dataTask(with: PostImgURL) { (Data, Resp, Error) in
//                                            ///Download has finished.
//                                            if let e = Error {
//                                                print("Error downloading image\(e.localizedDescription)")
//                                            } else {
//
//                                                if let imgData = Data {
//
//                                                    print("Image Data is: \(imgData)")
//
//
//
//                                                    ///Convert Data into image
//                                                    if let downloadedImg = UIImage(data: imgData){
//
//                                                        DispatchQueue.main.async {
//                                                            self.AllPostsUIimages.append(downloadedImg)
//                                                        }
//
//
//
//
//                                                        //self.imgdelegate?.imgFromWeb(image: emptyArray)
//
//                                                    }
//
//
//            //                                        if let dlImg = downloadedImg {
//            //                                            //print("Converting to \(count)th image successful calling delegate method now..")
//            //                                            print(dlImg)
//            //                                            self.imgdelegate?.imgFromWeb(image: dlImg)
//            //                                            //print("\(count)th Image sent to VC")
//            //                                            //print("----------------------------------------------------------------------------------------------------------------------------")
//            //                                        }
//                                                    else {
//                                                        print("Couldn't get image: Image is nil")
//                                                    }
//
//
//                                                    // } ///timer ends
//
//
//                                                } else {
//                                                    print("Didn't get any Image Data from completion handler")
//                                                }
//                                            }
//                                        } ///Closure ends
//
//
//
//                                        ///Starting the task
//                                        task.resume()
//
//                                    }
//
//
//
//
//
//                            }
//
//                        }
            
            
        
        
        //print(AllPostsArray)
        
        //print("ct is\(AllPostsArray.count)")
        //print("Presenting to you All Posts array \(AllPostsArray)")
        
        
    



//extension ViewController: ImageManagerDelegate {
//
//    func imgFromWeb(image: [UIImage]) {
//
//       AllPostsUIimages = image
//
//  }
//}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("Count is \(AllPostsArray.count)")
        return AllPostsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! ReusableCell
        newCell.PostLabel.text = AllPostsArray[indexPath.row].title
        newCell.PostImage.image = AllPostsUIimages[indexPath.row]
        
        return newCell
    }
}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row is: \(indexPath.row)")
        
        let urlToBePassed = AllPostsArray[indexPath.row].url
        
        var secondVC = VCWebView()
        secondVC.urlReceived = urlToBePassed
        navigationController?.pushViewController(secondVC, animated: true)
    }
}
