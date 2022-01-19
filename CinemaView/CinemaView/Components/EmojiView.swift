//
//  EmojiView.swift
//  CinemaView
//
//  Created by Monica Galan de la Llana on 19/1/22.
//

import SwiftUI

struct EmojiView: View {
    var body: some View {
        Text("\(String.randomEmoji)")
            .font(.title)
            .lineLimit(1)
    }
}

extension String {
    static var randomEmoji: String {
        let range = [UInt32](0x1F600...0x1F64F)
        let ascii = range[Int(drand48() * (Double(range.count)))]
        let emoji = UnicodeScalar(ascii)?.description
        return emoji!
    }
}
