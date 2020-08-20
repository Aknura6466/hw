//
//  HolidayRequest.swift
//  Hw
//
//  Created by Акнур on 8/20/20.
//  Copyright © 2020 Акнур. All rights reserved.
//

import Foundation
enum HolidayError: Error {
    case noDataAvailable
    case canNotProcessData
}
struct HolidayRequest {
    let resourceURL : URL
    let API_KEY = "9a423a36fe1dbc050cc7aea2d850b0a22271b897"
    
    init(countryCode : String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyy"
        let currentYear = format.string(from: date)
        let resourseString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=2019"
        
        guard let resourceUrl = URL(string: resourseString) else {fatalError()}
        self.resourceURL=resourceURL
        
    }
    func getHolidays (compleion: @escaping(Result<[HolidayDetail], HolidayError>)-> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, _, _) in
            guard  let jsonData = data else {
                compleion(.failure(.noDataAvailable))
                return
            }
            do{
                let decoder = JSONDecoder()
                let holidayResponse = try
                    decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = HolidayResponse.response.holidays
                compleion(.success(holidayDetails))
            }catch{
                compleion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}
