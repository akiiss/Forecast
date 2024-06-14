import UIKit

class StockTableViewCell: UITableViewCell {
    
    // company symbol
    lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // company full name
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //company stock price
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //company first open price
    lazy var openLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var highLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var totalMarketLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var changePercent: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var percentBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 50),
            view.heightAnchor.constraint(equalToConstant: 20),
        ])
        view.layer.cornerRadius = 3
        return view
    }()
    
    
    
    // Initialization and layout code
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // Configure the cell with a stock object
    private func configure() {
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        
        contentView.addSubview(percentBackground)
        percentBackground.addSubview(changePercent)
        
        //adding constraints to titleLabel
        nameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive =  true
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10).isActive = true
        
        // adding constraints to subtitlelabel
        symbolLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor).isActive = true
        symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        symbolLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        
        // adding constraints to pricelabel
        priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10).isActive = true
        
        // adding constraints to changePercent
//        changePercent.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor).isActive = true
//        changePercent.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 3).isActive = true
        
        percentBackground.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor).isActive = true
        percentBackground.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5).isActive = true
        
        changePercent.centerXAnchor.constraint(equalTo: percentBackground.centerXAnchor).isActive = true
        changePercent.centerYAnchor.constraint(equalTo: percentBackground.centerYAnchor).isActive = true
        
    }
}
