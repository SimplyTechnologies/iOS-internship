
import SwiftUI
import EventKit

struct AddBirthdayScreen: View {
  
  @ObservedObject var viewModel: AddBirthdayViewModel
  @StateObject var homeScreenViewModel: HomeViewModel
  @State private var isSaveButtonEnabled = false
  @State private var addRelationshipEnabled = false
  @State private var addToCalendar = false
  @State private var eventStore = EKEventStore()
  @State private var authorizationStatus: EKAuthorizationStatus = EKEventStore.authorizationStatus(for: .event)
  
  var body: some View {
    ZStack {
      Color.backgroundColor
        .ignoresSafeArea()
      ScrollView {
        
        //        ZStack {
        //          if let image = viewModel.selectedImage {
        //            Image(uiImage: image)
        //              .resizable()
        //              .frame(
        //                width: 150,
        //                height: 150
        //              )
        //              .cornerRadius(75)
        //              .padding()
        //          } else {
        //            Image("circle")
        //          }
        //        }
        VStack {
          if let image = viewModel.addImage {
            ZStack {
              Image(
                uiImage: UIImage(
                  data: Data(
                    base64Encoded: (
                      viewModel.addImage?.base64!
                    )!
                  )!
                )!
              )
              .resizable()
              .frame(
                width: 150,
                height: 150
              )
              .cornerRadius(75)
              .padding()
              Button(action: {
                withAnimation {
                  viewModel.addImage = nil
                }
              }
              )
              {
                Image(systemName: "xmark.circle.fill")
                  .foregroundColor(.white)
                  .padding(8)
                  .background(Color.red)
                  .clipShape(Circle())
                  .padding(4)
              }
              .offset(x: 55, y: -55)
            }
          } else {
            Image("grayCircle")
              .resizable()
              .frame(
                width: 150,
                height: 150
              )
              .padding()
          }
        }
        .onTapGesture {
          viewModel.iSImagePickerPresented.toggle()
        }
        HStack {
          Text("Name")
            .foregroundColor(.primaryColor)
            .font(.title3)
            .frame(
              maxWidth: 250,
              alignment: .leading
            )
            .padding(
              .horizontal, 65
            )
          Spacer()
        }
        ZStack(alignment: .leading) {
          RoundedRectangle(cornerRadius: 14)
            .stroke(
              Color.gray,
              lineWidth: 0.1
            )
            .background(Color.white)
            .cornerRadius(14)
          TextField(
            "",
            text: $viewModel.birthdayDetails.name
          )
          .padding(10)
        }
        .padding(.horizontal, 60)
        HStack {
          Text("Relationship")
            .foregroundColor(.primaryColor)
            .font(.title3)
            .frame(
              maxWidth: 250,
              alignment: .leading
            )
            .padding(
              .horizontal, 65
            )
          Spacer()
        }
        LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 15) {
          ForEach(viewModel.relations, id: \.self) {
            createRelationshipCell(text: $0)
          }
        }
        .padding(.horizontal, 24)
        
        
        if addRelationshipEnabled {
          
          ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 14)
              .stroke(
                Color.gray,
                lineWidth: 0.1
              )
              .background(Color.white)
              .cornerRadius(14)
            TextField(
              "",
              text: $viewModel.birthdayDetails.relation
            )
            .padding(10)
          }
          .padding(.horizontal, 60)
          .padding(.vertical, 20)
        } else {
          Button {
            withAnimation {
              addRelationshipEnabled = true
              viewModel.birthdayDetails.relation = ""
            }
          } label: {
            Image("plusButton")
          }
          .padding(.vertical, 20)
        }
        VStack {
          HStack {
            Text("Message")
              .foregroundColor(.primaryColor)
              .font(.title3)
              .frame(
                maxWidth: 250,
                alignment: .leading
              )
              .padding(
                .horizontal, 65
              )
            Spacer()
          }
          TextEditor(text: $viewModel.birthdayDetails.message)
            .colorMultiply(.white)
            .cornerRadius(10)
            .frame(
              width: 270,
              height: 200
            )
        }
        DatePicker(
          selection: $viewModel.birthdayDetails.date,
          in: ...Date.now,
          displayedComponents: .date,
          label: {
            Text("Date of Birth:")
              .foregroundColor(.primaryColor)
              .font(.title3)
              .accentColor(.primaryColor)
          }
        )
        .foregroundColor(.primaryColor)
        .padding()
        .padding(
          .horizontal, 49
        )
        HStack {
          Button {
            addToCalendar.toggle()
          } label: {
            ZStack {
              Color.secondaryColor
              if addToCalendar {
                Image("CheckMark")
              }
            }
            .frame(width: 18, height: 18)
            .cornerRadius(2)
          }
          .padding(.leading)
          Text("Add To Calendar")
            .foregroundColor(.primaryColor)
            .font(Font.subheadline)
          Spacer()
        }
        Button("Save") {
          viewModel.addBirthday(
            by: Api.CreateBirthdayInput(
              name: viewModel.birthdayDetails.name,
              image: viewModel.addImage?.base64 ?? nil,
              relation: viewModel.birthdayDetails.relation,
              message: viewModel.birthdayDetails.message ?? nil,
              date: viewModel.birthdayDetails.date.stringFromDate()
            )
          )
          homeScreenViewModel.getBirthdays()
          if addToCalendar {
            if authorizationStatus == .authorized {
              viewModel.addRepeatingEventToCalendar()
            } else {
              requestCalendarAccess()
            }
          }
        }
        .disabled(
          viewModel.birthdayDetails.name.isEmpty ||
          viewModel.birthdayDetails.relation.isEmpty
        )
        .buttonStyle(PrimaryButtonStyle())
        .padding()
      }
    }
    .sheet(isPresented: $viewModel.iSImagePickerPresented) {
      ImagePicker(selectedImage: $viewModel.addImage)
    }
    .onTapGesture {
      UIApplication.shared.endEditing()
    }
    .toolbar {
      Image("LogoBirthApp")
    }
  }
  
  private func createRelationshipCell(text: String) -> some View {
    Button {
      viewModel.birthdayDetails.relation = text
    } label: {
      Text(text)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 13)
        .padding(.vertical, 10)
        .background(
          viewModel.birthdayDetails.relation == text ?
          Color.primaryColor :
            Color.white
        )
        .foregroundColor(
          viewModel.birthdayDetails.relation == text ?
          Color.white :
            Color.black
        )
        .cornerRadius(66)
        .font(.footnote)
    }
  }
  private func requestCalendarAccess() {
    eventStore.requestAccess(to: .event) { (granted, error) in
      if granted {
        authorizationStatus = .authorized
      } else {
//        requestCalendarAccess()
      }
    }
  }
  
