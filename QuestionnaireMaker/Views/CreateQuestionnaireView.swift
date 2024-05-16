//
//  CreateQuestionnaireView.swift
//  QuestionnaireMaker
//
//  Created by csuftitan on 4/10/24.
//

import SwiftUI

struct CreateQuestionView: View {
    let order: Int
    @Binding var question: Question
    @State private var isAddingChoice = false
    @State private var isRemovingChoice = false

    var body: some View {
        Section("Question \(order)") {
            VStack {
                TextField("Enter question here", text: $question.text)
                    .textFieldStyle(.roundedBorder)
                HStack(alignment: .bottom) {
                    VStack {
                        ForEach(question.choices.indices, id: \.self) { i in
                            TextField("Enter choice here", text: $question.choices[i])
                                .textFieldStyle(.roundedBorder)
                        }
                    }
                    Button("+") {
                        question.choices.append("")
                        print("+ pressed")
                        print(question.choices.count)
                    }
                    if(question.choices.count > 1) {
                        Button("-") {
                            question.choices.removeLast()
                            print("- pressed")
                            print(question.choices.count)
                        }
                    }
                }
                .padding(.leading, 90)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

struct CreateQuestionnaireView: View {
    @State private var name=""
    @State private var questionnaire=Questionnaire(questions: [])
    @Environment(\.presentationMode) var presentationMode
    @State private var pressed = false
    
    var body: some View {
        Form{
            Section("Questionnaire name"){
                TextField("Enter name of questionnaire", text: $name)
            }
            ForEach(questionnaire.questions.indices,id: \.self) { i in
                CreateQuestionView(order:i+1, question: $questionnaire.questions[i])
            }
            Button("Add question") {
                print(questionnaire.questions.count)
                questionnaire.questions.append(Question(text: "", choices: [""]))
                print(questionnaire.questions.count)
            }
            Button("Finish") {
                setQuestionnnaire(name, questionnaire)
                presentationMode.wrappedValue.dismiss()
            }
            Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct CreateQuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        CreateQuestionnaireView()
    }
}
