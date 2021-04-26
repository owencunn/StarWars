//
//  NetworkService.swift
//  StarWars
//
//  Created by Owen Cunningham on 2021/04/06.
//

import Foundation

typealias OnApiSuccess = (People) -> Void

class NetworkService {
    static let shared = NetworkService()  //singleton
    
    let URL_BASE = "https://swapi.dev/api"
    let URL_PEOPLE = "/people/"
    let URL_PERSON_MP = ""
    
    
    let session = URLSession(configuration: .default)
    
    func getPeople(onSuccess: @escaping (People) -> Void, onError: @escaping (String) -> Void, urlStringType: String ) {
        //let url = URL(string: "\(URL_BASE)\(URL_PEOPLE)")!
        let url = URL(string: "\(urlStringType)")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            //debugPrint(data)
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data for response")
                    return
                }
                
                do {
                    //print("Status code: \(response.statusCode)")
                    if response.statusCode == 200 {
                        let people = try JSONDecoder().decode(People.self, from: data)
                        //SUCCESS
                        onSuccess(people)
                    } else { //error 400
                        debugPrint("Error 400??")
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError(err.detail)
                    }
                } catch {
                    debugPrint(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func getPlanet(onSuccess: @escaping (Planet) -> Void, onError: @escaping (String) -> Void, urlStringType: String) {
        let url = URL(string: "\(urlStringType)")!
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data for response")
                    return
                }
                
                do {
                    //print("Status code: \(response.statusCode)")
                    if response.statusCode == 200 {
                        let planet = try JSONDecoder().decode(Planet.self, from: data)
                        //SUCCESS
                        onSuccess(planet)
                    } else { //error 400
                        debugPrint("Error 400??")
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError(err.detail)
                    }
                } catch {
                    debugPrint(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
        
}




