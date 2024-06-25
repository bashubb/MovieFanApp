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
        
        let imageView = UIImageView(image: UIImage(named: movie.coverImageName))
        imageView.contentMode = .scaleAspectFit
        let titleLabel = UILabel()
        titleLabel.text = movie.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        let descriptionLabel = UILabel()
        descriptionLabel.text = movie.description
        descriptionLabel.numberOfLines = 0
        let ratingLabel = UILabel()
        ratingLabel.text = "Rating: \(String(format: "%.2f", movie.averageRating()))"
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, descriptionLabel, ratingLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
