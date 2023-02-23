//
//  imageView+Ext.swift
//  NewsApp
//
//  Created by MohamedNajeh on 22/02/2023.
//

import Kingfisher
import UIKit

extension UIImageView {
    func  setImage(with url : String){
        guard let url = URL(string: url) else { return }
        let placeHolderImage = UIImage(named: "image")
        kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: placeHolderImage, options: [.transition(.fade(1))])
    }
}
