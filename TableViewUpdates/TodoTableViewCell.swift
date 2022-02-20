//
//  TodoTableViewCell.swift
//  TableViewUpdates
//
//  Created by Yossan Rahmadi on 20/02/22.
//

import UIKit

protocol TodoTableViewCellDelegate: AnyObject {
    func updateTable(cell: UITableViewCell, done: Bool)
}

class TodoTableViewCell: UITableViewCell {

    weak var delegate: TodoTableViewCellDelegate?

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet private weak var checkButton: UIButton!

    var done: Bool = false {
        willSet(newDoneValue) {
            if newDoneValue {
                checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            } else {
                checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction private func checkButtonTouched(_ sender: UIButton) {
        done = !done
        self.delegate?.updateTable(cell: self, done: done)
    }
    
}
