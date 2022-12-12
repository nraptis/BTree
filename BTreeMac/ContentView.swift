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
                    Image(systemName: "paperplane.circle.fill")
                        .font(.system(size: 150).bold())
                        .foregroundColor(.blue)
                    Image(systemName: "paperplane.circle.fill")
                        .font(.system(size: 150).bold())
                        .foregroundColor(.red)
                    Image(systemName: "paperplane.circle.fill")
                        .font(.system(size: 150).bold())
                        .foregroundColor(.green)
                }
                Text("BTree Unit Test Suite")
                    .font(.system(size: 54).bold())
                    .foregroundColor(.white)
                    .padding(.all, 0)
                HStack {
                    Image(systemName: "paperplane.circle.fill")
                        .font(.system(size: 150).bold())
                        .foregroundColor(.red)
                    Image(systemName: "paperplane.circle.fill")
                        .font(.system(size: 150).bold())
                        .foregroundColor(.green)
                    Image(systemName: "paperplane.circle.fill")
                        .font(.system(size: 150).bold())
                        .foregroundColor(.blue)
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
