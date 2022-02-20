//
//  ViewController.swift
//  TableViewUpdates
//
//  Created by Yossan Rahmadi on 20/02/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var todoData: [Todo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Todo List"

        todoData = createDummyData()

        configureTableView()
    }

    func configureTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoCell")
    }

    func createDummyData() -> [Todo] {
        var todoData: [Todo] = []

        for i in 0..<10 {
            todoData.append(Todo(id: UUID(), title: "Todo \(i + 1)", done: false))
        }

        return todoData
    }

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoTableViewCell

        cell.titleLabel.text = todoData[indexPath.row].title
        cell.done = todoData[indexPath.row].done
        cell.delegate = self

        return cell
    }

}

extension ViewController: TodoTableViewCellDelegate {

    func updateRow(at cell: UITableViewCell, done: Bool) {
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.performBatchUpdates({
                if done {
                    tableView.moveRow(at: indexPath, to: IndexPath(row: todoData.count - 1, section: 0))
                } else {
                    tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
                }
            }, completion: nil)
        }
    }

}

