import UIKit

class MovieDetailsView: UIView {
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let imageView = UIImageView(image: UIImage(named: movie.coverImageName))
        let titleLabel = UILabel()
        titleLabel.text = movie.title
        let descriptionLabel = UILabel()
        descriptionLabel.text = movie.description
        let ratingLabel = UILabel()
        ratingLabel.text = "Rating: \(movie.averageRating)"
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, descriptionLabel, ratingLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
