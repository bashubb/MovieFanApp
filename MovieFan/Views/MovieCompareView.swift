import UIKit

class MovieCompareView: UIView {
    private let movie: MovieModel
    private var higherRating: Bool?
    private let starStackView = UIStackView()
    private let side: String
    
    init(movie: MovieModel, higherRating: Bool, side: String) {
        self.movie = movie
        self.higherRating = higherRating
        self.side = side
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
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold, width: .compressed)
        
        
        let imageView = movie.moviePoster
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        
        let averageRatingLabel = UILabel()
        
        averageRatingLabel.text = "Average Rating: \(String(format: "%.2f", movie.averageRating))"
        averageRatingLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        averageRatingLabel.numberOfLines = 0
        
        setupStarStackView()
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, imageView, averageRatingLabel, starStackView])
        stackView.axis = .vertical
        stackView.spacing = 5
        
        let backgroundView = UIView()
        
        if let higherRating = higherRating {
            if higherRating {
                backgroundView.backgroundColor = .gray.withAlphaComponent(0.2)
                backgroundView.layer.cornerRadius = 5
                backgroundView.clipsToBounds = true
            }
        }
        
        addSubview(backgroundView)
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            backgroundView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
            backgroundView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -20),
            backgroundView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 20),
            backgroundView.bottomAnchor.constraint(lessThanOrEqualTo: stackView.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupStarStackView() {
        starStackView.axis = .horizontal
        starStackView.alignment = .center
        starStackView.distribution = .fillEqually
        
        let starFilled = UIImage(systemName: "star.fill")
        
        for _ in 0..<5 {
            let starImageView = UIImageView(image: starFilled)
            starImageView.contentMode = .scaleAspectFit
            starStackView.addArrangedSubview(starImageView)
        }
        updateStars(for: MovieRatingManager.shared.getAverageRating(for: movie), on: side)
    }
    
    private func updateStars(for rating: Float, on side: String) {
        let filledStars = Int(round(rating))
        let totalStars = starStackView.arrangedSubviews.count
        
        for i in 0..<5 {
            let starImageView = side == "right" ? starStackView.arrangedSubviews[i] as! UIImageView : starStackView.arrangedSubviews[totalStars - 1 - i] as! UIImageView
            
            if i < filledStars {
                starImageView.image = UIImage(systemName: "star.fill")?.withTintColor(.orange, renderingMode: .alwaysOriginal)
            } else {
                starImageView.image = UIImage(systemName: "star.fill")?.withTintColor(.clear, renderingMode: .alwaysOriginal)
            }
        }
    }
    
   
}
