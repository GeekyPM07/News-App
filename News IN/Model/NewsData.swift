//
//  NewsData.swift
//  News IN
//
//  Created by PraTeek Mishra on 02/06/20.
//  Copyright © 2020 PraTeek Mishra. All rights reserved.
//

import Foundation


struct NewsData: Codable {
    
    ///Array of PostData Struct Objects.
    var articles: [PostData]   /// [PostData(title: "Data...from API", url: "", urlImage: "")]
    
    
}

struct PostData: Codable {

    
    let title: String?
    let url: String?
    let urlToImage: String?
}



