//
//  FillQuestionnaireView.swift
//  QuestionnaireMaker
//
//  Created by csuftitan on 4/12/24.
//

import SwiftUI

struct FindQuestionnaireView: View {
    @State var x=""
    @State var q:Questionnaire?=nil
    var body: some View {
        Form{
            if let q=q{
                FillQuestionnaireView(name: x, q: q)
            } else {
                TextField("Enter questionnaire name", text: $x)
                Button("Find questionnaire") {
                    Task{
                        self.q = await getQuestionnaire(x)
                    }
                }
            }
        }
    }
}

struct FillQuestionnaireView: View {
    @State var r:[String]
    var name:String
    var q:Questionnaire
    
    init(name: String, q: Questionnaire) {
        self.name = name
        self.q = q
        self.r = q.questions.map({ question in
            return question.choices.first!
        })
    }
    
    var body: some View {
        // TODO: check if user filled all before submit
        ForEach(q.questions.indices,id: \.self) { i in
            Picker(q.questions[i].text, selection: $r[i]) {
                ForEach(q.questions[i].choices,id: \.self) { choice in
                    Text(choice).tag(choice)
                }
                .padding(.leading)
            }
        }
        Button("Submit") {
            addResponse(name, Response(answers: r))
        }
    }
}

struct FillQuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        FindQuestionnaireView()
    }
}
