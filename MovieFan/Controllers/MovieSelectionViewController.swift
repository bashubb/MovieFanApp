import UIKit

class MovieSelectionViewController: UIViewController {
    private var movies: [Movie] = []
    private var tableView: UITableView!
    private var isRatingMode = false
    private var isCompareMode = false
    private var selectedMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        setupNavigationBar()
        setupTableView()
        
        loadMovies()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        setUpRightNavButton()
        setUpLeftNavButton()
    }
    
    private func setUpRightNavButton() {
        var modeTitle = ""
        if isRatingMode {
            modeTitle = "Movie Details"
        } else {
            modeTitle = "Rating Mode"
        }
        
        if isCompareMode == false {
            let switchModeButton = UIBarButtonItem(title: modeTitle, style: .plain, target: self, action: #selector(switchMode))
            navigationItem.rightBarButtonItem = switchModeButton
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }

    private func setUpLeftNavButton() {
        var compareTitle = ""
        if isCompareMode {
            compareTitle = "Single Mode"
        } else {
            compareTitle = "Compare Mode"
        }
        
        let compareButton = UIBarButtonItem(title: compareTitle, style: .plain, target: self, action: #selector(compareSelectMode))
        navigationItem.leftBarButtonItem = compareButton
    }
    
    @objc private func switchMode() {
        isRatingMode.toggle()
        setupNavigationBar()
        tableView.reloadData()
    }
    
    @objc private func compareSelectMode() {
        isCompareMode.toggle()
        setupNavigationBar()
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func loadMovies() {
        movies = [
            Movie(title: "Movie 1", coverImageName: "cover1", description: "Description 1", averageRating: 0),
            Movie(title: "Movie 2", coverImageName: "cover2", description: "Description 2", averageRating: 0)
        ]
        
        // Update average ratings
        for index in movies.indices {
            movies[index].averageRating = MovieRatingManager.shared.getAverageRating(for: movies[index])
        }
    }
}

extension MovieSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = "Rating: \(MovieRatingManager.shared.getAverageRating(for: movie))"
        cell.imageView?.image = UIImage(named: movie.coverImageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        if isCompareMode {
            selectedMovies.append(movie)
            if selectedMovies.count == 2 {
                let ratingVC = MovieRatingViewController(movie1: selectedMovies[0], movie2: selectedMovies[1])
                navigationController?.pushViewController(ratingVC, animated: true)
                selectedMovies.removeAll()
            }
        } else {
            let detailsVC = MovieDetailsViewController(movie: movie)
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}
