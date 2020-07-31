//
//  ViewController.swift
//  CountryList
//
//  Created by Helder on 30/07/20.
//  Copyright © 2020 Helder de Melo Sérvio Filho. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var countries: [CountryInfo] = []
    var flags: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        if let storedcountries = UserDefaults.standard.data(forKey: "countries") {
            performSelector(inBackground: #selector(decodeData(_:)), with: storedcountries)
        } else {
            performSelector(inBackground: #selector(loadCountries), with: nil)
        }
    }
    
    @objc func loadCountries() {
        if let url = URL(string: "https://restcountries.eu/rest/v2/all") {
            if let countryListJSON = try? Data(contentsOf: url) {
                UserDefaults.standard.set(countryListJSON, forKey: "countries")
                decodeData(countryListJSON)
            } else {
                print("COULD NOT LOAD URL AS DATA")
            }
        } else {
            print("NOT URL")
        }
    }
    
    @objc func decodeData(_ data: Data) {
        let jsonDecoder = JSONDecoder()
        do {
            let countryInfo = try jsonDecoder.decode([CountryInfo].self, from: data)
            countries = countryInfo
            for country in countryInfo {
                if let flag = UIImage(contentsOfFile: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(country.alpha2Code).png").path) {
                    flags.append(flag)
                } else {
                    guard let url = URL(string: "https://www.countryflags.io/\(country.alpha2Code)/flat/64.png"), let data = try? Data(contentsOf: url), let flag = UIImage(data: data) else { continue }
                    do {
                        try data.write(to: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(country.alpha2Code).png"))
                    } catch {
                        print("Error saving image")
                    }
                    flags.append(flag)
                }
            }
        } catch {
            print(error)
        }
        performSelector(onMainThread: #selector(insertNewRows), with: nil, waitUntilDone: false)
    }
    
    @objc func insertNewRows() {
        var indexPathArray = [IndexPath]()
        for index in 0..<countries.count {
            indexPathArray.append(IndexPath(row: index, section: 0))
        }
        tableView.insertRows(at: indexPathArray, with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        cell.imageView?.image = flags[indexPath.row]
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dtvc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailTableViewController {
            dtvc.name = countries[indexPath.row].name
            dtvc.capital = countries[indexPath.row].capital
            dtvc.population = countries[indexPath.row].population
            dtvc.currencies = countries[indexPath.row].currencies.map{($0.code ?? "-")}
            dtvc.languages = countries[indexPath.row].languages.map{$0.name}
            navigationController?.pushViewController(dtvc, animated: true)
        }
    }


}

