import Foundation

class SummaryModel: Decodable {
    
    var average: Double
    var count: Int
    
    init(average: Double, count: Int) {
        self.average = average
        self.count = count
    }
}
