import Foundation

class WorkModel: Decodable {
    
    var key: String
    var title: String
    var first_publish_year: Int
    var cover_edition_key: String
    init(key: String, title: String, first_publish_year: Int, cover_edition_key: String) {
        self.key = key
        self.title = title
        self.first_publish_year = first_publish_year
        self.cover_edition_key = cover_edition_key
    }
}
