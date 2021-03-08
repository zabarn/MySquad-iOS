//
//  ProfileViewController.swift
//  MySquad
//
//  Created by Zach Barnett on 3/6/21.
//

import UIKit

struct Section{
    let title: String
    let options: [ProfileOption]
}

struct ProfileOption{
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        return table
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Profile"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    func configure(){
        models.append(Section(title: "Personal", options: [
            ProfileOption(title: "Console", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemRed){
                self.performSegue(withIdentifier: "ProfileToPersonal", sender: nil)
            },
            ProfileOption(title: "Bluetooth", icon: UIImage(systemName: "bluetooth"), iconBackgroundColor: .link){
                                    
            },
            ProfileOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemGreen){
                                    
            },
            ProfileOption(title: "iCloud", icon: UIImage(systemName: "cloud"), iconBackgroundColor: .systemOrange){
                                    
            }
        ]))
        
        models.append(Section(title: "Information", options: [
            ProfileOption(title: "Wifi", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemRed){
                                    
            },
            ProfileOption(title: "Bluetooth", icon: UIImage(systemName: "bluetooth"), iconBackgroundColor: .link){
                                    
            },
            ProfileOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemGreen){
                                    
            },
            ProfileOption(title: "iCloud", icon: UIImage(systemName: "cloud"), iconBackgroundColor: .systemOrange){
                                    
            }
        ]))
        
        models.append(Section(title: "Apps", options: [
            ProfileOption(title: "Wifi", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemRed){
                                    
            },
            ProfileOption(title: "Bluetooth", icon: UIImage(systemName: "bluetooth"), iconBackgroundColor: .link){
                                    
            },
            ProfileOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemGreen){
                                    
            },
            ProfileOption(title: "iCloud", icon: UIImage(systemName: "cloud"), iconBackgroundColor: .systemOrange){
                                    
            }
        ]))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileTableViewCell.identifier,
            for: indexPath
        ) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
        
    }
}
