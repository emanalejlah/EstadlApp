//
//  RealEstateDetailView.swift
//  finalTest
//
//  Created by eman alejilah on 20/07/1444 AH.
//

import SwiftUI
import LoremSwiftum
import MapKit
import SDWebImageSwiftUI

enum MediaType :String, CaseIterable{
    case photos
    case video
    
    var title: String {
        switch self{
        case .photos:
            return "photos"
        case .video:
            return "video"
        }
    }
}

struct RealEstateDetailView: View {
    @EnvironmentObject var firebaseUserManager : FirebaseUserManager
    @Binding var realEstate : RealEstate
    @State var selectedMediaType: MediaType = .photos
    @Binding var coordinateRegion: MKCoordinateRegion
   
    
    var body: some View {
        ScrollView{
            Picker(selection: $selectedMediaType) {
                ForEach(MediaType.allCases, id: \.self){ MediaType in Text(MediaType.title)
                    
                }
            } label: {
            }.labelsHidden()
                .pickerStyle(.segmented)
            if !realEstate.images.isEmpty {
                TabView{
                    ForEach(realEstate.images, id:\.self){ imageName in
                        WebImage(url: URL(string: firebaseUserManager.user.profileImageUrl))
                            .resizable()
                            .placeholder {
                            Rectangle().foregroundColor(.gray)
                        }
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFill()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 20 , height: 340)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .offset(y: -20)
                        
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(height:400)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100 , height: 100)
                    .opacity(0.4)
                    .padding(.vertical)
            }
          
            Divider()
            VStack(alignment:.leading){
                HStack{
                    Text("info")
                        .foregroundColor(.orange)
                        .font(.title)
                    Spacer()
                }
                Text(realEstate.description)
                    .font(.system(size: 16 , weight: .semibold))
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 2)
            }.padding(.horizontal , 4)
//              ??

            
            
            Divider()

            ApplianaceView(realEstate: $realEstate)
            

            Divider()
            
            AmenitiesView(realEstate: $realEstate)
          
            Map(coordinateRegion: $coordinateRegion, annotationItems: [realEstate]) { realEstate in
                MapAnnotation(coordinate: realEstate.location){
                    HStack{
                        Image(systemName: "info.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                            .font(.system(size: 14, weight:.bold, design: .rounded))
                        Text("1000000")
                            .font(.system(size: 18, weight: .semibold))
                            .minimumScaleFactor(0.8)
                            .foregroundColor(.white)
                        Image(systemName: "house")
                            .foregroundColor(.white.opacity(0.8))

                    }.padding(.bottom, 12)

                        .padding()
                        .background(
                            VStack(spacing: 0){
                                Spacer()
                              RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.green)
                                Triangle()
                                    .fill(Color.green)
                                    .frame(width: 20 , height: 20)
                                    .rotationEffect(.init(degrees: 180))


                            }
                           )
                }

            }.frame(width: UIScreen.main.bounds.width - 50, height: 240)
                .cornerRadius(12)
                .onAppear{
                    coordinateRegion.center = realEstate.location
                    coordinateRegion.span = realEstate.city.extraZoomLevel
               
                }
          
            persininfo(realEstate: $realEstate)
            
//            persininfo(realEstate: $realEstate)
            
            
//            HStack{
//                VStack{
//                    Image("people-1")
//                        .scaledToFill()
//                        .frame(width: 50, height: 50)
//                        .clipShape(Circle())
//                        .padding(2)
//                        .overlay{
//                            Circle()
//                                .stroke(Color.white, lineWidth: 0.4)
//                        }
//                    Text(Lorem.firstName)
//                }
//                VStack(alignment: .leading){
//                    HStack{
//                        Button {
//
//                        } label: {
//                            HStack{
//                                Image(systemName:"envelope" )
//                                Text("Email")
//                            }
//                            .foregroundColor(.white)
//                            .frame(width: 136 , height: 34)
//                            .background(Color.blue)
//
//                        }
//                        Button {
//
//                        } label: {
//                            HStack{
//                                Image(systemName:"bubble.left" )
//                                Text("Whatsup")
//                            }
//                            .foregroundColor(.white)
//                            .frame(width: 136 , height: 34)
//                            .background(Color.indigo)
//
//                        }.buttonStyle(.borderless)
//
//                    }
//                    Button {
//
//                    } label: {
//                        HStack(spacing: 4){
//                            Image(systemName:"phone" )
//                            Text("9708679")
//                        }
//                        .foregroundColor(.white)
//                        .frame(width: 136 , height: 34)
//                        .background(Color.indigo)
//
//                    }.buttonStyle(.borderless)
//
//
//
//                }
//            }.padding(.horizontal ,4)

        }
       
