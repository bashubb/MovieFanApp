import UIKit

class MovieRatingView: UIView {
    private let movie1: Movie
    private let movie2: Movie
    private var ratingSlider: UISlider!
    
    init(movie1: Movie, movie2: Movie) {
        self.movie1 = movie1
        self.movie2 = movie2
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let titleLabel1 = UILabel()
        titleLabel1.text = movie1.title
        let imageView1 = UIImageView(image: UIImage(named: movie1.coverImageName))
        let ratingLabel1 = UILabel()
        ratingLabel1.text = "Rating: \(movie1.averageRating)"
        
        let titleLabel2 = UILabel()
        titleLabel2.text = movie2.title
        let imageView2 = UIImageView(image: UIImage(named: movie2.coverImageName))
        let ratingLabel2 = UILabel()
        ratingLabel2.text = "Rating: \(movie2.averageRating)"
        
        ratingSlider = UISlider()
        ratingSlider.minimumValue = -5
        ratingSlider.maximumValue = 5
        ratingSlider.value = 0
        ratingSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        let stackView1 = UIStackView(arrangedSubviews: [titleLabel1, imageView1, ratingLabel1])
        stackView1.axis = .vertical
        stackView1.spacing = 10
        
        let stackView2 = UIStackView(arrangedSubviews: [titleLabel2, imageView2, ratingLabel2])
        stackView2.axis = .vertical
        stackView2.spacing = 10
        
        let mainStackView = UIStackView(arrangedSubviews: [stackView1, ratingSlider, stackView2])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 20
        mainStackView.alignment = .center
        addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func sliderValueChanged() {
        let ratingDifference = ratingSlider.value
        let movie1Rating = max(0, min(5, 5 + ratingDifference))
        let movie2Rating = max(0, min(5, 5 - ratingDifference))
        
        // Update ratings in the manager
        MovieRatingManager.shared.rateMovie(movie1, rating: movie1Rating)
        MovieRatingManager.shared.rateMovie(movie2, rating: movie2Rating)
        
        // Update labels
        // Assuming we have references to the labels, update them accordingly
    }
}

