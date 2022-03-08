//
//  MomentEditorView.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/4.
//

import SwiftUI

struct MomentEditorView: View {
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var focus: Bool
    
    @State private var text: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                TextEditor(text: $text)
                    .lineSpacing(5)
                    .foregroundColor(.primary)
                    .background(Color.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                    .focused($focus)
                
                Divider().padding(.horizontal)
                
                NavigationLink {
                    VStack {
                        Text("add location")
                    }
                } label: {
                    HStack {
                        Image(systemName: "location")
                            .padding(.trailing)
                        Text("Location")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.primary)
                    .padding()
                }
                Divider().padding(.horizontal)
                
                NavigationLink {
                    VStack {
                        Text("add location")
                    }
                } label: {
                    HStack {
                        Image(systemName: "infinity")
                            .padding(.trailing)
                        Text("Mention")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.primary)
                    .padding()
                }
                Divider().padding(.horizontal)
                
                NavigationLink {
                    VStack {
                        Text("add location")
                    }
                } label: {
                    HStack {
                        Image(systemName: "person")
                            .padding(.trailing)
                        Text("Visible To")
                        Spacer()
                        Text("All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.primary)
                    .padding()
                }

                Divider().padding(.horizontal)

            }
            .navigationTitle("Text")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                toolbars()
            }
            .onAppear {
                focus = true
            }
        }
    }
    
    @ToolbarContentBuilder
    func toolbars() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .foregroundColor(.primary)
            }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                // send post
                
                dismiss()
            } label: {
                Text("Post")
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(text.isEmpty ? Color.gray.opacity(0.4) : Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            .disabled(text.isEmpty)
        }
    }
}

struct MomentEditorView_Previews: PreviewProvider {
    static var previews: some View {
        MomentEditorView()
    }
}