        .navigationTitle("Titile")
    }
}


struct ApplianaceView: View {
    @Binding var realEstate: RealEstate
    var body: some View{
        VStack(alignment:.center){
            HStack{
                Text("Applince")
                    .foregroundColor(.orange)
                    .font(.title)
                Spacer()
            }
            HStack(){
                VStack{
                    Image(systemName: "bed.double.fill")
                        .font(.system(size: 18 , weight: .semibold))
                    HStack{
                        Text("Beds \(realEstate.beds)")
                            .minimumScaleFactor(0.5)
                        
                    
                    }
                }.frame(width: 90 , height: 48)
                    .background(Color.blue)
                    .cornerRadius(8)
                VStack{
                    Image(systemName: "shower.fill")
                        .font(.system(size: 18 , weight: .semibold))
                    HStack{
                        Text("baths \(realEstate.baths)")
                            .minimumScaleFactor(0.5)
                        
                    
                    }
                }.frame(width: 90 , height: 48)
                    .background(Color.orange)
                    .cornerRadius(8)
                VStack{
                    Image(systemName: "sofa.fill")
                        .font(.system(size: 18 , weight: .semibold))
                    HStack{
                        Text("baths \(realEstate.livingRooms)")
                            .minimumScaleFactor(0.5)
                        
                    
                    }
                }.frame(width: 90 , height: 48)
                    .background(Color.purple)
                    .cornerRadius(8)
                
                VStack{
                    Image(systemName: "ruler.fill")
                        .font(.system(size: 18 , weight: .semibold))
                    HStack{
                        Text("baths \(realEstate.livingRooms)")
                            .minimumScaleFactor(0.5)
                        
                    
                    }
                }.frame(width: 90 , height: 48)
                    .background(Color.gray)
                    .cornerRadius(8)
            }
            
      
        }.padding(.horizontal , 4)
    }
}


struct AmenitiesView: View {
   @Binding var realEstate: RealEstate
    var body: some View{
        VStack(alignment:.center){
            HStack{
                Text("Amenities")
                    .foregroundColor(.orange)
                    .font(.title)
                Spacer()
            }
            
            HStack(spacing: 20 ){
                VStack(spacing: 2 ){
                    Image(systemName: "entry.lever.keypad.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30 , height: 30)
                    Text("smart")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.top , 2)
                    Image(systemName: realEstate.isSmart ? "checkmark.square.fill" : "xmark.square.fill")
                        .foregroundColor(realEstate.isSmart ? .green: .red)
                        .padding(.top , 4)
                }
                Divider()
                VStack(spacing: 2 ){
                    Image(systemName: "wifi")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30 , height: 30)
                    Text("wifi")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.top , 2)
                    Image(systemName: realEstate.hasWiFi ? "checkmark.square.fill" : "xmark.square.fill")
                        .foregroundColor(realEstate.hasWiFi ? .green: .red)
                        .padding(.top , 4)
                }
                Divider()
                VStack(spacing: 2 ){
                    Image(systemName: "figure.pool.swim")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30 , height: 30)
                    Text("wifi")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.top , 2)
                    Image(systemName: realEstate.hasPool ? "checkmark.square.fill" : "xmark.square.fill")
                        .foregroundColor(realEstate.hasPool ? .green: .red)
                        .padding(.top , 4)
                }
                
                Divider()
                VStack(spacing: 2 ){
                    Image(systemName: "figure.walk.arrival")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30 , height: 30)
                    Text("wifi")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.top , 2)
                    Image(systemName: realEstate.hasElevator ? "checkmark.square.fill" : "xmark.square.fill")
                        .foregroundColor(realEstate.hasElevator ? .green: .red)
                        .padding(.top , 4)
                }
            }
            HStack{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(maxWidth:.infinity)
                    .frame(height: 1)
                
                
            }
        }.padding(.horizontal , 4)
    }
}

