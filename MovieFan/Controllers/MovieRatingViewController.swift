import UIKit

class MovieRatingViewController: UIViewController {
    private var movie1: Movie
    private var movie2: Movie
    private var movieRatingView: MovieRatingView!
    
    init(movie1: Movie, movie2: Movie) {
        self.movie1 = movie1
        self.movie2 = movie2
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Compare Movies"
        
        setupMovieRatingView()
    }
    
    private func setupMovieRatingView() {
        movieRatingView = MovieRatingView(movie1: movie1, movie2: movie2)
        movieRatingView.delegate = self
        view.addSubview(movieRatingView)
        
        movieRatingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieRatingView.topAnchor.constraint(equalTo: view.topAnchor),
            movieRatingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieRatingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieRatingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MovieRatingViewController: MovieRatingViewDelegate {
    func ratingDidChange(for movie: Movie, newRating: Float) {
        MovieRatingManager.shared.rateMovie(movie, rating: newRating)
        movie1.averageRating = MovieRatingManager.shared.getAverageRating(for: movie1)
        movie2.averageRating = MovieRatingManager.shared.getAverageRating(for: movie2)
    }
}
