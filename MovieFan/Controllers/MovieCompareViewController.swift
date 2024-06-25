import UIKit

class MovieCompareViewController: UIViewController{
    private var movie1: MovieModel
    private var movie2: MovieModel
    private var movie1RatingView: MovieCompareView!
    private var movie2RatingView: MovieCompareView!
    
    private var higherRating = ""
    
    init(movie1: MovieModel, movie2: MovieModel) {
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
        compareRatings()
        setupMovieRatingViews()
    }
    
    private func compareRatings() {
        if movie1.averageRating() > movie2.averageRating() {
            higherRating = movie1.title
        } else {
            higherRating = movie2.title
        }
    }
    
    private func setupMovieRatingViews() {
        movie1RatingView = MovieCompareView(movie: movie1, higherRating: movie1.title == higherRating)
        view.addSubview(movie1RatingView)
        
        movie1RatingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movie1RatingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            movie1RatingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            movie1RatingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -10),
            movie1RatingView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        movie2RatingView = MovieCompareView(movie: movie2, higherRating: movie2.title == higherRating)
        view.addSubview(movie2RatingView)
        
        movie2RatingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movie2RatingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            movie2RatingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 10),
            movie2RatingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            movie2RatingView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}


