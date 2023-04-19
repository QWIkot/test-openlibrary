import Foundation

class BooksModel: Decodable {
    
    var works: [WorkModel]
    
    init(works: [WorkModel]) {
        self.works = works
    }
}
