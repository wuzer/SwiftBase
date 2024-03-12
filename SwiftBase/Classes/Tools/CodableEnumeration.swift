//
//  CodableEnumeration.swift
//  TMServiceReportModule_Example
//
//  Created by 张华康 on 2020/8/13.
//  Copyright © 2020 CocoaPods. All rights reserved.
//


public protocol CodableEnumeration: RawRepresentable, Codable where RawValue: Codable {
    static var defaultCase: Self { get }
}

public extension CodableEnumeration {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let decoded = try container.decode(RawValue.self)
            self = Self.init(rawValue: decoded) ?? Self.defaultCase
        } catch {
            self = Self.defaultCase
        }
    }
}
