//
//  ShootAPI.swift
//  shootingMap
//
//  Created by Benjamin Rogers on 7/9/23.
//
// Class to handle API calls to backend i.e. get tokens and JSON data
// Decode JSON to native swift objects for use by MapKit API
import Foundation

class shootAPI {
    var token: String?
    
    func callAPIWithBasicAuth(urlString: String, username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        let authString = "\(username):\(password)"
        let authData = authString.data(using: .utf8)
        let base64AuthString = authData?.base64EncodedString()
        let authHeaderValue = "Basic \(base64AuthString ?? "")"
        request.setValue(authHeaderValue, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }
            let decoder = JSONDecoder()
            let token = try! decoder.decode(Token.self, from:data)
            if var resultString = String(data: data, encoding: .utf8) {
                resultString = token.token
                completion(.success(resultString))
            } else {
                completion(.failure(NSError(domain: "InvalidResponse", code: 0, userInfo: nil)))
            }
        }
        
        task.resume()
    }
    
    func fetchAccessToken() -> String? {
        let apiUrl = Bundle.main.object(forInfoDictionaryKey: "apiLoginUrl") as! String

        let username = Bundle.main.object(forInfoDictionaryKey: "apiUsername") as! String
        let password = Bundle.main.object(forInfoDictionaryKey: "apiPassword") as! String
        
        var fetchedToken: String?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        callAPIWithBasicAuth(urlString: apiUrl, username: username, password: password) { result in
            switch result {
            case .success(let token):
                fetchedToken = token
            case .failure(let error):
                print("Error: \(error)")
            }
            semaphore.signal()
        }
        
        semaphore.wait()
        return fetchedToken
    }
    
    // Make call to backend with an access token
    func callAPIWithAccessToken(urlString: String, accessToken: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(accessToken, forHTTPHeaderField: "x-access-token")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }
            if String(data: data, encoding: .utf8) != nil {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "InvalidResponse", code: 0, userInfo: nil)))
            }
        }
        
        task.resume()
    }
    
    // Fetch all people from backend
    func fetchAPIPerson() -> Peoples? {
        let apiUrl = Bundle.main.object(forInfoDictionaryKey: "apiPersonUrl") as! String
        
        let accessToken = fetchAccessToken()
        let semaphore = DispatchSemaphore(value: 0)
        
        var personArray: Peoples?
        
        if accessToken != nil {
            callAPIWithAccessToken(urlString: apiUrl, accessToken: accessToken!) {result in
                switch result {
                case .success(let jsonData):
                    print("Token: \(jsonData)")
                    let decoder = JSONDecoder()
                    personArray = try! decoder.decode(Peoples.self, from:jsonData)
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
                semaphore.signal()
            }
        }
        semaphore.wait()
        return personArray
    }
    
    // Fetch a single person from backend with ID using access token. Return person object
    func fetchAPISinglePerson(id: Int) -> Persons? {
        let apiBaseUrl = Bundle.main.object(forInfoDictionaryKey: "apiPersonUrl") as! String // domain/person url
        var apiUrl = "\(apiBaseUrl)/\(id)"
        
        let accessToken = fetchAccessToken()
        let semaphore = DispatchSemaphore(value: 0)
        var person: Persons?
        
        if accessToken != nil {
            callAPIWithAccessToken(urlString: apiUrl, accessToken: accessToken!) {result in
                switch result {
                case .success(let jsonData):
                    print("Token: \(jsonData)")
                    print(type(of: jsonData))
                    let decoder = JSONDecoder()
                    person = try! decoder.decode(Persons.self, from:jsonData)
                case .failure(let error):
                    print("Error: \(error)")
                }
                semaphore.signal()
            }
        }
        semaphore.wait()
        return person
    }
    
    // Parameterized query to backend with access token. Return Peoples object
    func fetchAPIParamPerson(flee: String , armed: String, city: String, state: String, race: String, gender: String, dateRangeLeading: Int, dateRangeTrailing: Int) -> Peoples? {
        let apiBaseUrl = Bundle.main.object(forInfoDictionaryKey: "apiPersonUrl") as! String // domain/person url
        var apiUrl = "\(apiBaseUrl)/params?"
        let accessToken = fetchAccessToken()
        let semaphore = DispatchSemaphore(value: 0)
        
        var personArray: Peoples?
        if (flee != "") {
            apiUrl += "&flee=\(flee)"
        }
        
        if (armed != "") {
            apiUrl += "&armed=\(armed)"
        }
        if (city != "") {
            apiUrl += "&city=\(city)"
        }
        
        if (state != "") {
            apiUrl += "&state=\(state)"
        }
        
        if (race != "any") {
            if (race == "white") {
                apiUrl += "&race=W"
            }
            if (race == "black") {
                apiUrl += "&race=B"
            }
            if (race == "asian") {
                apiUrl += "&race=A"
            }
            if (race == "nativeAmerican") {
                apiUrl += "&race=N"
            }
            if (race == "hispanic") {
                apiUrl += "&race=H"
            }
            if (race == "other") {
                apiUrl += "&race=O"
            }
        }
        if (gender != "") {
            apiUrl += "&gender=\(gender)"
        }
        
        apiUrl += "&ldate=\(dateRangeLeading)&tdate=\(dateRangeTrailing)"
            
        
        if accessToken != nil {
            callAPIWithAccessToken(urlString: apiUrl, accessToken: accessToken!) {result in
                switch result {
                case .success(let jsonData):
                    
                    let decoder = JSONDecoder()
                    personArray = try! decoder.decode(Peoples.self, from:jsonData)
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
                semaphore.signal()
            }
        }
        semaphore.wait()
        return personArray
    }
    
    // Fetch list of agencies based on given ID's.
    // Maybe expand available parameters?
    func fetchAPIParamAgency(id_list: [String]) -> Agencies? {
        let apiBaseUrl = Bundle.main.object(forInfoDictionaryKey: "apiAgencyUrl") as! String // domain/person url
        var apiUrl = "\(apiBaseUrl)/params?"
        let accessToken = fetchAccessToken()
        let semaphore = DispatchSemaphore(value: 0)
        
        var agencyArray: Agencies?
        for id in id_list {
            apiUrl += "&id=\(id)"
        }
        
        if accessToken != nil {
            callAPIWithAccessToken(urlString: apiUrl, accessToken: accessToken!) {result in
                switch result {
                case .success(let jsonData):
                    
                    let decoder = JSONDecoder()
                    agencyArray = try! decoder.decode(Agencies.self, from:jsonData)
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
                semaphore.signal()
            }
        }
        semaphore.wait()
        return agencyArray
    }
}
