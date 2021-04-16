//
//  ProjectHeaderViewModel.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2021-04-16.
//
//  NOT USED
//  EXAMPLE OF BAD USE OF MVVM

import Foundation

extension ProjectHeaderView {
    class ViewModel: ObservableObject {
        private let project: Project

        var title: String {
            project.projectTitle
        }

        var completionAmount: Double {
            project.completionAmount
        }

        var color: String {
            project.projectColor
        }

        init(project: Project) {
            self.project = project
        }
    }
}
