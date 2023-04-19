import Foundation

class BookModel: Decodable {
    var title: String
    var description: String?
    var covers: [Int]
    var first_publish_date: String?

    
    init(title: String, description: String?, covers: [Int], first_publish_date: String?) {
        self.title = title
        self.description = description
        self.covers = covers
        self.first_publish_date = first_publish_date
    }
}
