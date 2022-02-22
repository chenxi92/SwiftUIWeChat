//
//  DiscoverTabView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/2/18.
//

import SwiftUI

struct DiscoverTabView: View {

    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink {
                        MomentsView()
                    } label: {
                        momentRow
                    }
                }
                
                Section {
                    NavigationLink {
                        ChannelsView()
                    } label: {
                        channelsRow
                    }

                    NavigationLink {
                        LiveView()
                    } label: {
                        liveRow
                    }
                }
                
                Section {
                    NavigationLink {
                        TopStoriesView()
                    } label: {
                        topStoriesRow
                    }
                    
                    NavigationLink {
                        SearchView()
                    } label: {
                        searchRow
                    }
                }
                
                Section {
                    NavigationLink {
                        NearbyView()
                    } label: {
                        nearbyRow
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle("发现")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension DiscoverTabView {
    var momentRow: some View {
        HStack(spacing: 0) {
            Image(systemName: "network")
                .foregroundColor(.mint)
                .padding(.trailing, 5)
            Text("朋友圈")
            Spacer()
        }
    }
    
    var channelsRow: some View {
        HStack {
            Image(systemName: "globe.americas")
                .foregroundColor(.pink)
                .padding(.trailing, 5)
            Text("视频号")
            Spacer()
        }
    }
    
    var liveRow: some View {
        HStack {
            Image(systemName: "livephoto")
                .foregroundColor(.red)
                .padding(.trailing, 5)
            Text("直播")
            Spacer()
        }
    }
    
    var topStoriesRow: some View {
        HStack {
            Image(systemName: "globe.americas")
                .foregroundColor(.yellow)
                .padding(.trailing, 5)
            Text("看一看")
            Spacer()
        }
    }
    
    var searchRow: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.red)
                .padding(.trailing, 5)
            Text("搜一搜")
            Spacer()
        }
    }
    
    var nearbyRow: some View {
        HStack {
            Image(systemName: "antenna.radiowaves.left.and.right")
                .foregroundColor(.blue)
                .padding(.trailing, 5)
            Text("附近")
            Spacer()
        }
    }
}

struct DiscoverTabView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverTabView()
    }
}
