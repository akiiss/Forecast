//
//  ViewController.swift
//  Forecast
//
//  Created by Akezhan Sauirbayev  on 13.04.2024.
//

import UIKit

class StockViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView!
    var stocks: [Stock] = []

    
    //the main func for printing
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        loadCSVData()
        tableView.register(StockTableViewCell.self, forCellReuseIdentifier: "StockCell")
        view.gradientBackground(colors: [UIColor(red: 0.0, green: 75/255, blue: 49/255, alpha: 1.0), UIColor(red: 17/255, green: 23/255, blue: 21/255, alpha: 1.0)])
//        navigationItem.setHidesBackButton(true, animated: true)
        
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
            titleLabel.text = "Stock"
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

    
    //setuping the tableView
    private func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StockCell")
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refreshStockData(_:)), for: .valueChanged)
            tableView.refreshControl = refreshControl
    }

    
    //parsing the data from csv file
    private func loadCSVData() {
        guard let path = Bundle.main.path(forResource: "stock_prices", ofType: "csv"),
              let csvContent = try? String(contentsOfFile: path) else { return }
        
        let rows = csvContent.components(separatedBy: "\n")
        for row in rows.dropFirst() {
            let columns = row.components(separatedBy: ",")
            if columns.count > 2 {
                let stock = Stock(
                    symbol: columns[0],
                    name: columns[1], 
                    price: Double(columns[2]),
                    open: Double(columns[3]),
                    high: Double(columns[4]),
                    low: Double(columns[5]),
                    volume: Double(columns[6]),
                    totalMarket: String(columns[7]),
                    percentChange: Double(columns[8])
                )
                stocks.append(stock)
            }
        }
        tableView.reloadData()
    }

    // amount of stock companies which will be shown
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    // content in the each cell of tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as! StockTableViewCell
        let stock = stocks[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.nameLabel.text = stock.name
        cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        cell.symbolLabel.text = stock.symbol
        cell.priceLabel.text = stock.price!.formatAsCurrency(amount: stock.price ?? 0)
        cell.priceLabel.font = UIFont.boldSystemFont(ofSize: 16)
        let formatted = String(format: "%.2f", stock.percentChange ?? 0)
        cell.changePercent.text = "\(formatted)%"
        if stock.percentChange ?? 0 >= 0 {
            cell.percentBackground.backgroundColor = UIColor(red: 0.00, green: 0.50, blue: 0.00, alpha: 1.00)
            
        } else {
            cell.percentBackground.backgroundColor = UIColor(red: 0.70, green: 0.13, blue: 0.13, alpha: 1.00)
        }
        return cell
    }
    
    
    
    
    @objc private func refreshStockData(_ sender: UIRefreshControl) {
        // Reload your data here and dismiss the refresh control
        sender.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        presentDetailViewController(for: stocks[indexPath.row])
       
        
        
//        print(indexPath.row)
    }
    
    func presentDetailViewController(for stock: Stock) {
            let detailVC = ModalViewController()
            detailVC.stock = stock
            detailVC.modalPresentationStyle = .pageSheet // or .fullScreen for full screen
            detailVC.modalTransitionStyle = .coverVertical // This is the default, but it's good to be explicit
            present(detailVC, animated: true)
        }
    
    
}

