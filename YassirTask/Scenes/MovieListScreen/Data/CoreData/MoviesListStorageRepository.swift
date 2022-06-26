//
//  CoreDataManager.swift
//  YassirTask
//
//  Created by Zeyad Badawy on 26/06/2022.
//

import RxSwift
import CoreData

protocol MoviesStorageProtocol {
    func fetchAll(sortDescriptors: [NSSortDescriptor]) -> Observable<Result<[MovieData], BaseError>>
    func saveAll(_ movies: [MovieData])
    func save(_ movieData: MovieData)
    func deleteAll()
}

class MoviesListStorageRepository{
    private let mainContext: NSManagedObjectContext
    private let backgroundContext: NSManagedObjectContext
    
    init(
        mainContext: NSManagedObjectContext = CoreDataManager.shared.mainContext,
        backgroundContext: NSManagedObjectContext = CoreDataManager.shared.backgroundContext
    ) {
        self.mainContext = mainContext
        self.backgroundContext = backgroundContext
    }
}

// MARK: - MoviesStorageProtocol

extension MoviesListStorageRepository: MoviesStorageProtocol {
    func fetchAll(
        sortDescriptors: [NSSortDescriptor] = []
    ) -> Observable<Result<[MovieData], BaseError>> {
        let fetchRequest = MovieDataEntity.fetchRequest()
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.returnsObjectsAsFaults = false
        
        var moviesDataEntities: [MovieDataEntity] = .init()
        
        mainContext.performAndWait {
            do {
                moviesDataEntities = try mainContext.fetch(fetchRequest)
            } catch {
                print("Error fetching logs, error: \(error.localizedDescription)")
            }
        }
        
        return Observable<Result<[MovieData], BaseError>>.create { observer in
            let moviesData = moviesDataEntities.map({
                $0.getMovieData()
            })
            observer.onNext(.success(moviesData))
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func saveAll(_ movies: [MovieData]) {
        movies.forEach { movie in
            save(movie)
        }
    }
    
    func save(_ movieData: MovieData) {
        backgroundContext.performAndWait {
            let newMovieDataEntity = MovieDataEntity(context: backgroundContext)
            newMovieDataEntity.setData(with: movieData)
            
            save(backgroundContext)
        }
    }
    
    func deleteAll() {
        let deleteRequest = NSBatchDeleteRequest(
            fetchRequest: MovieDataEntity.fetchRequest()
        )
        
        backgroundContext.performAndWait {
            do {
                try backgroundContext.execute(deleteRequest)
                try backgroundContext.save()
            } catch {
                print("Error deleting all logs, error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Private Methods

private extension MoviesListStorageRepository {
    func save(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            fatalError("Can't save Context with error: \(error)")
        }
    }
}
