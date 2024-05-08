//
//  CreateQuestionnaireView.swift
//  QuestionnaireMaker
//
//  Created by csuftitan on 4/10/24.
//

import SwiftUI

struct CreateQuestionView: View {
    let order:Int
    @Binding var question:Question
    var body: some View {
        Section("Question \(order)"){
            VStack{
                TextField("Enter question here", text: $question.text)
                    .textFieldStyle(.roundedBorder)
                HStack(alignment: .bottom) {
                    VStack{
                        ForEach(question.choices.indices, id: \.self) { i in
                            TextField("Enter choice here", text: $question.choices[i])
                                .textFieldStyle(.roundedBorder)
                        }
                    }
                    // TODO: fix click glitch (click white space also add choice)
                    Button("+") {
                        question.choices.append("")
                    }
                }
                .padding(.leading,90)
            }
        }
    }
}

struct CreateQuestionnaireView: View {
    @State private var name=""
    @State private var questionnaire=Questionnaire(questions: [])
    var body: some View {
        Form{
            Section("Questionnaire name"){
                TextField("Enter name of questionnaire", text: $name)
            }
            ForEach(questionnaire.questions.indices,id: \.self) { i in
                CreateQuestionView(order:i+1, question: $questionnaire.questions[i])
            }
            Button("Add question") {
                questionnaire.questions.append(Question(text: "", choices: [""]))
            }
            Button("Finish") {
                setQuestionnnaire(name, questionnaire)
            }
        }
    }
}

struct CreateQuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        CreateQuestionnaireView()
    }
}
