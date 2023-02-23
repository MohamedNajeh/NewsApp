//
//  NewsCell.swift
//  NewsApp
//
//  Created by MohamedNajeh on 22/02/2023.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(article:Article) {
        self.author.text = article.author
        self.title.text  = article.title
        self.descriptionLbl.text = article.description?.removeHTMLTags()
    }
    
}

extension String {
    func removeHTMLTags() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
