import Foundation

class NetworkManager {
private init() {}

static let shared = NetworkManager()

    let scheme = "https"
    let host = "openlibrary.org"
    
    func getBooks(complition: @escaping ((BooksModel?) -> ())) {
        
        var component: URL? {
            var urlComponents = URLComponents()
            urlComponents.scheme = scheme
            urlComponents.host = host
            urlComponents.path = "/subjects/love.json"
            return urlComponents.url
        }
        
        if let url = component {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil, let data = data {
                    do {
                        if let _ = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                            print()
                            let object = try JSONDecoder().decode(BooksModel.self, from: data)
                            print()
                            complition(object)
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getBook(key: String, complition: @escaping ((BookModel?) -> ())) {
        
        var component: URL? {
            var urlComponents = URLComponents()
            urlComponents.scheme = scheme
            urlComponents.host = host
            urlComponents.path = "\(key).json"
            return urlComponents.url
        }
        
        if let url = component {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil, let data = data {
                    do {
                        if let _ = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                            print()
                            let object = try JSONDecoder().decode(BookModel.self, from: data)
                            print()
                            complition(object)
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getRatingsBook(key: String, complition: @escaping ((RatingsBookModel?) -> ())) {
        
        var component: URL? {
            var urlComponents = URLComponents()
            urlComponents.scheme = scheme
            urlComponents.host = host
            urlComponents.path = "\(key)/ratings.json"
            return urlComponents.url
        }
        
        if let url = component {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil, let data = data {
                    do {
                        if let _ = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                            print()
                            let object = try JSONDecoder().decode(RatingsBookModel.self, from: data)
                            print()
                            complition(object)
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
}
