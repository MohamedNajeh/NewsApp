//
//  ViewController.swift
//  NewsApp
//
//  Created by MohamedNajeh on 22/02/2023.
//

import UIKit
import FittedSheets
import MBProgressHUD
class NewsVC: UIViewController {
    
    @IBOutlet weak var connectionStatusLbl: UILabel!
    @IBOutlet weak var connectionView: UIView!
    @IBOutlet weak var tableView: UITableView!
    let viewModel = NewsViewModel()
    var news:[Article] = []
    var hud: MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        viewModel.getNews()
        bindData()
        addObservers()
    }
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(showOfflineDeviceUI(notification:)), name: NSNotification.Name.connectivityStatus, object: nil)
    }
    
    @objc func showOfflineDeviceUI(notification: Notification) {
        if NetworkMonitor.shared.isConnected {
            handleConnectionView(isConnected:true)
        } else {
            handleConnectionView(isConnected:false)
        }
    }
    
    func handleConnectionView(isConnected:Bool) {
        print("connection \(isConnected)")
        DispatchQueue.main.async {
            self.connectionView.backgroundColor = isConnected ? .green : .red
            self.connectionStatusLbl.text       = isConnected ? "Connected" : "Check your connection"
            self.connectionView.isHidden        = false
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                self.connectionView.isHidden    = isConnected ? true : false
            }
        }
    }
    
    func bindData(){
        
        viewModel.isLoading.bind { [weak self] isLoading in
            switch isLoading {
            case true:
                DispatchQueue.main.async {
                    guard let view = self?.view else { return }
                    self?.hud = MBProgressHUD.showAdded(to: view, animated: true)
                    self?.hud?.label.text = "Loading"
                }
            case false:
                DispatchQueue.main.async {
                    self?.hud?.hide(animated: true)
                }
            }
        }
        
        viewModel.news.bind { [weak self] news in
            guard let news = news else { return }
            self?.news = news.articles ?? []
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.errorMessage.bind { message in
            guard let message = message else { return }
            DispatchQueue.main.async {
                AlertsManager.showAlert(withTitle: "ERROR", message: message, viewController: self)
            }
        }
    }
    
    
}


extension NewsVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.configureCell(article: news[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewDetailsVC") as! NewDetailsVC
        vc.details = news[indexPath.row]
        
        let sheetController = SheetViewController(controller: vc, sizes: [.percent(0.70)])
        sheetController.allowPullingPastMaxHeight = false
        sheetController.gripColor = .label
        present(sheetController, animated: true)
        
        
    }
    
    
}