struct persininfo: View {
    @Binding var realEstate: RealEstate
    var body: some View{
        VStack(alignment: .leading, spacing:12 ){
            HStack{
                VStack{
                    Image("people-1")
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding(2)
                        .overlay{
                            Circle()
                                .stroke(Color.white, lineWidth: 0.4)
                        }
                    Text(Lorem.firstName)
                }
                VStack(alignment: .leading){
                    HStack{
                        Button {
                            
                        } label: {
                            HStack{
                                Image(systemName:"envelope" )
                                Text("Email")
                            }
                            .foregroundColor(.white)
                            .frame(width: 136 , height: 34)
                            .background(Color.blue)
                            
                        }
                        Button {
                            
                        } label: {
                            HStack{
                                Image(systemName:"bubble.left" )
                                Text("Whatsup")
                            }
                            .foregroundColor(.white)
                            .frame(width: 136 , height: 34)
                            .background(Color.indigo)
                            
                        }.buttonStyle(.borderless)
                        
                    }
                    Button {
                        
                    } label: {
                        HStack(spacing: 4){
                            Image(systemName:"phone" )
                            Text("9708679")
                        }
                        .foregroundColor(.white)
                        .frame(width: 136 , height: 34)
                        .background(Color.indigo)
                        
                    }.buttonStyle(.borderless)
                    
                    
                    
                }
            }.padding(.horizontal ,4)
            
        }
    }
}






struct RealEstateDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        we did here NavigationView
        NavigationView{
            RealEstateDetailView(realEstate : .constant(realEstateSample),coordinateRegion: .constant(.init(center: City.riyadh.coordinate, span: City.riyadh.extraZoomLevel)))
        }
            .preferredColorScheme(.dark)
            .environmentObject(FirebaseUserManager())
    }
}

let realEstateSample: RealEstate = .init(images: ["Image 1", "Image 2", "Image 3", "Image 4", "Image 5"],
                                            description : Lorem.paragraph, beds: Int.random(in: 1...4),
                                            livingRooms: Int.random (in: 1...4),
                                            space:Int.random (in: 1...4),
                                            ovens:Int.random (in: 1...4),
                                            fridges:Int.random (in: 1...4),
                                            microwaves:Int.random (in: 1...4),
                                            airConditions:Int.random (in: 1...4),
                                            isSmart:false , hasWiFi: true , hasPool: false,
                                            hasElevator:true, hasGym:false,
                                            age:Int.random (in: 1...4),
                                            location: City.riyadh.coordinate,
                                         saleCategory:.rent, city:.riyadh, type: .apartment,
                                            offer: .monthly, isAvailable: true ,price: Int.random (in: 1000...5000))
                                            
                                            
      


//
//let realEstateSample: RealEstate = .init(images: ["Image 1",
//"Image 2", "Image 3", "Image 4", "Image 5"],
//description: Lorem.paragraph, beds: Int.random(in: 1...4),
//29
//30
//31
//baths:
//Int.random(in: 1...4), livingRooms: Int.random(in: 1...4), space: Int.random(in: 1...4).
//ovens: Int.random(in: 1...4) fridges: Int. random(in: 1.. microwaves: Int. random(in: 1.
//.4)
//airConditions: Int.random(in: 1...4), isSmart: false, haswiFi: true, hasPool: false, hasElevator: true, hasGym: false, age: Int. random(in: 1...4), location: City.arrass.coordinate,
//saleCategory: rent, city: •arrass, type: apartment offer: «monthly, isAvailable: true)
