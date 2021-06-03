//
//  ContentView.swift
//  ImageClassifierApp
//
//  Created by 詹昆宬 on 2021/6/3.
//

import SwiftUI

struct ContentView: View {
    
    let photos = ["cat", "dog", "sheep"]
    @State private var currentIndex: Int = 0
    @State private var classificationLabel: String = "Click Classify"
    @State private var myModelLabel: String = "-"
    @State private var myModelLabelProp: Int = 0
    @State private var squeezeNetLabel: String = "-"
    @State private var squeezeNetLabelProp: Int = 0
    
    var body: some View {
        VStack {
            Image(photos[currentIndex])
                .resizable()
                .frame(width: 300, height: 300)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            
            HStack {
                Button("Previous") {
                    if self.currentIndex > 0 {
                        self.currentIndex = self.currentIndex - 1
                    }
                    else {
                        self.currentIndex = self.photos.count - 1
                    }
                    self.classificationLabel = "Click Classify"
                    clearResult()
                }.padding()
                .foregroundColor(Color.white)
                .background(Color.gray)
                .cornerRadius(10)
                .frame(width: 100)
                
                Button("Next") {
                    if self.currentIndex < self.photos.count - 1 {
                        self.currentIndex = self.currentIndex + 1
                    }
                    else {
                        self.currentIndex = 0
                    }
                    self.classificationLabel = "Click Classify"
                    clearResult()
                }.padding()
                .foregroundColor(Color.white)
                .background(Color.gray)
                .cornerRadius(10)
                .frame(width: 100)
            }.padding()
            
            Button("Classify") {
                myModelExecute()
                squeezeNetExecute()
            }.padding()
            .foregroundColor(Color.white)
            .background(Color.green)
            .cornerRadius(8)
            
            HStack {
                VStack {
                    Text("My Model:")
                        .font(.title2)
                        .padding()
                    Text("\(myModelLabel): \(myModelLabelProp)%")
                }
                
                VStack {
                    Text("SqueezeNet:")
                        .font(.title2)
                        .padding()
                    Text("\(squeezeNetLabel): \(squeezeNetLabelProp)%")
                }
            }
        }
    }
    
    func myModelExecute() {
        let model = AnimalImageClassifier()
        
        do {
            let prediction = try
                model.prediction(
                    input: AnimalImageClassifierInput.init(image: (UIImage(named: photos[currentIndex])?.resizeTo(size: CGSize(width: 299, height: 299))?.toBuffer())!))
            
            myModelLabel = prediction.classLabel
            myModelLabelProp = (Int) (prediction.classLabelProbs[prediction.classLabel]! * 100)
        } catch {
            // something went wrong
        }
    }
    
    func squeezeNetExecute() {
        let model = SqueezeNet()
        
        do {
            let prediction = try
                model.prediction(
                    input: SqueezeNetInput.init(image: (UIImage(named: photos[currentIndex])?.resizeTo(size: CGSize(width: 227, height: 227))?.toBuffer())!))
            
            squeezeNetLabel = prediction.classLabel
            squeezeNetLabelProp = (Int) (prediction.classLabelProbs[prediction.classLabel]! * 100)
        } catch {
            // something went wrong
        }
    }
    
    func clearResult() {
        myModelLabel = "-"
        myModelLabelProp = 0
        squeezeNetLabel = "-"
        squeezeNetLabelProp = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
