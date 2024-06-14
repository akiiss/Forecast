//
//  ModalViewController.swift
//  Forecast
//
//  Created by Akezhan Sauirbayev  on 14.04.2024.
//

import UIKit
import DGCharts
import Charts

class ModalViewController: UIViewController {
    
    var stock: Stock?
    var lineChartView: LineChartView!
    var chartData: [ChartData] = []
    let oneDayButton = UIButton()
    let oneWeekButton = UIButton()
    let oneMonthButton = UIButton()
        
    let companyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        
        return label
    }()
    
    let stockNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .white
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        
        return label
    }()
    let openLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        
        return label
    }()
    let highLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        
        return label
    }()
    let lowLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        
        return label
    }()
    let volumeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        
        return label
    }()
    let totalMarketLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.gradientBackground(colors: [UIColor(red: 0.0, green: 75/255, blue: 49/255, alpha: 1.0), UIColor(red: 17/255, green: 23/255, blue: 21/255, alpha: 1.0)])
        if let stock = stock {
            companyNameLabel.text = stock.name
            stockNameLabel.text = stock.symbol
            priceLabel.text = "Price:   \(stock.price!.formatAsCurrency(amount: stock.price ?? 0.0))"
            openLabel.text = "Open:   \(formatted(amount: stock.open ?? 0.0) ?? 0.0)"
            highLabel.text = "High:   \(formatted(amount: stock.high ?? 0.0) ?? 0.0)"
            lowLabel.text = "Low:   \(formatted(amount: stock.low ?? 0.0) ?? 0.0)"
            volumeLabel.text = "Volume:   \(stock.volume ?? 0)"
            totalMarketLabel.text = "Total Market Cap:   \(totalMarketer(amount:stock.totalMarket ?? "") ?? "")"
        }
        companyChart()
//        fetchData(for: .oneDay)
        setupUI()
        setupChart()
        setData()
//        setupButtons()
    }
    
//    enum TimeRange {
//        case oneDay
//        case oneWeek
//        case oneMonth
//    }
//    
//    func fetchData(for range: TimeRange) {
//        var filteredData: [ChartData] = []
//        
//        switch range {
//        case .oneDay:
//            // For daily data, no need to aggregate
//            filteredData = chartData
//        case .oneWeek:
//            // Aggregate data by week
//            break
//        case .oneMonth:
//            // Aggregate data by month
//            filteredData = getLastDaysSorted(chartData: chartData)
//        }
//        
//        chartData = filteredData
//        setData()
//    }

