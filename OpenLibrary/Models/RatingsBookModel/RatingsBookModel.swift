import Foundation

class RatingsBookModel: Decodable {
    
    var summary: SummaryModel
    
    init(summary: SummaryModel) {
        self.summary = summary
    }
}
