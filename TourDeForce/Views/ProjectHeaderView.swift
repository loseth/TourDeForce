//
//  ProjectHeaderView.swift
//  TourDeForce
//
//  Created by Tor1 on 2020-10-30.
//

import SwiftUI

struct ProjectHeaderView: View {
    @ObservedObject var project: Project
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(project.projectTitle)
                ProgressView(value: project.completionAmount)
            }
            
            Spacer()
            
            NavigationLink(destination: EmptyView()) {
                Image(systemName: "square.and.pencil")
            }
        }
    }
}

struct ProjectHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHeaderView(project: Project.example)
    }
}
