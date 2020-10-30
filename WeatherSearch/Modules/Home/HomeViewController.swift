//
//  HomeViewController.swift
//  WeatherSearch
//
//  Created by Admin on 30.10.2020.
//

import UIKit


class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = HomeViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        
        self.viewModel.loadStandartCities() { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func configureViews() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(WeatherCell.nib, forCellReuseIdentifier: WeatherCell.identifier)
        
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.delegate = self
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.weatherCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
        let weatherCity = viewModel.weatherCities[indexPath.row]
        cell.configure(with: weatherCity)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherCity = viewModel.weatherCities[indexPath.row]
        let viewModel = DetailWeatherViewModel(weather: weatherCity)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailWeatherViewController") as! DetailWeatherViewController
        vc.viewModel = viewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let city = searchController.searchBar.text else { return }
        
        viewModel.loadSearchCity(for: city) { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension HomeViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        viewModel.loadStandartCities { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
