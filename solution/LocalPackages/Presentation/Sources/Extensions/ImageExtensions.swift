//
//  ImageExtensions.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import SwiftUI

extension Image {
    static var archive: some View { icon(for: .archive) }
    static var assignPerson: some View { icon(for: .assignPerson) }
    static var callInfo: some View { icon(for: .callInfo) }
    static var history: some View { icon(for: .history) }
    static var inboundCall: some View { icon(for: .inboundCall) }
    static var notes: some View { icon(for: .notes) }
    static var outboundCall: some View { icon(for: .outboundCall) }
    static var tags: some View { icon(for: .tags) }
    static var unarchive: some View { icon(for: .unarchive) }
    static var unkownContact: some View { icon(for: .unkownContact, sized: Constants.defaultAvatarSize) }

    static func icon(for symbol: SFSymbol, sized: CGFloat = Constants.defaultIconSize) -> some View {
        Image(systemName: symbol.rawValue)
            .font(.system(size: sized, weight: .light))
    }
}
