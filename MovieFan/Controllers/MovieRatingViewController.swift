import UIKit

class MovieRatingViewController: UIViewController {
    private let movie1: Movie
    private let movie2: Movie
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
        view.addSubview(movieRatingView)
        movieRatingView.frame = view.bounds
    }
}
