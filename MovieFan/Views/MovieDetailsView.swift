import UIKit

class MovieDetailsView: UIView {
    private let movie: MovieModel
    
    init(movie: MovieModel) {
        self.movie = movie
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white 
        
        let titleLabel = UILabel()
        titleLabel.text = movie.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        
        let imageView = movie.moviePoster
        imageView.contentMode = .scaleAspectFit
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = movie.plot
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        descriptionLabel.numberOfLines = 0
        
        let actorsLabel = UILabel()
        let joined = movie.actors.joined(separator: ", ")
        actorsLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        actorsLabel.text = "Actors: \(joined)"
        actorsLabel.numberOfLines = 0
        
        let ratingLabel = UILabel()
        ratingLabel.text = "Rating: \(String(format: "%.2f", movie.averageRating))"
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, imageView,  descriptionLabel, actorsLabel, ratingLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 15
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
