//
//  WeatherRetriever.swift
//  TrackEr
//
//  Created by Ashwin Aggarwal on 3/12/17.
//  Copyright © 2017 Ashwin Aggarwal. All rights reserved.
//

import Foundation

class WeatherRetriever {
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "c3fa92aa7fd54f53c4aa3828a8f9d9c8"
    // in F
    var temperature : Double = 0.0
    
    func getWeather(city: String) {
        
        // This is a pretty simple networking task, so the shared session will do.
        let session = URLSession.shared
        
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
        
        // The data task retrieves the data.
        let dataTask = session.dataTask(with: weatherRequestURL, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                // Case 1: Error
                // We got some kind of error while trying to get data from the server.
                print("Error:\n\(error)")
            }
            else {
                // Case 2: Success
                // We got a response from the server!
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    if let weather_details = jsonObj?.value(forKey: "main") as? NSArray {
                        for item in weather_details {
                            if let itemDict = item as? NSDictionary {
                                if let temp = itemDict.value(forKey: "temp") { // usernames
                                    self.temperature = temp as! Double
                                }
                                
                            }
                        }

                    }
                        
                }

            }
        })

        // The data task is set up...launch it!
        dataTask.resume()
    }
}
