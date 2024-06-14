//
//  GraphViewController.swift
//  Forecast
//
//  Created by Akezhan Sauirbayev  on 14.04.2024.
//


import UIKit
import SafariServices

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    private var viewModels = [NewsTableViewCellViewModel]()
    private var articles = [Article]()
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as?  NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ?? "") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        view.gradientBackground(colors: [UIColor(red: 0.0, green: 75/255, blue: 49/255, alpha: 1.0), UIColor(red: 17/255, green: 23/255, blue: 21/255, alpha: 1.0)])
        
        APICaller.shared.getTopStories { [weak self ]result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "",
                        imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
            
            
        }
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Create a custom navigation view
        let customNavBar = UIView()
        customNavBar.backgroundColor = .clear
        view.addSubview(customNavBar)
        
        // Setup constraints or frame for the custom navigation bar
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customNavBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            customNavBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            customNavBar.topAnchor.constraint(equalTo: view.topAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 120) // Set your custom height
        ])
        
        let titleLabel = UILabel()
        titleLabel.text = "News"
        titleLabel.textColor = .buttonColor
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        // Add the title label to the custom navigation bar
        customNavBar.addSubview(titleLabel)
        
        // Setup constraints for the title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: customNavBar.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: customNavBar.topAnchor, constant: 70)
        ])
        
        if let tabBar = tabBarController?.tabBar {
                tabBar.backgroundColor = .tabBarColor  // Custom color defined in your UIColor extensions
                tabBar.tintColor = UIColor.fontGreenColor  // Custom tint color for the selected item
                tabBar.unselectedItemTintColor = UIColor(white: 1, alpha: 1)  // White color for unselected items
            }

            if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor.tabBarColor  // Adjust the background color as needed

                // Customize the appearance colors to match the earlier settings for consistency
                appearance.stackedLayoutAppearance.selected.iconColor = UIColor.fontGreenColor
                appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.fontGreenColor]
                appearance.stackedLayoutAppearance.normal.iconColor = UIColor(white: 1, alpha: 1)
                appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(white: 1, alpha: 1)]

                // Apply the appearance settings to both standard and scroll edge appearances
                tabBarController?.tabBar.standardAppearance = appearance
                tabBarController?.tabBar.scrollEdgeAppearance = appearance
            } else {
                tabBarController?.tabBar.isTranslucent = false
                tabBarController?.tabBar.backgroundColor = UIColor.tabBarColor
            }
        let tabBarHeight = tabBarController?.tabBar.frame.size.height ?? 0
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tabBarHeight, right: 0)
            tableView.scrollIndicatorInsets = tableView.contentInset
        
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        tableView.frame = view.bounds
    }
    private func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.darkGray
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 72
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -85)
        ])
        let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refreshStockData(_:)), for: .valueChanged)
            tableView.refreshControl = refreshControl
    }
    
    
    @objc private func refreshStockData(_ sender: UIRefreshControl) {
        // Reload your data here and dismiss the refresh control
        sender.endRefreshing()
    }
}
