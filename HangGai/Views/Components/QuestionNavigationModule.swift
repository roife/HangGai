//
//  QuestionNavigationModule.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import SwiftUI

struct QuestionNavigationModule: View {
    @ObservedObject var questionManager: QuestionManager
    @State private var showChapterPopover: Bool = false
    @State private var jumpToQuestionID: String = ""
    
    private var nowQuestionIndex: String {
        return "\(questionManager.questionIndex)" + "/" + "\(questionManager.questionAmount())"
    }
    
    init(questionManager: QuestionManager) {
        self.questionManager = questionManager
    }
    
    var body: some View {
        VStack{
            HStack {
                Button(action: {
                    questionManager.decrementQuestionIndex()
                }, label: {
                    Image(systemName: "chevron.compact.left").resizable()
                        .scaledToFit()
                        .frame(maxHeight:16)
                }).foregroundColor(.black)
                Spacer()
                Button(action: {
                    withAnimation {
                        self.showChapterPopover.toggle()
                    }
                }, label: {
                    Text("\(questionManager.questionIndex)").font(.custom("FZSSJW--GB1-0", size: 15)).kerning(15.0).foregroundColor(.black)
                    BoldText(text: "/" + "\(questionManager.questionAmount())", width: 1, color: Color.black, size: 15.0, kerning: 15.0)
                })
                Spacer()
                Button(action: {
                    questionManager.incrementQuestionIndex()
                }, label: {
                    Image(systemName: "chevron.compact.right").resizable()
                        .scaledToFit()
                        .frame(maxHeight:16)
                }).foregroundColor(.black)
            }
            if showChapterPopover {
                    VStack(alignment: .leading) {
                        QuestionChapterStatus(questionChapterID: self.questionManager.questionChapter(), isIncrement: self.questionManager.getIsIncrement())
                        TextField("请输入想跳转的题号", text: $jumpToQuestionID)
                            .keyboardType(.numberPad)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 3.5))
                            .modifier(JumpQuestionButton(text: $jumpToQuestionID, questionManager: questionManager))
                    }.animation(.easeInOut)
                    .transition(.expandVertically)
                    .padding(.top)
            }
        }
    }
}
