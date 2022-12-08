//
//  ContentView.swift
//  BTreeMac
//
//  Created by Nicky Taylor on 12/4/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(systemName: "xmark")
                        .font(.system(size: 150).bold())
                        .foregroundColor(.red)
                    Image(systemName: "xmark")
                        .font(.system(size: 150).bold())
                        .foregroundColor(.red)
                    Image(systemName: "xmark")
                        .font(.system(size: 150).bold())
                        .foregroundColor(.red)
                }
                Text("Nobody Likes You")
                    .font(.system(size: 56).bold())
                    .foregroundColor(.red)
                HStack {
                    Image(systemName: "xmark")
                        .font(.system(size: 150).bold())
                        .foregroundColor(.red)
                    Image(systemName: "xmark")
                        .font(.system(size: 150).bold())
                        .foregroundColor(.red)
                    Image(systemName: "xmark")
                        .font(.system(size: 150).bold())
                        .foregroundColor(.red)
                }
            }
        }
        .frame(width: 640, height: 480)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
