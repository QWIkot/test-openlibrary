import UIKit

class SecondViewController: UIViewController {
    //MARK: - outlets
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var firstPublishLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var coverImage: UIImageView!
    @IBOutlet private weak var ratingsLabel: UILabel!
    //MARK: - let
    let url = "https://covers.openlibrary.org/b/id/"
    //MARK: - var
    var key: String = ""
    var bookModel: BookModel?
    var index = 0
    //MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSwipeSettings()
        self.getBookRequest()
        self.getRatingsRequest()
    }
    //MARK: - IBActions
    @IBAction func leftSwipeDetected (_ sender: UISwipeGestureRecognizer) {
        if self.bookModel?.covers.count ?? Int() > 1 {
            self.moveImageLeft()
        }
    }
    
    @IBAction func rightSwipeDetected (_ sender: UISwipeGestureRecognizer) {
        if self.bookModel?.covers.count ?? Int() > 1 {
            self.moveImageRight()
        }
    }
    //MARK: - flow funcs
    private func getBookRequest() {
        NetworkManager.shared.getBook(key: self.key) { (model) in
            if model != nil {
                self.bookModel = model
                DispatchQueue.main.async {
                    self.titleLable.text = self.bookModel?.title
                    self.descriptionLabel.text = self.bookModel?.description
                    self.firstPublishLabel.text = "Первая публикация: \(self.bookModel?.first_publish_date ?? String())"
                    self.loadImage(self.coverImage)
                }
            }
        }
    }
    private func getRatingsRequest() {
        NetworkManager.shared.getRatingsBook(key: self.key) { (model) in
            if let ratings = model {
                DispatchQueue.main.async {
                    self.ratingsLabel.text = "Средняя оценка пользователей: \(NSString(format: "%.2f", ratings.summary.average)) /\(ratings.summary.count) Оценок"
                }
            }
        }
    }
    
    private func loadImage(_ imageView: UIImageView) {
        imageView.downloaded(from: "\(self.url)\(bookModel?.covers[self.index] ?? Int())-M.jpg")
    }
    
    private func nextIndexPicture() {
        guard let count = self.bookModel?.covers.count else {return}
        if self.index == count - 1 {
            self.index = 0
        } else {
            self.index += 1
        }
    }
    
    private func backIndexPicture() {
        guard let count = self.bookModel?.covers.count else {return}
        if self.index == 0 {
            self.index = count - 1
        } else {
            self.index -= 1
        }
    }
    
    private func createImageView (x: CGFloat) -> UIImageView {
        let newImageView = UIImageView()
        newImageView.frame = CGRect(x: x,
                                    y: 0,
                                    width: self.coverImage.frame.size.width ,
                                    height: self.coverImage.frame.size.height)
        newImageView.contentMode = .scaleAspectFill
        newImageView.clipsToBounds = true
        self.loadImage(newImageView)
        self.coverImage.addSubview(newImageView)
        return newImageView
    }
    
    private func animateImage(_ newImageView: UIImageView, finish: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            newImageView.frame.origin.x -= finish
        } completion: { (_) in
            self.coverImage.image = newImageView.image
            newImageView.removeFromSuperview()
        }
    }
    
    private func moveImageRight() {
        self.backIndexPicture()
        let newImageView = self.createImageView(x: -self.coverImage.frame.size.width)
        self.animateImage(newImageView, finish: -self.coverImage.frame.size.width)
    }
    
    private func moveImageLeft() {
        self.nextIndexPicture()
        let newImageView = self.createImageView(x: self.coverImage.frame.size.width)
        self.animateImage(newImageView, finish: self.coverImage.frame.size.width)
    }
    
    private func setupSwipeSettings() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeDetected(_:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeDetected(_:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
    }
}
