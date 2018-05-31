//
//  ViewController.swift
//  ParsingJSON
//
//  Created by willix on 30/05/18.
//  Copyright © 2018 willix. All rights reserved.
//

import UIKit

struct WebsiteDescription: Decodable {
    let name: String
    let description: String
    let courses: [Course]
}

struct Course: Decodable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
    
    //        init(json: [String: Any]) {
    //            id = json["id"] as? Int ?? -1
    //            name = json["name"] as? String ?? ""
    //            link = json["link"] as? String ?? ""
    //            imageUrl = json["imageUrl"] as? String ?? ""
    //        }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //also perhaps check response status 200 ok
            
            guard let data = data else { return }
            
            //let dataAsString = String(data: data, encoding: .utf8)
            //print(dataAsString!)
            
            do {
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(websiteDescription.name, websiteDescription.description)
                
                //let courses = try JSONDecoder().decode([Course].self, from: data)
                //print(courses)
                
                //swift 2/3 objC
                //guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                
                //let course = Course(json: json)
                //print(course.name)
                //print(json)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
        }.resume()
        
        //let myCourse = Course(id: 1, name: "my course", link: "some link", imageUrl: "some image url")
        //print(myCourse)
    }
}

