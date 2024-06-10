import UIKit

class MovieDetailsViewController: UIViewController {
    private let movie: Movie
    private var movieDetailsView: MovieDetailsView!
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie.title
        
        setupMovieDetailsView()
    }
    
    private func setupMovieDetailsView() {
        movieDetailsView = MovieDetailsView(movie: movie)
        view.addSubview(movieDetailsView)
        movieDetailsView.frame = view.bounds
    }
}
