//
//  CallInfoProviderViewModel.swift
//  
//
//  Created by Jobert on 25/06/2021.
//

import Domain
import Foundation

public class CallInfoProviderViewModel: CallDetailsItemViewModel {
    let flagIcon: ImageAsset
    let number: String
    let provider: String

    init(_ call: Call) {
        flagIcon = call.from.flagAsset
        number = call.from
        provider = call.via
    }
}

private extension String {
    var flagAsset: ImageAsset {
        switch self {
        case let string where string.hasPrefix("+61"): return Asset.CountryFlag.at
        case let string where string.hasPrefix("+55"): return Asset.CountryFlag.br
        case let string where string.hasPrefix("+41"): return Asset.CountryFlag.ch
        case let string where string.hasPrefix("+45"): return Asset.CountryFlag.dk
        case let string where string.hasPrefix("+34"): return Asset.CountryFlag.es
        case let string where string.hasPrefix("+33"): return Asset.CountryFlag.fr
        case let string where string.hasPrefix("+44"): return Asset.CountryFlag.gb
        case let string where string.hasPrefix("+972"): return Asset.CountryFlag.il
        case let string where string.hasPrefix("+31"): return Asset.CountryFlag.nl
        case let string where string.hasPrefix("+64"): return Asset.CountryFlag.nz
        case let string where string.hasPrefix("+1"): return Asset.CountryFlag.us
        default: return Asset.CountryFlag.fr
        }
    }
}
