//
//  Assembly.swift
//  Restaurants
//
//  Created by Svyatoslav Katola on 25.01.2021.
//

import Dip

let assembly: Assembly = .init(services: .services(), core: .core())

struct Assembly {
    
    let core: CoreContainer
    let services: ServicesContainer
    
    fileprivate init(services: DependencyContainer, core: DependencyContainer) {
        self.core = core
        self.services = services
        
        services.collaborate(with: core)
    }
}
