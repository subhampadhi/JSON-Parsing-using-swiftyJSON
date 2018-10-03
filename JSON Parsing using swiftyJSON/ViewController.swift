//
//  ViewController.swift
//  JSON Parsing using swiftyJSON
//
//  Created by Subham Padhi on 04/10/18.
//  Copyright © 2018 Subham Padhi. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var petiArray = [String?]()
    var judgeArray = [String?]()
    var citaArray = [String?]()
    var linkArray = [String?]()
    var yearArray = [String?]()
    var monthArray = [String?]()
    var typeArray = [String?]()
    var indexArray = [String?]()
    var value = String()
    var item = String()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
        //setting values
        
        cell.caseLabel.text = petiArray[indexPath.row]
        cell.judgeLabel.text = judgeArray[indexPath.row]
        cell.dateLabel.text = citaArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.title = "API PARSING"
        navigationController?.navigationBar.prefersLargeTitles = true
        showLoadingAlert()
        setUpViews()
        downloadJson()
    }
    
    func showLoadingAlert(){
        let alert = UIAlertController(title: nil, message: "Loading", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
    }
    
    func downloadJson(){
        guard let url = URL(string: "http://adjonline.com/mojito/advsearchnew.php?inputtext=aman") else { print("returning")
            return}
        print("download josn working")
        var downloadTask = URLRequest(url: (url as URL?)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 60)
        
        _ = URLRequest(url:(url as URL?)!)
        downloadTask.httpMethod =  "GET"
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if(error != nil) {
                self.dismiss(animated: true, completion: nil)
                self.showAlert(title: "Oops!", message: "Error in Parsing", presenter: self)
                print(error!)
            }else{
                do{
                    let json = try JSON(data:data!)
                    var i = 0;
                    if (json[0]["link"].exists() == false) {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                            self.showAlert(title: "Oops", message: "Sorry! No result found ", presenter: self)
                        }
                    }
                    while(json[i]["cita1"].string != nil) {
                        if let cita = json[i]["cita1"].string{
                            self.indexArray.append("\(i)" as String)
                            self.citaArray.append(cita as String)
                            print(i)
                            print(cita)
                        }
                        if let judge = json[i]["jud"].string {
                            self.judgeArray.append(judge as String)
                        }
                        if let rows = json[i]["rows"].string {
                            self.value = rows
                        }
                        if let peti = json[i]["peti"].string {
                            self.petiArray.append(peti as String)
                        }
                        if let link1 = json[i]["link"].string {
                            let link = link1.replacingOccurrences(of: " ", with: "%20")
                            self.linkArray.append(link as String)
                        }
                        if let year = json[i]["yer"].string {
                            self.yearArray.append(year as String)
                        }
                        if let month = json[i]["mn"].string {
                            self.monthArray.append(month as String)
                        }
                        if let type = json[i]["typ"].string {
                            self.typeArray.append(type as String)
                        }
                        i+=1;
                    }
                }catch{
                    print("JSON FAILED")
                }
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                    self.tableView.reloadData()
                }
            }
            }.resume()
    }
    
        func showAlert(title: String, message: String, presenter: UIViewController) {
            let alert = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        presenter.present(alert, animated: true, completion: nil)
    }
    
    var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .none
        return view
    }()
    
    func setUpViews(){
        
        //setting constraints for tableView
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

class TableViewCell: UITableViewCell {
    
    // setting up the card view
    
    var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 3
        return view
    }()
    
    var caseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Hiragino Mincho ProN W6", size: 18)
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.1215686277, green: 0.1294117719, blue: 0.1411764771, alpha: 1)
        label.text = "National holiday mainView mainView mainView mainView mainView mainView mainView"
        return label
    }()
    
    var judgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Hiragino Mincho ProN W3", size: 17)
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 0.5430480647, green: 0.07645688873, blue: 0, alpha: 1)
        label.textAlignment = NSTextAlignment.center
        label.text = "National holiday vs State"
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Hiragino Mincho ProN W6", size: 10)
        label.textColor = #colorLiteral(red: 0.1215686277, green: 0.1294117719, blue: 0.1411764771, alpha: 1)
        label.textAlignment = NSTextAlignment.left
        label.text = "12 July,2018"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        addSubview(mainView)
        addSubview(caseLabel)
        addSubview(judgeLabel)
        addSubview(dateLabel)
        
        mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7.5).isActive = true
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        mainView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7.5).isActive = true
        
        caseLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant:10).isActive = true
        caseLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
        caseLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5).isActive = true
        
        judgeLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant:10).isActive = true
        judgeLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
        judgeLabel.topAnchor.constraint(equalTo: caseLabel.bottomAnchor, constant: 10).isActive = true
        
        dateLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant:10).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8).isActive = true
    }
}

