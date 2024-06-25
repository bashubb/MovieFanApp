import UIKit

class StarRatingView: UIView {
    
    private let starCount: Int = 5
    private var rating: Int = 0 {
        didSet {
            updateStarImages()
        }
    }
    
    private var starButtons: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        
        for _ in 0..<starCount {
            let button = UIButton()
            var config = UIButton.Configuration.plain()
            config.image = UIImage(systemName: "star")?.withTintColor(.orange, renderingMode: .alwaysOriginal)
            config.imagePadding = 5
            config.baseBackgroundColor = .clear
            
            button.configuration = config
            button.addTarget(self, action: #selector(starTapped(_:)), for: .touchUpInside)
            button.configurationUpdateHandler = { [weak self] button in
                guard self != nil else { return }
                var config = button.configuration
                config?.baseBackgroundColor = .clear
                config?.image = button.isSelected ? UIImage(systemName: "star.fill")?.withTintColor(.orange, renderingMode: .alwaysOriginal) : UIImage(systemName: "star")?.withTintColor(.orange, renderingMode: .alwaysOriginal)
                config?.imagePadding = 5
                button.configuration = config
            }
            
            starButtons.append(button)
            stackView.addArrangedSubview(button)
        }
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @objc private func starTapped(_ sender: UIButton) {
        guard let index = starButtons.firstIndex(of: sender) else { return }
        rating = index + 1
        
    }
    
    private func updateStarImages() {
        for (index, button) in starButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    func setRating(_ rating: Int) {
        self.rating = rating
    }
    
    func getRating() -> Int {
        return rating
    }
}
