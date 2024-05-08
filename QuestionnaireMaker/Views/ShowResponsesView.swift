//
//  ShowResponsesView.swift
//  QuestionnaireMaker
//
//  Created by csuftitan on 4/14/24.
//

import SwiftUI
import Charts

struct FindQuestionnaireResponseView: View {
    @State var x=""
    @State var q:Questionnaire?=nil
    @State var r:[Response]?=nil
    var body: some View {
        Form{
            if
                let q=q,
                let r=r
            {
                ShowResponsesView(questionnaire: q, responses: r)
            } else {
                TextField("Enter questionnaire name", text: $x)
                Button("Find responses overview") {
                    Task{
                        self.q = await getQuestionnaire(x)
                        self.r = await getResponses(x)
                    }
                }
            }
        }
    }
}

struct ShowResponsesView: View {
    var questionnaire:Questionnaire
    var responses:[Response]
    var body: some View {
        VStack{
            ForEach(Array(questionnaire.questions.enumerated()),id: \.offset) { i,question in
                Text(question.text)
                Chart {
                    ForEach(responses,id: \.answers) { response in
//                        Text(response.answers[i])
                        BarMark(x: .value(response.answers[i], response.answers[i]), y: .value("count", 1))
                    }
                }
            }
        }
    }
}

struct ShowResponsesView_Previews: PreviewProvider {
    static var previews: some View {
        FindQuestionnaireResponseView()
    }
}