//  private func addEventToCalendar() {
//    let event = EKEvent(eventStore: eventStore)
//    
//    event.title = "\(viewModel.birthdayDetails.name)'s Birthday"
//    event.startDate = Calendar.current.date(from: viewModel.birthdayDetails.date.get(.day, .month))
//    event.endDate = event.startDate.addingTimeInterval(86400)
//    event.notes = "Congratulate!!!"
//    event.addRecurrenceRule(
//      EKRecurrenceRule(recurrenceWith: .yearly,
//                       interval: 100,
//                       end: nil
//                      )
//    )
//  
//    event.calendar = eventStore.defaultCalendarForNewEvents
//   
//    print(event.startDate)
//    do {
//      try eventStore.save(event, span: .thisEvent)
//    } catch {
//      print(error)
//    }
//  }
}

//struct AddBirthdayScreen_Previews: PreviewProvider {
//
//  static var previews: some View {
//    AddBirthdayScreen(viewModel: AddBirthdayViewModel(birthdayDetails: BirthdayModel(id: 0, userId: 0, name: "", image: "", relation: "", message: "", date: Date(), upcomingBirthday: Date(), upcomingAge: 0, createdAt: Date(), updatedAt: Date()), birthdaysRepository: BirthdaysRepositoryImpl()))
//  }
//
//}
