

import UIKit

class MovieSelectionViewController: UIViewController {
    private var movies: [Movie] = []
    private var tableView: UITableView!
    private var isRatingMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        
        setupNavigationBar()
        setupTableView()
        
        loadMovies()
    }
    
    private func setupNavigationBar() {
        let switchModeButton = UIBarButtonItem(title: "Switch Mode", style: .plain, target: self, action: #selector(switchMode))
        navigationItem.rightBarButtonItem = switchModeButton
    }
    
    @objc private func switchMode() {
        isRatingMode.toggle()
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    private func loadMovies() {
        // Load or create your movies list here
        movies = [
            Movie(title: "Movie 1", coverImageName: "cover1", description: "Description 1", averageRating: 0),
            Movie(title: "Movie 2", coverImageName: "cover2", description: "Description 2", averageRating: 0)
        ]
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
        if isRatingMode {
            // Implement movie rating logic here
        } else {
            let detailsVC = MovieDetailsViewController(movie: movie)
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}
