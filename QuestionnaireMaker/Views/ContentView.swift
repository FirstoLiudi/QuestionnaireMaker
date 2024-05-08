//
//  ContentView.swift
//  QuestionnaireMaker
//
//  Created by csuftitan on 4/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Create Questionnaire") {
                    CreateQuestionnaireView()
                        .navigationTitle("Create Questionnaire")
                }
                NavigationLink("Fill Questionnaire") {
                    FindQuestionnaireView()
                        .navigationTitle("Fill Questionnaire")
                }
                NavigationLink("See responses overview") {
                    FindQuestionnaireResponseView()
                        .navigationTitle("Response overview")
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
