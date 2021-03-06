//
//  DiscoverTabView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import SwiftUI

/// Reduce spacing between sections SwiftUI
/// https://stackoverflow.com/a/62186463/5972156
///
/// Globally Reduce spacing between sections SwiftUI
/// https://stackoverflow.com/a/68396510/5972156

struct DiscoverTabView: View {
    
    var body: some View {
        List {
            VStack(spacing: 0) {
                NavigationLink {
                    MomentsView()
                } label: {
                    momentRow
                }
                .padding()
                
                sectionSpacing
            }
            .listRowInsets(EdgeInsets())
                            
            VStack(spacing: 0) {
                NavigationLink {
                    ChannelsView()
                } label: {
                    channelsRow
                }
                .padding()
                
                Divider()

                NavigationLink {
                    LiveView()
                } label: {
                    liveRow
                }
                .padding()
                
                sectionSpacing
            }
            .listRowInsets(EdgeInsets())
            
            VStack(spacing: 0) {
                NavigationLink {
                    TopStoriesView()
                } label: {
                    topStoriesRow
                }
                .padding()
                
                Divider()
                
                NavigationLink {
                    SearchView()
                } label: {
                    searchRow
                }
                .padding()
                
                sectionSpacing
            }
            .listRowInsets(EdgeInsets())
            
            VStack(spacing: 0) {
                NavigationLink {
                    NearbyView()
                } label: {
                    nearbyRow
                }
            }
        }
        .listStyle(.plain)
        .listSectionSeparator(.hidden)
    }
}

extension DiscoverTabView {
    
    var sectionSpacing: some View {
        Rectangle()
            .fill(Color(UIColor.systemGroupedBackground))
            .frame(maxWidth: .infinity)
            .frame(height: 16)
    }
    
    var momentRow: some View {
        HStack(spacing: 0) {
            Image(systemName: "network")
                .foregroundColor(.mint)
                .padding(.trailing, 5)
            Text("Moments")
            Spacer()
        }
    }
    
    var channelsRow: some View {
        HStack {
            Image(systemName: "globe.americas")
                .foregroundColor(.pink)
                .padding(.trailing, 5)
            Text("Channels")
            Spacer()
        }
    }
    
    var liveRow: some View {
        HStack {
            Image(systemName: "livephoto")
                .foregroundColor(.red)
                .padding(.trailing, 5)
            Text("Live")
            Spacer()
        }
    }
    
    var topStoriesRow: some View {
        HStack {
            Image(systemName: "globe.americas")
                .foregroundColor(.yellow)
                .padding(.trailing, 5)
            Text("Top Stories")
            Spacer()
        }
    }
    
    var searchRow: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.red)
                .padding(.trailing, 5)
            Text("Search")
            Spacer()
        }
    }
    
    var nearbyRow: some View {
        HStack {
            Image(systemName: "antenna.radiowaves.left.and.right")
                .foregroundColor(.blue)
                .padding(.trailing, 5)
            Text("Nearby")
            Spacer()
        }
    }
}

struct DiscoverTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DiscoverTabView()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
