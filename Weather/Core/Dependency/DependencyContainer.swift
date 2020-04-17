//
//  DependencyContainer.swift
//  CovidTracker
//
//  Created by Maxime Maheo on 26/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

private struct DependencyKey: Hashable {
    
    // MARK: - Properties
    private let dependencyType: Any.Type

    // MARK: - Lifecycle
    init(dependencyType: Any.Type) {
        self.dependencyType = dependencyType
    }
    
    // MARK: - Methods
    static func == (lhs: DependencyKey, rhs: DependencyKey) -> Bool {
        lhs.dependencyType == rhs.dependencyType
    }
    
    func hash(into hasher: inout Hasher) {
        ObjectIdentifier(dependencyType).hash(into: &hasher)
    }
}

private protocol DependencyEntryProtocol {
    var dependencyType: Any.Type { get }
    var factory: Any { get }
}

private final class DependencyEntry<Dependency>: DependencyEntryProtocol {
    
    // MARK: - Properties
    var dependencyType: Any.Type
    var factory: Any
    
    // MARK: - Lifecycle
    init(dependencyType: Dependency.Type, factory: Any) {
        self.dependencyType = dependencyType
        self.factory = factory
    }
}

final class DependenciesContainer {
    
    // MARK: - Properties
    private var dependencies: [DependencyKey: DependencyEntryProtocol] = [:]
    
    func register<Dependency>(_ dependencyType: Dependency.Type, factory: @escaping () -> Dependency) {
        let key = DependencyKey(dependencyType: Dependency.self)
        let dependency = DependencyEntry(dependencyType: dependencyType, factory: factory)
        
        dependencies[key] = dependency
    }
    
    func resolve<Dependency>() -> Dependency? {
        let key = DependencyKey(dependencyType: Dependency.self)
        let dependency = dependencies[key]
        
        let factory = dependency?.factory as? () -> Dependency
        
        return factory?()
    }
}
