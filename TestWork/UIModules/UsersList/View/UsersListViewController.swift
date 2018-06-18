//
//  UsersListViewController.swift
//  TestWork
//
//  Created by Viktor Miroshnychenko on 6/14/18.
//  Copyright © 2018 FoxHound. All rights reserved.
//

import Foundation
import UIKit

class UsersListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let viewModel = UsersViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80

        loadUsersList()
    }

    private func loadUsersList() {
        if viewModel.isUserFollowersList {
            viewModel.getUserFollowers {
                self.tableView.reloadData()
            }
        } else {
            viewModel.getUsersList {
                self.tableView.reloadData()
            }
        }
    }

}

extension UsersListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if let userElement = viewModel.users[exist: indexPath.row] {
            if indexPath.row == viewModel.users.count - 1 {
                viewModel.since = userElement.id
                viewModel.getUsersList {
                    self.tableView.reloadData()
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let userElement = viewModel.users[exist: indexPath.row] {
            let storyboard = UIStoryboard(name: "Users", bundle: nil)
            let usersListViewController = storyboard.instantiateViewController(withIdentifier: "usersViewController") as! UsersListViewController
            usersListViewController.viewModel.isUserFollowersList = true
            usersListViewController.viewModel.followersUsername = userElement.login
            navigationController?.pushViewController(usersListViewController, animated: true)
        }
    }
}

extension UsersListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let userElement = viewModel.users[exist: indexPath.row] {
            let userCell = tableView.dequeueReusableCell(withIdentifier: String(describing: UsersTableViewCell.self), for: indexPath) as! UsersTableViewCell
            userCell.userAvatarImageView.kf.setImage(with: URL(string: userElement.avatarURL))
            userCell.userLoginLabel.text = userElement.login
            userCell.userProfileLinkTextView.text = userElement.htmlURL
            return userCell
        } else {
            return UITableViewCell()
        }
    }
}
