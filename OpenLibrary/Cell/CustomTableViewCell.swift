import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var firstPublishYearLabel: UILabel!
    @IBOutlet private weak var coverImage: UIImageView!
    
    let url = "https://covers.openlibrary.org/b/olid/"
    
    func config (name title: String, publish firstPublish: Int, image cover: String) {
        self.titleLabel.text = title
        self.firstPublishYearLabel.text = "Впервые опубликовано в \(firstPublish)"
        self.coverImage.downloaded(from: "\(self.url)\(cover)-M.jpg")
    }
}
