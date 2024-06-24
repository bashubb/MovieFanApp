import UIKit

class MovieRatingView: UIView {
    private let movie: Movie
    private var ratingSlider: UISlider!
    private let averageRatingLabel = UILabel()
    private let starStackView = UIStackView()
    weak var delegate: MovieRatingViewDelegate?
    
    init(movie: Movie) {
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
        let imageView = UIImageView(image: UIImage(named: movie.coverImageName))
        imageView.contentMode = .scaleAspectFit
        
        averageRatingLabel.text = "Average Rating: \(movie.averageRating)"
        
        ratingSlider = UISlider()
        ratingSlider.minimumValue = 0
        ratingSlider.maximumValue = 5
        ratingSlider.value = movie.averageRating
        ratingSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        setupStarStackView()
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, imageView, averageRatingLabel, starStackView, ratingSlider])
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
    
    private func setupStarStackView() {
        starStackView.axis = .horizontal
        starStackView.alignment = .center
        starStackView.distribution = .fillEqually
        
        let starEmpty = UIImage(systemName: "star")
        let starFilled = UIImage(systemName: "star.fill")
        
        for _ in 0..<5 {
            let starImageView = UIImageView(image: starEmpty)
            starImageView.contentMode = .scaleAspectFit
            starStackView.addArrangedSubview(starImageView)
        }
    }
    
    private func updateStars(for rating: Float) {
        let filledStars = Int(round(rating))
        
        for i in 0..<5 {
            let starImageView = starStackView.arrangedSubviews[i] as! UIImageView
            
            if i < filledStars {
                starImageView.image = UIImage(systemName: "star.fill")
            } else {
                starImageView.image = UIImage(systemName: "star")
            }
        }
    }
    
    @objc private func sliderValueChanged() {
        let newRating = ratingSlider.value
        averageRatingLabel.text = "Average Rating: \(newRating)"
        updateStars(for: newRating)
        delegate?.ratingDidChange(for: movie, newRating: newRating)
    }
    
    func updateAverageRatingLabel() {
        averageRatingLabel.text = "Average Rating: \(movie.averageRating)"
        updateStars(for: movie.averageRating)
    }
}
