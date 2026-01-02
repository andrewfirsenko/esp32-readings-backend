//
//  Configure.swift
//  App
//
//  Created by Andrew on 01.01.2026.
//

import Vapor
import FluentSQLiteDriver

public func configure(_ app: Application) async throws {
    // DB
    if app.environment.isRelease {
        app.databases.use(.sqlite(.file("databases/esp32-measurements-db.sqlite")), as: .sqlite)
    } else {
        app.databases.use(.sqlite(.memory), as: .sqlite)
    }
    
    // Migrations
    app.migrations.add(Measurement.Migration())
    try await app.autoMigrate()
    
    // Routes
    try await routes(app)
}
