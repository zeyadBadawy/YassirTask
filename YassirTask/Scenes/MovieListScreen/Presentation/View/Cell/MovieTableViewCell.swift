//
//  MovieTableViewCell.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 23/06/2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //MARK: IU PROPERTIES

    @IBOutlet weak var moviePosterImageView:UIImageView!
    @IBOutlet weak var movieNameLabel:UILabel!
    @IBOutlet weak var movieOverviewLabel:UILabel!
    @IBOutlet weak var movieReleaseDateLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with movie:MovieData) {
        self.moviePosterImageView.loadImage(fromURL: movie.posterFullURL ?? "")
        self.movieNameLabel.text = movie.originalTitle
        self.movieOverviewLabel.text = movie.overview
        self.movieReleaseDateLabel.text = movie.releaseDate ?? ""
    }
    
}
