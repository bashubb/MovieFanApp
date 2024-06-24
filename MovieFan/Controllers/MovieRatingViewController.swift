import UIKit

protocol MovieRatingViewDelegate: AnyObject {
    func ratingDidChange(for movie: Movie, newRating: Float)
}


class MovieRatingViewController: UIViewController, MovieRatingViewDelegate {
    private var movie1: Movie
    private var movie2: Movie
    private var movie1RatingView: MovieRatingView!
    private var movie2RatingView: MovieRatingView!
    
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
        view.backgroundColor = .white
        
        setupMovieRatingViews()
    }
    
    private func setupMovieRatingViews() {
        movie1RatingView = MovieRatingView(movie: movie1)
        movie1RatingView.delegate = self
        view.addSubview(movie1RatingView)
        
        movie1RatingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movie1RatingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            movie1RatingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            movie1RatingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -10),
            movie1RatingView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        movie2RatingView = MovieRatingView(movie: movie2)
        movie2RatingView.delegate = self
        view.addSubview(movie2RatingView)
        
        movie2RatingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movie2RatingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            movie2RatingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 10),
            movie2RatingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            movie2RatingView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func ratingDidChange(for movie: Movie, newRating: Float) {
        if movie == movie1 {
            movie1.averageRating = newRating
            movie1RatingView.updateAverageRatingLabel()
        } else if movie == movie2 {
            movie2.averageRating = newRating
            movie2RatingView.updateAverageRatingLabel()
        }
    }
}
