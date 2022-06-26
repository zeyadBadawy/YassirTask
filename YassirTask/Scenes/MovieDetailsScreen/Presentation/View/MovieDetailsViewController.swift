//
//  MovieDetailsViewController.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 24/06/2022.
//

import RxCocoa
import RxSwift

class MovieDetailsViewController: BaseViewController {
    
    //MARK: UI PROPERTIES
    @IBOutlet weak var posterBG:UIView!
    @IBOutlet weak var posterImgageView:UIImageView!
    @IBOutlet weak var movieNameLabel:UILabel!
    @IBOutlet weak var movieOverviewLabel:UILabel!
    
    @IBOutlet weak var releaseDataLabel:UILabel!
    @IBOutlet weak var releaseDataView:UIView!
    
    @IBOutlet weak var reteLabel:UILabel!
    @IBOutlet weak var reteView:UIView!
    
    @IBOutlet weak var categoryLabel:UILabel!
    @IBOutlet weak var categoryView:UIView!
    
    //MARK: PROPERTIES
    private var viewModel:MovieDetailsViewModel
    
    //MARK: LIFECYCLE
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureLoadingAndAlertViews()
        bindToMovieData()
        viewModel.fetchMovie()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.largeTitleDisplayMode = .never
    }
    
}
//MARK: PRIVATE METHODS
private extension MovieDetailsViewController {
    func configureViews() {
        let firstColor = UIColor.darkGray
        let secondColor = UIColor(hexString: "#181A1F")
        posterBG.applyGradient(isVertical: true, colorArray: [firstColor,secondColor])
        releaseDataView.layer.cornerRadius = 12
        reteView.layer.cornerRadius = 12
        categoryView.layer.cornerRadius = 12
        posterImgageView.clipsToBounds = true
        posterImgageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        posterImgageView.layer.cornerRadius = 16
    }
    
    func bindToMovieData() {
        viewModel
            .movieSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (movieDetails) in
                guard let self = self else { return }
                
                self.posterImgageView.loadImage(fromURL: movieDetails.posterFullURL ?? "")
                self.movieNameLabel.text = movieDetails.originalTitle ?? ""
                self.movieOverviewLabel.text = movieDetails.overview ?? ""
                self.releaseDataLabel.text = movieDetails.releaseDate ?? ""
                self.reteLabel.text = "\(movieDetails.voteAverage ?? 0)"
                self.categoryLabel.text = movieDetails.genres?.first?.name ?? ""
        }).disposed(by: disposeBag)
    }
}

// MARK: - AlertDisplayer & LoadingDisplayer

extension MovieDetailsViewController: AlertDisplayerProtocol, LoadingDisplayerProtocol {
    func configureLoadingAndAlertViews() {
        bindLoadingIndicator(to: viewModel.stateRelay)
        bindAlert(to: viewModel.alertItemRelay)
    }
}
