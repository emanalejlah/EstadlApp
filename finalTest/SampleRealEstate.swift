//
//  SampleRealEstate.swift
//  finalTest
//
//  Created by eman alejilah on 23/07/1444 AH.
//

import SwiftUI
import LoremSwiftum
import LoremSwiftum
import MapKit

struct SampleRealEstate: View {
    @EnvironmentObject var firebaseUserManager : FirebaseUserManager
    @Binding var realEstate : RealEstate
    @State var selectedMediaType: MediaType = .photos
    @Binding var coordinateRegion: MKCoordinateRegion
    @Binding var images: [UIImage]
//    @EnvironmentObject var firebaseRealEstateManager: FirebaseRealEstateManager
//    
    
    var body: some View {
        ScrollView{
            Picker(selection: $selectedMediaType) {
                ForEach(MediaType.allCases, id: \.self){ MediaType in Text(MediaType.title)
                    
                }
            } label: {
            }.labelsHidden()
                .pickerStyle(.segmented)
            if !images.isEmpty{
                TabView{
                    ForEach(images, id:\.self){ uiImage in
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 20 , height: 340)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .offset(y: -20)
                        
                    }
                }.tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .frame(height:400)
                    .overlay(
                        VStack{
                            HStack{
                                HStack{
                                    Image(systemName: "photo")
                                    Text("\(realEstate.images.count)")
                                }.padding(8)
                                    .background(Material.ultraThinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                Spacer()
                                Image(systemName: "bookmark")
                                    .padding(8)
                                        .background(Material.ultraThinMaterial)
                                        .clipShape(Circle())
                            }
                            Spacer()
                            HStack{
                                HStack{
                                    Image(systemName: realEstate.saleCategory.imageName)
                                    Text(realEstate.saleCategory.title)
                                }.padding(8)
                                    .background(Material.ultraThinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                Spacer()
                                Text("\(realEstate.price, specifier: "%0.0f")")
                                    .padding(8)
                                        .background(Material.ultraThinMaterial)
                                        .clipShape(Circle())
                            }
                        }.padding()
                            .padding(.bottom,40)
                    )
            }else {
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
            
            Group{
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
       
            Button {
                realEstate.ownirId = firebaseUserManager.user.id
                 
                firebaseUserManager.addRealEstate(realEstate: realEstate, images: images) { isSuccess in
                    
                }
                print("DEBUG: MY REAL ESTATE\(realEstate)") 
                print("DEBUG: MY REAL ESTATE\(images.count)")
                
            } label: {
                HStack{
                    Spacer()
                    Text("uploud realestate")
                    Spacer()
                }.padding(10)
                .foregroundColor(.white)
                .background(Color.blue)
                .background(Color.blue)
            }.buttonStyle(.borderless)


        }
       
        .navigationTitle("Titile")
    }
}

struct SampleRealEstate_Previews: PreviewProvider {
    static var previews: some View {
        SampleRealEstate(realEstate: .constant(realEstateSample)
                         ,coordinateRegion: .constant(.init(center: realEstateSample.location, span: realEstateSample.city.zoomLevel)),  images: .constant([UIImage(named: "Image 1")!, UIImage(named: "Image 2")!, UIImage(named: "Image 3")!, UIImage(named: "Image 4")!, UIImage(named: "Image 5")!, UIImage(named: "Image 6")!,]))
            
        
        .preferredColorScheme(.dark)
       .environmentObject(FirebaseUserManager())
//       .environmentObject(FirebaseRealEstateManager())
    }
}
