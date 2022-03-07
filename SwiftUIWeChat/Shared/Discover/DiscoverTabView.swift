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
    @EnvironmentObject var profileVM: ProfileViewModel
    
    var body: some View {
        List {
            VStack(spacing: 0) {
                NavigationLink {
                    MomentsView()
                        .environmentObject(profileVM)
                        .environmentObject(MomentsViewModel())
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
        .listStyle(.grouped)
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
