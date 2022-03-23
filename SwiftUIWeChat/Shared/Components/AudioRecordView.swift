//
//  AudioRecordView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/23.
//

import SwiftUI

struct AudioRecordView: View {
    
    @EnvironmentObject var chatVM: ChatViewModel
    
    var body: some View {
        if chatVM.isRecording {
            content
        } else {
            EmptyView()
        }
    }
    
    var content: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            
            VStack {
                Spacer()
                recordingView
                Spacer()
                actionsView
                releaseView
            }
            .offset(y: 120)
        }
        .gesture(dragGesture)
    }
    
    var recordingView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.green)
                .frame(height: 75)
                .frame(width: width)
                .animation(.linear, value: chatVM.recordTime)
            
            EqualizerIndicatorView()
                .foregroundColor(.primary)
        }
    }
    
    var actionsView: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                cancelView
                Spacer()
                Spacer()
                Spacer()
                translateView
                Spacer()
            }
            Text("Release to send")
        }
    }
    
    var cancelView: some View {
        VStack {
            Text("Release to ancel")
                .font(.caption)
                .foregroundColor(chatVM.isDragLeading ? .white.opacity(0.7) : .black.opacity(0.7))
                .opacity(chatVM.isDragLeading ? 1 : 0)
            
            Button {
                onCancel()
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .padding()
                    .foregroundColor(
                        chatVM.isDragLeading ? .black.opacity(0.7) : .white.opacity(0.7)
                    )
                    .background(
                        chatVM.isDragLeading ? Color.white : Color.black.opacity(0.4)
                    )
                    .clipShape(Circle())
                    .scaleEffect(chatVM.isDragLeading ? 1.2 : 1)
            }
        }
    }
    
    var translateView: some View {
        VStack {
            Text("Convert")
                .font(.caption)
                .foregroundColor(chatVM.isDragTrailing ? .white.opacity(0.7) : .black.opacity(0.7))
                .opacity(chatVM.isDragTrailing ? 1 : 0)
            
            Button {
                
            } label: {
                Text("En")
                    .font(.title3)
                    .padding()
                    .foregroundColor(
                        chatVM.isDragTrailing ? .black.opacity(0.7) : .white.opacity(0.7)
                    )
                    .background(
                        chatVM.isDragTrailing ? Color.white : Color.black.opacity(0.4)
                    )
                    .clipShape(Circle())
                    .scaleEffect(chatVM.isDragTrailing ? 1.2 : 1)
            }
        }
    }
    
    var releaseView: some View {
        ZStack {
            Ellipse()
                .stroke(.white.opacity(0.5), lineWidth: 10)
                .frame(width: UIScreen.main.bounds.width + 40, height: 250)
                .background(
                    chatVM.isDragRelease ? Material.ultraThickMaterial : Material.thin
                )
                .clipShape(Ellipse())
            
            Image(systemName: "dot.radiowaves.forward")
                .font(.title)
                .offset(y: -40)
        }
    }
    
    var width: CGFloat {
        let totalWidth = UIScreen.main.bounds.width - 150
        let spead = totalWidth / 30
        return 150 + CGFloat(spead) * CGFloat(chatVM.recordTime)
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged{ value in
                chatVM.updateCurrentLocaltion(location: value.location)
            }
            .onEnded { _ in
                if chatVM.isDragLeading {
                    onCancel()
                } else if chatVM.isDragTrailing {
                    onTranslate()
                } else if chatVM.isDragRelease {
                    onSend()
                }
            }
    }
    
    func onCancel() {
        chatVM.deleteRecord()
    }
    
    func onSend() {
        chatVM.stopRecord()
    }
    
    func onTranslate() {
        
    }
}

struct AudioRecordView_Previews: PreviewProvider {
    static var previews: some View {
        AudioRecordView()
            .environmentObject(ChatViewModel())
    }
}
