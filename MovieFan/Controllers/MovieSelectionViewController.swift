import UIKit

class MovieSelectionViewController: UIViewController {
    private var movies: [MovieModel] = []
    
    private var tableView: UITableView!
    private var starRatingView: StarRatingView!
    
    private var isRatingMode = false
    private var isCompareMode = false
    private var selectedMovies: [MovieModel] = []
    
    var movieManager = MovieDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieManager.delegate = self
        movieManager.fetchMovies()
        
        title = "Movies"
        setupNavigationBar()
        setupTableView()
        
    }
    
    //MARK: - NavigationBar setUp
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        setUpRightNavButton()
        setUpLeftNavButton()
        selectedMovies.removeAll()
    }
    
    private func setUpRightNavButton() {
        var modeTitle = ""
        if isRatingMode {
            modeTitle = "Movie Details"
        } else {
            modeTitle = "Rating Mode"
        }
        
        if isCompareMode == false {
            let switchModeButton = UIBarButtonItem(title: modeTitle, style: .plain, target: self, action: #selector(switchRatingMode))
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
    
    @objc private func switchRatingMode() {
        isRatingMode.toggle()
        setupNavigationBar()
        tableView.reloadData()
    }
    
    @objc private func compareSelectMode() {
        isCompareMode.toggle()
        setupNavigationBar()
        tableView.reloadData()
    }
    
    //MARK: - SetUpTableView
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
}

//MARK: - MovieManagerDelegate
extension MovieSelectionViewController: MovieManagerDelegate {
    func didUpdateMovies(_ movieManager: MovieDataManager, movies: [MovieModel]) {
        DispatchQueue.main.async {
            self.movies = movies
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
}

//MARK: - Rating PopUP
extension MovieSelectionViewController {
    
    private func showRatingAlert(movie: MovieModel) {
        let alertController = UIAlertController(title: "Rate this Movie", message: nil, preferredStyle: .alert)
        
        // Add custom StarRatingView to UIAlertController
        let starRatingView = StarRatingView()
        starRatingView.translatesAutoresizingMaskIntoConstraints = false
        alertController.view.addSubview(starRatingView)
        
        let okAction = UIAlertAction(title: "Rate", style: .default) { _ in
            let rating = Float(starRatingView.getRating())
            print("User rated with \(rating) stars")
            self.updateAverageRating(movie: movie, rating: rating)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Layout for StarRatingView
        let margin: CGFloat = 50.0
        NSLayoutConstraint.activate([
            starRatingView.topAnchor.constraint(equalTo: alertController.view.safeAreaLayoutGuide.topAnchor, constant: margin),
            starRatingView.leadingAnchor.constraint(equalTo: alertController.view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            starRatingView.trailingAnchor.constraint(equalTo: alertController.view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            starRatingView.bottomAnchor.constraint(equalTo: alertController.view.safeAreaLayoutGuide.bottomAnchor, constant: -margin)
        ])
        
        // Wyświetlamy alert
        present(alertController, animated: true, completion: nil)
    }
    
    func updateAverageRating(movie: MovieModel, rating: Float) {
        MovieRatingManager.shared.rateMovie(movie, rating: rating)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MovieSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = "Rating: \(String(format: "%.2f", movie.averageRating))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        if isCompareMode {
            // add to compare
            selectedMovies.append(movie)
            if selectedMovies.count == 2 {
                // display compare screen when 2 movies selected
                let ratingVC = MovieCompareViewController(movie1: selectedMovies[0], movie2: selectedMovies[1])
                navigationController?.pushViewController(ratingVC, animated: true)
                selectedMovies.removeAll()
            }
        } else if isRatingMode {
            // display rating popUP
            showRatingAlert(movie: movie)
        } else {
            // display movie details
            let detailsVC = MovieDetailsViewController(movie: movie)
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
}
