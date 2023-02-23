//
//  NewDetailsVC.swift
//  NewsApp
//
//  Created by MohamedNajeh on 22/02/2023.
//

import UIKit

class NewDetailsVC: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var sourceLbl: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var publishedDateLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var details:Article?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }
    
    func setUpView(){
        titleLbl.text = details?.title
        authorLbl.text = details?.author
        publishedDateLbl.text = details?.publishedAt
        descriptionLbl.text   = details?.description?.removeHTMLTags()
        imgView.setImage(with: details?.urlToImage ?? "")
        sourceLbl.setTitle(self.details?.url, for: .normal)
        imgView.layer.cornerRadius = 20
    }
    
    @IBAction func sourceBtnClicked(_ sender: Any) {
        guard let url = URL(string: details?.url ?? "") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
