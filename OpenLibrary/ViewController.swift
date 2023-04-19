import UIKit

class ViewController: UIViewController {
    //MARK: - outlets
    @IBOutlet private weak var bookTableView: UITableView!
    //MARK: - var
    var bookModel: BooksModel?
    var key: String = ""
    var arrayCovers: [UIImage] = []
    //MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getRequest()
    }
    //MARK: - flow funcs
    private func getRequest() {
        NetworkManager.shared.getBooks() { (model) in
            if model != nil {
                DispatchQueue.main.async {
                    self.bookModel = model
                    self.bookTableView.reloadData()
                }
            }
        }
    }
    
    func navigation() {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {
            return
        }
        controller.key = self.key
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
//MARK: - extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let books = self.bookModel {
            return books.works.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell else {
            return UITableViewCell()
        }
        if let books = self.bookModel {
            cell.config(name: books.works[indexPath.row].title,
                        publish: books.works[indexPath.row].first_publish_year,
                        image: books.works[indexPath.row].cover_edition_key)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let books = self.bookModel {
            self.key = books.works[indexPath.row].key
            self.navigation()
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleToFill) {
        contentMode = mode
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                    self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
