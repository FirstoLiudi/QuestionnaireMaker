//
//  NetworkManager.swift
//  QuestionnaireMaker
//
//  Created by csuftitan on 4/10/24.
//

import Foundation
import FirebaseFirestore

struct Question:Codable{
    var text:String
    var choices:[String]
}
struct Questionnaire:Codable{
    var questions:[Question]
}
struct Response:Codable{
    var answers:[String] // same order as the question
}

func getQuestionnaire(_ name:String) async -> Questionnaire? {
    let db=Firestore.firestore()
    do{
        let document = try await db.collection("questionnaires").document(name).getDocument()
        let questionnaire = try document.data(as: Questionnaire.self)
        
//        print("success f")
//        questionnaire.questions.forEach { question in
//            print(question)
//        }
        
        return questionnaire
    } catch {
        print("error f: \(error)")
        return nil
    }
}

func setQuestionnnaire(_ name:String,_ questionnaire:Questionnaire){
    let db=Firestore.firestore()
    do{
        // TODO: check if questionnaire name is taken
        try db.collection("questionnaires").document(name).setData(from: questionnaire)
        
//        print("success g")
    } catch {
        print("error g: \(error)")
    }
}

func getResponses(_ qName:String) async -> [Response]?{
    let db=Firestore.firestore()
    do{
        let docs = try await db.collection("questionnaires").document(qName).collection("responses").getDocuments()
        let responses = try docs.documents.map { document in
            return try document.data(as: Response.self)
        }
        
//        print("success f")
//        print(responses)
        
        return responses
    } catch {
        print("error f: \(error)")
        return nil
    }
}

func addResponse(_ qName:String,_ qResponse:Response){
    let db=Firestore.firestore()
    do{
        // TODO: don't use .addDocument, use setData with id=respondentName
        // TODO: avoid duplicate submission
        try db.collection("questionnaires").document(qName).collection("responses").addDocument(from: qResponse)
        
//        print("success h")
    } catch {
        print("error h: \(error)")
    }
}
