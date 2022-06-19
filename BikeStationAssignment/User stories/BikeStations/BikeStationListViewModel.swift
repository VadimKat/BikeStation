//
//  BikeStationListViewModel.swift
//  BikeStationAssignment
//
//  Created by Vadim Katenin on 18.06.2022.
//

import Foundation
import Combine
import CoreLocation

extension BikeStationListViewModel {
    enum StationListError: LocalizedError {
        case unknownError
        
        var errorDescription: String? {
            switch self {
            case .unknownError:
                return "Unknown error has occured. Please, try again later"
            }
        }
    }
    
    enum FeedbackToUser: Identifiable {
        case error(String)
        
        var id: String { "\(self)" }
    }
}

class BikeStationListViewModel: ObservableObject {
    @Published var stationsList: [Feature] = []
    @Published var feedback: FeedbackToUser?
    @Published var isLoading: Bool = false
    @Published var userLocation: CLLocationCoordinate2D?
    
    private let locationManager: LocationManager
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(locationManager: LocationManager = .shared) {
        self.locationManager = locationManager
        setupBindings()
    }
    
    private func setupBindings() {
        getStations()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] in
                self?.isLoading = false
                switch $0 {
                case let .failure(error):
                    self?.feedback = .error(error.localizedDescription)
                case .finished: break
                }
            }) { [weak self] value in
                self?.stationsList = value.features
            }
            .store(in: &subscriptions)
        
        locationManager.$locationError
            .compactMap { $0?.localizedDescription }
            .map { FeedbackToUser.error($0) }
            .assignWeak(to: \.feedback, on: self)
            .store(in: &subscriptions)
        
        locationManager.$userLocation
            .removeDuplicates()
            .assignWeak(to: \.userLocation, on: self)
            .store(in: &subscriptions)
    }
    
    private func getStations() -> AnyPublisher<BikeStationListModel, Error> {
        let urlString = "http://www.poznan.pl/mim/plan/map_service.html?mtype=pub_transport&co=stacje_rowerowe"
        guard let url = URL(string: urlString) else { return Fail(error: StationListError.unknownError).eraseToAnyPublisher() }
        
        isLoading = true
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: BikeStationListModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
