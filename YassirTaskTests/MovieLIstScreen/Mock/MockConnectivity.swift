//
//  MockReachability.swift
//  YassirTaskTests
//
//  Created by Zeyad Badawy on 26/06/2022.
//

@testable import YassirTask

final class MockConnectedConectivity: ConectivityProtocol {
    func isConnectedToNetwork() -> Bool {
        return true
    }
}

final class MockNotConnectedConectivity: ConectivityProtocol {
    func isConnectedToNetwork() -> Bool {
        return false
    }
}
