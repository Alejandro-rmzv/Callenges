//
//  MainViewSwiftViewController.swift
//  Mi Telcel
//
//  Created Alejandro Jose Ramirez Vergara on 17/04/21.
//
//

import UIKit

class MainViewSwiftViewController: UIViewController  {
    // MARK: - Properties
    var presenter: MainViewSwiftPresenterProtocol?
    let date = Date.init()
    var mutableDataW: NSMutableDictionary?
    var mutableDataOM: NSMutableDictionary?
    var mutableDataTM: NSMutableDictionary?
    @IBOutlet var graphicView: UIView!
    @IBOutlet var segmentControl: UISegmentedControl!
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.checkDate()
        presenter?.initView()
    }
    ///Function to draw graphics
    private func setLineChart(with data: NSMutableDictionary) -> PNLineChart {
        let lineChart = PNLineChart(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: graphicView.frame.size.width,
                                                  height: graphicView.frame.size.height))
        lineChart.yLabelFormat = "%.3f"
        lineChart.showLabel = true
        lineChart.backgroundColor = UIColor.clear
        let keys = orderKeys(with: data)
        lineChart.xLabels = keys
        lineChart.showCoordinateAxis = true
        lineChart.axisColor = UIColor(named: "DescribeText")!
        let dataArr = orderRates(with: data, keys: keys)
        let data = PNLineChartData()
        data.color = PNLightBlue
        data.itemCount = dataArr.count
        data.inflexPointStyle = .Cycle
        data.getData = ({
            (index: Int) -> PNLineChartDataItem in
            let cgf = dataArr[index] as? NSNumber
            let yValue = CGFloat(truncating: cgf!)
            let item = PNLineChartDataItem(y: yValue)
            return item
        })
            
        lineChart.chartData = [data]
        lineChart.strokeChart()
        return lineChart
    }
    //MARK: - ButtonBack press
    ///IBAction to change graphics
    @IBAction func indexChange(_ sender: Any) {
        presenter?.checkDate()
        switch segmentControl.selectedSegmentIndex {
        case 0:
            if mutableDataW?.count ?? 0 > 0 {
                presenter?.showGrafic(with: mutableDataW ?? NSMutableDictionary())
            }else{
                presenter?.callService(with: SearchCase.week.rawValue)
            }
            break
        case 1:
            if mutableDataOM?.count ?? 0 > 0 {
                presenter?.showGrafic(with: mutableDataOM ?? NSMutableDictionary())
            }else{
                presenter?.callService(with: SearchCase.oneMonth.rawValue)
            }
            break
        case 2:
            if mutableDataTM?.count ?? 0 > 0 {
                presenter?.showGrafic(with: mutableDataTM ?? NSMutableDictionary())
            }else{
                presenter?.callService(with: SearchCase.twoMonths.rawValue)
            }
            break
        default:
            break
        }
    }
}
//MARK: - Protocol extension
///Extension to protocol functions
extension MainViewSwiftViewController: MainViewSwiftViewProtocol{
    ///Function to evaluate show graphics or go to services
    func initView(){
        if (mutableDataW?.count ?? 0 == 0){
            presenter?.callService(with: SearchCase.week.rawValue)
       }else{
            presenter?.showGrafic(with: mutableDataW ?? NSMutableDictionary())
        }
    }
    ///Protocol to show graphics
    func showGrafic(with data: NSMutableDictionary) {
        graphicView.addSubview(setLineChart(with: data))
    }
    ///Protocol to delet graphics
    func deleteSubviews(){
        for view in graphicView.subviews{
            view.removeFromSuperview()
        }
    }
    ///Protocol to check data in memory
    func initRates(){
        let dateKey = date.getFormattedDate(format: Constants.formatDate)
        var key: String = "\(dateKey)w"
        if mutableDataW?.count ?? 0 == 0 {
            let dataD = UserDefaults.standard.dictionary(forKey: key)
            mutableDataW = NSMutableDictionary(dictionary: dataD ?? NSMutableDictionary() as! [String : Any] as NSDictionary as! [String : Any])
        }
        if mutableDataOM?.count ?? 0 == 0 {
            key = "\(dateKey)om"
            let dataOm = UserDefaults.standard.dictionary(forKey: key)
            mutableDataOM = NSMutableDictionary(dictionary: dataOm ?? NSMutableDictionary() as! [String : Any] as NSDictionary as! [String : Any])
        }
        if mutableDataTM?.count ?? 0 == 0 {
            key = "\(dateKey)tm"
            let dataTm = UserDefaults.standard.dictionary(forKey: key)
            mutableDataTM = NSMutableDictionary(dictionary: dataTm ?? NSMutableDictionary() as! [String : Any] as NSDictionary as! [String : Any])
        }
    }
    ///Protocol to chck date
    func checkDate() {
        let defaults = UserDefaults.standard
        let dateKey = date.getFormattedDate(format: Constants.formatDate)
        let key: String = defaults.object(forKey: "Date") as! String
        if key != dateKey {
            mutableDataW = NSMutableDictionary()
            mutableDataOM = NSMutableDictionary()
            mutableDataTM = NSMutableDictionary()
            defaults.removeObject(forKey: "\(key)w")
            defaults.removeObject(forKey: "\(key)om")
            defaults.removeObject(forKey: "\(key)tm")
            defaults.synchronize()
        }
    }
}
