//
//  ViewController.swift
//  ParsingJSON
//
//  Created by willix on 30/05/18.
//  Copyright © 2018 willix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct Course {
        let id: Int
        let name: String
        let link: String
        let imageUrl: String
        
        init(json: [String: Any]) {
            id = json["id"] as? Int ?? -1
            name = json["name"] as? String ?? ""
            link = json["link"] as? String ?? ""
            imageUrl = json["imageUrl"] as? String ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/course"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //also perhaps check response status 200 ok
            
            guard let data = data else { return }
            
            //let dataAsString = String(data: data, encoding: .utf8)
            //print(dataAsString!)
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                
                let course = Course(json: json)
                print(course.name)
                //print(json)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
        }.resume()
        
        //let myCourse = Course(id: 1, name: "my course", link: "some link", imageUrl: "some image url")
        //print(myCourse)
    }
}