//    func isLastDayOfMonth(_ date: Date) -> Bool {
//        let calendar = Calendar.current
//        let nextDay = calendar.date(byAdding: .day, value: 1, to: date)!
//        return calendar.component(.month, from: date) != calendar.component(.month, from: nextDay)
//    }
//    
//    func getLastDaysSorted(chartData: [ChartData]) -> [ChartData] {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        
//        let lastDays = chartData.filter { data in
//            if let date = dateFormatter.date(from: data.date) {
//                return isLastDayOfMonth(date)
//            }
//            return false
//        }
//        
//        let sortedLastDays = lastDays.sorted { (data1, data2) -> Bool in
//            if let date1 = dateFormatter.date(from: data1.date),
//               let date2 = dateFormatter.date(from: data2.date) {
//                return date1 < date2
//            }
//            return false
//        }
//        
//        return sortedLastDays
//    }
//    
//    func setupButtons() {
//            // Configure 1D button
//            oneDayButton.setTitle("1D", for: .normal)
//            oneDayButton.setTitleColor(.white, for: .normal)
//            oneDayButton.backgroundColor = .clear
//            oneDayButton.layer.cornerRadius = 8
//            oneDayButton.layer.borderWidth = 1
//            oneDayButton.layer.borderColor = UIColor.white.cgColor
//            oneDayButton.addTarget(self, action: #selector(oneDayButtonTapped), for: .touchUpInside)
//            view.addSubview(oneDayButton)
//            oneDayButton.translatesAutoresizingMaskIntoConstraints = false
//            oneDayButton.topAnchor.constraint(equalTo: lowLabel.bottomAnchor, constant: 20).isActive = true
//            oneDayButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//            
//            // Configure 1W button
//            oneWeekButton.setTitle("1W", for: .normal)
//            oneWeekButton.setTitleColor(.white, for: .normal)
//            oneWeekButton.backgroundColor = .clear
//            oneWeekButton.layer.cornerRadius = 8
//            oneWeekButton.layer.borderWidth = 1
//            oneWeekButton.layer.borderColor = UIColor.white.cgColor
////            oneWeekButton.addTarget(self, action: #selector(oneWeekButtonTapped), for: .touchUpInside)
//            view.addSubview(oneWeekButton)
//            oneWeekButton.translatesAutoresizingMaskIntoConstraints = false
//            oneWeekButton.topAnchor.constraint(equalTo: lowLabel.bottomAnchor, constant: 20).isActive = true
//            oneWeekButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//            
//            // Configure 1M button
//            oneMonthButton.setTitle("1M", for: .normal)
//            oneMonthButton.setTitleColor(.white, for: .normal)
//            oneMonthButton.backgroundColor = .clear
//            oneMonthButton.layer.cornerRadius = 8
//            oneMonthButton.layer.borderWidth = 1
//            oneMonthButton.layer.borderColor = UIColor.white.cgColor
//            oneMonthButton.addTarget(self, action: #selector(oneMonthButtonTapped), for: .touchUpInside)
//            view.addSubview(oneMonthButton)
//            oneMonthButton.translatesAutoresizingMaskIntoConstraints = false
//            oneMonthButton.topAnchor.constraint(equalTo: lowLabel.bottomAnchor, constant: 20).isActive = true
//            oneMonthButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//        }
    
    
//    @objc func oneDayButtonTapped() {
//            fetchData(for: .oneDay)
//        }
//        
//        @objc func oneWeekButtonTapped() {
//            fetchData(for: .oneWeek)
//        }
//        
//        @objc func oneMonthButtonTapped() {
//            fetchData(for: .oneMonth)
//        }
//    
    
    func setData() {
        var entries = [ChartDataEntry]()
                
                for data in chartData {
                    let entry = ChartDataEntry(x: Double(chartData.firstIndex(where: { $0.date == data.date }) ?? 0), y: data.price)
                    entries.append(entry)
                }
                
                let dataSet = LineChartDataSet(entries: entries)
                
                // Check if the price is increasing or decreasing and set the color accordingly
                if let first = chartData.first?.price, let last = chartData.last?.price {
                    dataSet.colors = [last > first ? UIColor.green : UIColor.red]
                }
        
        
                
                // Create a gradient fill
                let gradientColors = [UIColor.red.cgColor, UIColor.green.cgColor] as CFArray
                let colorLocations: [CGFloat] = [0.0, 1.0]
                if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) {
                    dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90)
                    dataSet.drawFilledEnabled = true
                }
                
                dataSet.circleRadius = 1
                dataSet.circleHoleRadius = 0.5
                
                let data = LineChartData(dataSets: [dataSet])
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
            lineChartView.frame = CGRect(x: 10, y: 250, width: 300, height: 300)
            lineChartView.translatesAutoresizingMaskIntoConstraints = false
            lineChartView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
            lineChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            lineChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            lineChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true

            // Set up the x-axis to use dates as labels
            let dates = chartData.map { $0.date }
            lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
            lineChartView.xAxis.granularity = 1
            lineChartView.xAxis.labelRotationAngle = 45  // Adjust the angle to make labels more readable
            lineChartView.xAxis.labelPosition = .bottom
            lineChartView.xAxis.avoidFirstLastClippingEnabled = true  // Avoid clipping the first and last labels

            lineChartView.xAxis.labelCount = dates.count / 7
            lineChartView.xAxis.granularity = Double(dates.count / 7)

            // Refresh the chart data
            setData()
        }
    
    private func setupUI() {
        view.addSubview(stockNameLabel)
        view.addSubview(companyNameLabel)
        view.addSubview(priceLabel)
        view.addSubview(openLabel)
        view.addSubview(highLabel)
        view.addSubview(lowLabel)
        view.addSubview(volumeLabel)
        view.addSubview(totalMarketLabel)
        NSLayoutConstraint.activate([
            stockNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stockNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            companyNameLabel.bottomAnchor.constraint(equalTo: stockNameLabel.bottomAnchor),
            companyNameLabel.leadingAnchor.constraint(equalTo: stockNameLabel.trailingAnchor, constant: 15),
            companyNameLabel.widthAnchor.constraint(equalToConstant: 250),
            
            priceLabel.topAnchor.constraint(equalTo: stockNameLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: stockNameLabel.leadingAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 300),
            
            openLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            openLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            openLabel.widthAnchor.constraint(equalToConstant: 150),
            
            highLabel.topAnchor.constraint(equalTo: openLabel.bottomAnchor, constant: 10),
            highLabel.leadingAnchor.constraint(equalTo: openLabel.leadingAnchor),
            highLabel.widthAnchor.constraint(equalToConstant: 150),
            
            lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor, constant: 10),
            lowLabel.leadingAnchor.constraint(equalTo: highLabel.leadingAnchor),
            lowLabel.widthAnchor.constraint(equalToConstant: 150),
            
            volumeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            volumeLabel.leadingAnchor.constraint(equalTo: openLabel.trailingAnchor, constant: 20),
            volumeLabel.widthAnchor.constraint(equalToConstant: 150),
            
            totalMarketLabel.topAnchor.constraint(equalTo: volumeLabel.bottomAnchor, constant: 10),
            totalMarketLabel.leadingAnchor.constraint(equalTo: volumeLabel.leadingAnchor),
            totalMarketLabel.widthAnchor.constraint(equalToConstant: 250),
            
            
            
        ])
    }
    
    func formatted(amount: Double) -> Double? {
        let formatted = String(format: "%.2f", amount)
        let formatted1  = Double(formatted)
        return formatted1
    }
    
    func totalMarketer(amount: String) -> String? {
        let number = amount
        
        if amount.count > 12 {
            let index = number.index(number.startIndex, offsetBy: (amount.count-12))
            let result = "\(number[..<index]).\(number[number.index(number.startIndex, offsetBy: 1)]) trillion"
            return result
        } else if amount.count > 9 {
            let index = number.index(number.startIndex, offsetBy: (amount.count-9))
            let result = "\(number[..<index]).\(number[number.index(number.startIndex, offsetBy: 1)]) billion"
            return result
        } else if amount.count > 6 {
            let index = number.index(number.startIndex, offsetBy: (amount.count-6))
            let result = "\(number[..<index]).\(number[number.index(number.startIndex, offsetBy: 1)]) million"
            return result
        }
        return number
    }
    
    var stockSymbolToFileName: [String: String] = [
        "AAPL": "AAPL_data",
        "MSFT": "MSFT_data",
        "GOOG": "GOOGL_data",
        "AMZN": "AMZN_data",
        "TSLA": "TSLA_data",
        "IBM": "IBM_data",
        "NFLX": "NFLX_data",
        "BA": "BA_data",
        "INTC": "INTC_data",
        "NVDA": "NVDA_data"
    ]
    
    func companyChart() {
        if let stock = stock, let fileName = stockSymbolToFileName[stock.symbol] {
            parseCSV(fileName: fileName)
        }
    }
    
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
}



