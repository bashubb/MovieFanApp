import UIKit

class MovieCompareView: UIView {
    private let movie: MovieModel
    private var higherRating: Bool
    private let averageRatingLabel = UILabel()
    private let starStackView = UIStackView()
    
    init(movie: MovieModel, higherRating: Bool) {
        self.movie = movie
        self.higherRating = higherRating
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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        let imageView = UIImageView(image: UIImage(named: movie.coverImageName))
        imageView.contentMode = .scaleAspectFit
        
        averageRatingLabel.text = "Average Rating: \(String(format: "%.2f", movie.averageRating()))"
        averageRatingLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        averageRatingLabel.numberOfLines = 0
        
        setupStarStackView()
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, imageView, averageRatingLabel, starStackView])
        stackView.axis = .vertical
        stackView.spacing = 5
        
        let backgroundView = UIView()
        if higherRating {
            backgroundView.backgroundColor = .systemYellow  // Tło pod stackView
            backgroundView.layer.cornerRadius = 8
            backgroundView.clipsToBounds = true
        }
        
        // Dodanie tła i stackView do głównego widoku
        addSubview(backgroundView)
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        // Ustawienie constraints dla backgroundView i stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            backgroundView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -10),  // Przesunięcie tła w górę od stackView
            backgroundView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -10),  // Przesunięcie tła w lewo od stackView
            backgroundView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10),  // Przesunięcie tła w prawo od stackView
            backgroundView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10)  // Przesunięcie tła w dół od stackView
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
        
        updateStars(for: MovieRatingManager.shared.getAverageRating(for: movie))
    }
    
    private func updateStars(for rating: Float) {
        let filledStars = Int(round(rating))
        
        for i in 0..<5 {
            let starImageView = starStackView.arrangedSubviews[i] as! UIImageView
            
            if i < filledStars {
                starImageView.image = UIImage(systemName: "star.fill")?.withTintColor(.orange, renderingMode: .alwaysOriginal)
            } else {
                starImageView.image = UIImage(systemName: "star.fill")?.withTintColor(.clear, renderingMode: .alwaysOriginal)
            }
        }
    }
    
   
}
