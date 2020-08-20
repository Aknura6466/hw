//
//  ViewController.swift
//  Hw
//
//  Created by Акнур on 8/20/20.
//  Copyright © 2020 Акнур. All rights reserved.
//

import UIKit

class ViewController:  UITableViewController {
let  searchBar = UISearchBar()
    var  listofHolidays = [HolidayDetail]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listofHolidays.count)"
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listofHolidays.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for : indexPath)
        return cell
        let holiday = listofHolidays[indexPath.row]
        cell.textLabel?.text = holiday.name
        cell.detailTextLabel?.text = holiday.date.iso
    }
}
extension ViewController : UISearchBarDelegate{
func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {return}
        let holidayRequest =  HolidayRequest(countryCode: searchBarText)
        
    HolidayRequest.getHolidays{[weak self] result in
            switch result{
            case .failure(let error):
                print(error)
            case success(let holidays):
                self?.listofHolidays = holidays
            }
        }
    }
    
}
