//
//  ForecastViewController.swift
//  Forecast
//
//  Created by Akezhan Sauirbayev  on 14.04.2024.



import Foundation
import UIKit
import DGCharts
import Charts
class ForecastViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var items: [String] = []
    let items1: [String] = ["Attention", "Bidirectional", "Vanilla"]
    var lineChartView: LineChartView!
    var chartData: [ChartData] = []
    var predictionData: [Prediction] = []
    
    var dropdownTableView: UITableView!
    var dropdownTableView1: UITableView!
    var selectedCompany1: String?
    var selectedMethod: String?
    
    var isPriceVisible: Bool = true
    var isPredictionVisible: Bool = true
    
    let dropdownButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Company", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(showDropdown), for: .touchUpInside)
        
        button.backgroundColor = .clear
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        
        return button
    }()
    
    let dropdownButton1: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Prediction Method", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(showDropdown1), for: .touchUpInside)
        
        button.backgroundColor = .clear
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        
        return button
    }()
    
    
    
    let togglePriceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Price", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(togglePriceVisibility), for: .touchUpInside)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        
        button.layer.borderColor = UIColor.red.cgColor
        return button
    }()
    
    let togglePredictionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Prediction", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.yellow, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(togglePredictionVisibility), for: .touchUpInside)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        
        button.layer.borderColor = UIColor.yellow.cgColor
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(togglePriceButton)
        view.addSubview(togglePredictionButton)
        setupChart()
        setData()
        
        
        view.gradientBackground(colors: [UIColor(red: 0.0, green: 75/255, blue: 49/255, alpha: 1.0), UIColor(red: 17/255, green: 23/255, blue: 21/255, alpha: 1.0)])
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let customNavBar = UIView()
        customNavBar.backgroundColor = .clear
        view.addSubview(customNavBar)
        
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        togglePriceButton.translatesAutoresizingMaskIntoConstraints = false
        togglePredictionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customNavBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            customNavBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            customNavBar.topAnchor.constraint(equalTo: view.topAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 120),
            togglePriceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            togglePriceButton.widthAnchor.constraint(equalToConstant: 100),
            togglePriceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            
            togglePredictionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            togglePredictionButton.widthAnchor.constraint(equalToConstant: 100),
            togglePredictionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70)
        ])
        
        let titleLabel = UILabel()
        titleLabel.text = "Forecast"
        titleLabel.textColor = .buttonColor
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        customNavBar.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: customNavBar.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: customNavBar.topAnchor, constant: 70)
        ])
        view.addSubview(dropdownButton)
        view.addSubview(dropdownButton1)
        
        setupButtonConstraints()
        setupDropdownTableView()
        dropdownTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupDropdownTableView1()
        dropdownTableView1.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        loadCSVData()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissDropdown))
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(dismissDropdown1))
        tapGesture.cancelsTouchesInView = false
        tapGesture1.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(tapGesture1)
        
        
    }
    
    
    @objc func togglePriceVisibility() {
        isPriceVisible.toggle()
        setData()
    }
    
    @objc func togglePredictionVisibility() {
        isPredictionVisible.toggle()
        setData()
    }
    
    
    func setData() {
        var entries1 = [ChartDataEntry]()
        var entries2 = [ChartDataEntry]()
        
        if isPriceVisible {
            for data in chartData {
                let entry1 = ChartDataEntry(x: Double(chartData.firstIndex(where: { $0.date == data.date }) ?? 0), y: data.price)
                entries1.append(entry1)
            }
        }
        if isPredictionVisible {
            for data in predictionData {
                let entry2 = ChartDataEntry(x: Double(predictionData.firstIndex(where: { $0.date == data.date }) ?? 0), y: data.prediction)
                entries2.append(entry2)
            }
        }
        
        
        var dataSets: [LineChartDataSet] = []
        
        if !entries1.isEmpty {
            let dataSet1 = LineChartDataSet(entries: entries1, label: "Price")
            dataSet1.colors = [UIColor.red]
            let gradientColors1 = [UIColor.red.cgColor, UIColor.green.cgColor] as CFArray
            let colorLocations: [CGFloat] = [0.0, 1.0]
            if let gradient1 = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors1, locations: colorLocations) {
                dataSet1.fill = LinearGradientFill(gradient: gradient1, angle: 90)
                dataSet1.drawFilledEnabled = true
            }
            dataSet1.circleRadius = 1
            dataSet1.circleHoleRadius = 0.5
            dataSets.append(dataSet1)
        }
        
        if !entries2.isEmpty {
            let dataSet2 = LineChartDataSet(entries: entries2, label: "Prediction")
            dataSet2.colors = [UIColor.yellow]
            let gradientColors2 = [UIColor.blue.cgColor, UIColor.cyan.cgColor] as CFArray
            let colorLocations: [CGFloat] = [0.0, 1.0]
            if let gradient2 = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors2, locations: colorLocations) {
                dataSet2.fill = LinearGradientFill(gradient: gradient2, angle: 90)
                dataSet2.drawFilledEnabled = true
            }
            dataSet2.circleRadius = 1
            dataSet2.circleHoleRadius = 0.5
            dataSets.append(dataSet2)
        }
        
        //
        //        let dataSet1 = LineChartDataSet(entries: entries1, label: "Price")
        //        let dataSet2 = LineChartDataSet(entries: entries2, label: "Prediction")
        //
        
        let data = LineChartData(dataSets: dataSets as [ChartDataSet]) // Add both datasets
        lineChartView.data = data
        
        lineChartView.notifyDataSetChanged()
        customizeAxes()
        customizeLegend()
        addExtraFeatures()
    }
    
    
    
    func customizeAxes() {
        // X-axis customization
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelFont = .systemFont(ofSize: 12)
        lineChartView.xAxis.labelTextColor = UIColor.white
        lineChartView.xAxis.axisLineColor = UIColor.white
        lineChartView.xAxis.axisLineWidth = 3.0

        lineChartView.leftAxis.labelTextColor = UIColor.white
        lineChartView.leftAxis.axisLineWidth = 3.0
        lineChartView.leftAxis.axisLineColor = .white
        lineChartView.leftAxis.labelFont = .systemFont(ofSize: 12)
        lineChartView.rightAxis.enabled = false  // Disable right Y-axis
    }
    
    func customizeLegend() {
        lineChartView.legend.form = .line  // Legend form as line
        lineChartView.legend.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        lineChartView.legend.textColor = UIColor.black
        lineChartView.legend.horizontalAlignment = .right
        lineChartView.legend.verticalAlignment = .top
        lineChartView.legend.orientation = .horizontal
        lineChartView.legend.drawInside = false
    }
    
    func addExtraFeatures() {
        lineChartView.animate(xAxisDuration: 2.0)  // Add animation
        
        lineChartView.pinchZoomEnabled = true  // Allow pinch-zoom
        lineChartView.dragEnabled = true  // Enable drag
        lineChartView.setScaleEnabled(true)  // Allow scaling
        lineChartView.drawGridBackgroundEnabled = true  // Draw grid background
        lineChartView.gridBackgroundColor = UIColor.clear  // Grid background color
    }
    
    func setupChart() {
        lineChartView = LineChartView()
            view.addSubview(lineChartView)
            lineChartView.frame = CGRect(x: 30, y: 250, width: 300, height: 300)
            lineChartView.translatesAutoresizingMaskIntoConstraints = false
            lineChartView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
            lineChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            lineChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            lineChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
            
            // Set up the x-axis to use dates as labels
            let dates = chartData.map { $0.date }
            lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
            lineChartView.xAxis.granularity = 1
            lineChartView.xAxis.labelRotationAngle = 45  // Adjust the angle to make labels more readable
            lineChartView.xAxis.labelPosition = .bottom
            lineChartView.xAxis.avoidFirstLastClippingEnabled = true  // Avoid clipping the first and last labels
            
            // Set a reasonable number of labels to display
            lineChartView.xAxis.labelCount = min(dates.count, 7)
            lineChartView.xAxis.granularity = Double(max(dates.count / 7, 1))
        
        // Refresh the chart data
        setData()
    }
    
    
    func loadCSVData() {
        guard let path = Bundle.main.path(forResource: "stock_prices", ofType: "csv") else { return }
        do {
            let content = try String(contentsOfFile: path)
            let lines = content.components(separatedBy: "\n")
            for line in lines.dropFirst() { // Drop the header
                let columns = line.components(separatedBy: ",")
                if columns.count > 1 { // Ensure there is a second column
                    let companyName = columns[1]
                    items.append(companyName)
                }
            }
            dropdownTableView.reloadData()
        } catch {
            print("Failed to read CSV file: \(error)")
        }
    }
    
    func setupButtonConstraints() {
        
        dropdownButton.translatesAutoresizingMaskIntoConstraints = false
        dropdownButton1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dropdownButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            dropdownButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            dropdownButton.widthAnchor.constraint(equalToConstant: 160),
            
            dropdownButton1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            dropdownButton1.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            dropdownButton1.widthAnchor.constraint(equalToConstant: 160),
            
        ])
    }
    
    func setupDropdownTableView() {
        dropdownTableView = UITableView()
        dropdownTableView.delegate = self
        dropdownTableView.dataSource = self
        dropdownTableView.isHidden = true
        dropdownTableView.layer.cornerRadius = 20
        dropdownTableView.layer.masksToBounds = true
        dropdownTableView.backgroundColor = UIColor.black
        view.addSubview(dropdownTableView)
        
        dropdownTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dropdownTableView.topAnchor.constraint(equalTo: dropdownButton.bottomAnchor, constant: 10),
            dropdownTableView.centerXAnchor.constraint(equalTo: dropdownButton.centerXAnchor),
            dropdownTableView.widthAnchor.constraint(equalTo: dropdownButton.widthAnchor),
            dropdownTableView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        
    }
    
    func setupDropdownTableView1() {
        dropdownTableView1 = UITableView()
        dropdownTableView1.delegate = self
        dropdownTableView1.dataSource = self
        dropdownTableView1.isHidden = true
        dropdownTableView1.layer.cornerRadius = 20
        dropdownTableView1.layer.masksToBounds = true
        dropdownTableView1.backgroundColor = UIColor.black
        view.addSubview(dropdownTableView1)
        dropdownTableView1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dropdownTableView1.topAnchor.constraint(equalTo: dropdownButton1.bottomAnchor, constant: 10),
            dropdownTableView1.centerXAnchor.constraint(equalTo: dropdownButton1.centerXAnchor),
            dropdownTableView1.widthAnchor.constraint(equalTo: dropdownButton1.widthAnchor),
            dropdownTableView1.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func showDropdown() {
        if dropdownTableView.isHidden {
            dropdownTableView.isHidden = false
            dropdownTableView.alpha = 0.0
            UIView.animate(withDuration: 0.3) {
                self.dropdownTableView.alpha = 1.0
            }
        } else {
            hideDropdown()
        }
    }
    
    @objc func showDropdown1() {
        if dropdownTableView1.isHidden {
            dropdownTableView1.isHidden = false
            dropdownTableView1.alpha = 0.0
            UIView.animate(withDuration: 0.3) {
                self.dropdownTableView1.alpha = 1.0
            }
        } else {
            hideDropdown1()
        }
    }
    
    
    @objc func dismissDropdown(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        if !dropdownTableView.frame.contains(location) && !dropdownButton.frame.contains(location) {
            hideDropdown()
        }
    }
    
    @objc func dismissDropdown1(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        if !dropdownTableView1.frame.contains(location) && !dropdownButton1.frame.contains(location) {
            hideDropdown1()
        }
    }
    
    func hideDropdown() {
        UIView.animate(withDuration: 0.3, animations: {
            self.dropdownTableView.alpha = 0.0
        }) { (completed) in
            self.dropdownTableView.isHidden = true
        }
    }
    func hideDropdown1() {
        UIView.animate(withDuration: 0.3, animations: {
            self.dropdownTableView1.alpha = 0.0
        }) { (completed) in
            self.dropdownTableView1.isHidden = true
        }
    }
    
    // UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == dropdownTableView {
            return items.count
        } else if tableView == dropdownTableView1 {
            return items1.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60  // Example: setting row height to 60 points
    }
    
    // UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if tableView == dropdownTableView {
            let item = items[indexPath.row]
            cell.textLabel?.text = item
        } else if tableView == dropdownTableView1 {
            let item = items1[indexPath.row]
            cell.textLabel?.text = item
        }
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = UIColor.black
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
    }
    
    // UITableViewDelegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == dropdownTableView {
            let selectedCompany = items[indexPath.row]
            dropdownButton.setTitle(selectedCompany, for: .normal)
            selectedCompany1 = selectedCompany
            hideDropdown()
            
            guard let stockSymbol = stockSymbolToFileName[selectedCompany] else { return }
            chartData.removeAll()
            predictionData.removeAll()
            parseCSV(fileName: stockSymbol)
            setData()
            
        } else if tableView == dropdownTableView1 {
            let method = items1[indexPath.row]
            dropdownButton1.setTitle(method, for: .normal)
            selectedMethod = method
            hideDropdown1()
            chartData.removeAll()
            predictionData.removeAll()
            
            if let company = selectedCompany1, let method = selectedMethod {
                let compositeKey = "\(company)+\(method)"
                guard let stockSymbol = stockSymbolToFileName1[compositeKey] else {return}
                methodCSV(fileName: stockSymbol)
                setData()
            }
            
            
            
            
        }
    }
    
    var stockSymbolToFileName: [String: String] = [
        "Apple Inc.": "AAPL_data",
        "Microsoft": "MSFT_data",
        "Google": "GOOGL_data",
        "Amazon": "AMZN_data",
        "Tesla Inc.": "TSLA_data",
        "IBM": "IBM_data",
        "Netflix": "NFLX_data",
        "Boeing": "BA_data",
        "Intel Inc.": "INTC_data",
        "Nvidia": "NVDA_data"
    ]
    
    
    var stockSymbolToFileName1: [String: String] = [
        "Apple Inc.+Attention": "Attention_Apple",
        "Apple Inc.+Bidirectional": "Bidirectional_Apple",
        "Apple Inc.+Vanilla": "Vanilla_Apple",
        
        "Microsoft+Attention": "Attention_Microsoft",
        "Microsoft+Bidirectional": "Bidirectional_Microsoft",
        "Microsoft+Vanilla": "Vanilla_Microsoft",
        
        "Google+Attention": "Attention_Google",
        "Google+Bidirectional": "Bidirectional_Google",
        "Google+Vanilla": "Vanilla_Google",
        
        "Amazon+Attention": "Attention_Amazon",
        "Amazon+Bidirectional": "Bidirectional_Amazon",
        "Amazon+Vanilla": "Vanilla_Amazon",
        
        "Tesla Inc.+Attention": "Attention_Tesla",
        "Tesla Inc.+Bidirectional": "Bidirectional_Tesla",
        "Tesla Inc.+Vanilla": "Vanilla_Tesla",
        
        "IBM+Attention": "Attention_IBM",
        "IBM+Bidirectional": "Bidirectional_IBM",
        "IBM+Vanilla": "Vanilla_IBM",
        
        "Netflix+Attention": "Attention_Netflix",
        "Netflix+Bidirectional": "Bidirectional_Netflix",
        "Netflix+Vanilla": "Vanilla_Netflix",
        
        "Boeing+Attention": "Attention_Boeing",
        "Boeing+Bidirectional": "Bidirectional_Boeing",
        "Boeing+Vanilla": "Vanilla_Boeing",
        
        "Intel Inc.+Attention": "Attention_Intel",
        "Intel Inc.+Bidirectional": "Bidirectional_Intel",
        "Intel Inc.+Vanilla": "Vanilla_Intel",
        
        "Nvidia+Attention": "Attention_Nvidia",
        "Nvidia+Bidirectional": "Bidirectional_Nvidia",
        "Nvidia+Vanilla": "Vanilla_Nvidia"
    ]
    
    func parseCSV(fileName: String) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "csv"),
              let csvContent = try? String(contentsOfFile: path) else { return }
        
        let rows = csvContent.components(separatedBy: "\n")
        for row in rows.dropFirst() {
            let columns = row.components(separatedBy: ",")
            if columns.count > 2 {
                let data = ChartData(
                    date: columns[0],
                    price: Double(columns[3])!
                )
                chartData.append(data)
            }
        }
    }
    
    
    func methodCSV(fileName: String) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            print("File path not found for fileName: \(fileName)")
            return
        }
        
        do {
            let csvContent = try? String(contentsOfFile: path)
            print("File path: \(path)")
            
            let rows = csvContent!.components(separatedBy: "\n")
            for row in rows.dropFirst() {
                let columns = row.components(separatedBy: ",")
                if columns.count >= 4,
                   let price = Double(columns[2]),
                   let prediction = Double(columns[3]) {
                    let data1 = ChartData(date: columns[0], price: price)
                    let data2 = Prediction(date: columns[0], prediction: prediction)
                    chartData.append(data1)
                    predictionData.append(data2)
                } else {
                    print("Invalid row: \(row)")
                }
            }
            
            print("Parsed \(chartData.count) data entries")
            print("Parsed \(predictionData.count) prediction entries")
        }
    }
}
