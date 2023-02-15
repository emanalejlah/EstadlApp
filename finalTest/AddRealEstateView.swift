//
//  AddRealEstateView.swift
//  finalTest
//
//  Created by eman alejilah on 21/07/1444 AH.
//

import SwiftUI
import PhotosUI
import LoremSwiftum
import MapKit

class AddRealEstateViewModel: ObservableObject {
    @Published var realEstate = RealEstate()
    @Published var images: [UIImage] = []
    @Published var selection: [PhotosPickerItem] = []
    @Published var refreshMapViewId = UUID()
    
    @Published var coordinateRegion: MKCoordinateRegion = .init(center: .init(latitude: 0.0,longitude: 0.0),
                                                                span: .init(latitudeDelta: 0.0, longitudeDelta: 0.0))
//    @Published var coordinateRegion: MKCoordinateRegion = .init(center: .init(latitude: 0.0 , longitude: 0.0),
//                                                                span: .init(latitudeDelta: 0.0, longitudeDelta: 0.0))
    
}

struct AddRealEstateView: View {
    
    @StateObject var viewModel = AddRealEstateViewModel()
//    @State var realEstate = RealEstate()
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        NavigationView{
            ScrollView{
                Group{
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
                    VStack{
                        HStack{
                            Text("Location: ")
                                .foregroundColor(.yellow)
                            Spacer()
                        }
                        HStack{
                            Text("city: ")
                            Spacer()
                            Menu {
                                ForEach(City.allCases, id:\.self){ city in
                                    Button {
                                        viewModel.realEstate.city = city
                                    } label: {
                                        Text(city.title)
                                    }
                                    
                                }
                            } label: {
                                HStack{
                                    Text(viewModel.realEstate.city.title)
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.white)
                                }
                            }
                            
                        }.padding(.horizontal , 4)
                    }.padding(.horizontal, 4)
                    
                    Divider()
                    
                    VStack{
                        HStack{
                            Text("Type: ")
                                .foregroundColor(.yellow)
                            Spacer()
                        }
                        HStack{
                            Text("Catoragr: ")
                            Spacer()
                            Menu {
                                ForEach(RealEstateType.allCases, id:\.self){ realEstateType in
                                    Button {
                                        viewModel.realEstate.type = realEstateType
                                    } label: {
                                        Label(realEstateType.title, systemImage: realEstateType.imageName)
                                    }
                                    
                                }
                            } label: {
                                HStack{
                                    Text(viewModel.realEstate.type.title)
                                    Image(systemName: viewModel.realEstate.type.imageName)
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.white)
                                }
                            }
                            
                        }.padding(.horizontal , 4)
                    }.padding(.horizontal, 4)
                    
                    Divider()
                    
                    VStack{
                        HStack{
                            Text("sale: ")
                                .foregroundColor(.yellow)
                            Spacer()
                        }
                        HStack{
                            Text("offer: ")
                            Spacer()
                            Menu {
                                ForEach(SaleCategory.allCases, id:\.self){ saleCategory in
                                    Button {
                                        viewModel.realEstate.saleCategory = saleCategory
                                    } label: {
                                        Label(saleCategory.title, systemImage: saleCategory.imageName)
                                    }
                                    
                                }
                            } label: {
                                HStack{
                                    Text( viewModel.realEstate.saleCategory.title)
                                    Image(systemName:  viewModel.realEstate.saleCategory.imageName)
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.white)
                                }
                            }
                            
                        }.padding(.horizontal , 4)
                    }.padding(.horizontal, 4)
                    
                    Divider()
                    
                    VStack{
                        HStack{
                            Text("price: ")
                                .foregroundColor(.yellow)
                            Spacer()
                        }
                        HStack{
                            Text("amout: ")
                            Spacer()
                            TextField("0,0" , value: $viewModel.realEstate.price, format: .number)
                            
                        }.padding(.horizontal , 4)
                    }.padding(.horizontal, 4)
                }
                
                Group{
                    VStack{
                        HStack{
                            Text("photo: ")
                                .foregroundColor(.yellow)
                            Spacer()
                            
                        }
                        
                        LazyVGrid(columns: [GridItem.init(.adaptive(minimum: 140))]){
                            ForEach(viewModel.images, id:\.self){ image in
                                VStack{
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 180 , height:
                                                180)
                                        .clipShape(RoundedRectangle(cornerRadius: 12 ))
                                    Button {
                                        withAnimation(.spring()){
                                            if let deletedPhoto = viewModel.images.firstIndex(of: image){
                                                viewModel.images.remove(at: deletedPhoto)
                                            }
                                        }
                                    } label: {
                                        Label("Delet", systemImage: "trash")
                                            .foregroundColor(.red)
                                            .frame(width: 160 , height: 40)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.red, lineWidth: 0.4)
                                            )
                                    }
                                    
                                }.padding(.vertical, 8)
                            }
                            
                            PhotosPicker(selection: $viewModel.selection, maxSelectionCount: 6, matching: .images, preferredItemEncoding: .automatic){
                                VStack{
                                    VStack{
                                        Image(systemName: viewModel.images.count == 0 ? "icloud.and.arrow.up" : "plus")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 40 , height: 40)
                                        
                                        Label(viewModel.images.count == 0 ? "uploud" : "Add more" , systemImage: "photo.stack")
                                        
                                        
                                        
                                        //                            Label("uploud photos", systemImage: "photo.stack")
                                    }
                                    .frame(width: 180 , height: 180)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .strokeBorder(style: StrokeStyle(lineWidth: 2 , dash: [10]) )
                                    )
                                    RoundedRectangle(cornerRadius: 0)
                                        .fill(Color.clear)
                                        .frame(width: 160 , height: 40)
                                }
                                
                                
                            }.onChange(of: viewModel.selection) { _ in
                                for item in viewModel.selection{
                                    Task{
                                        if let data = try? await item.loadTransferable(type: Data.self){
                                            //                                    profileImage = UIImage(data: data)
                                            guard let uiImage = UIImage(data: data) else {return}
                                            viewModel.images.append(uiImage)
                                        }
                                    }
                                }
                            }
                            //
                            //
                            
                        }
                        
                        
                    }.padding(.horizontal, 4)
                    
                }
                
                Group{
                    VStack(alignment:.center){
                        HStack{
                            Text("Amenities")
                                .foregroundColor(.orange)
                                .font(.title)
                            Spacer()
                        }
                        
                        HStack(spacing: 20 ){
                            Button {
                                viewModel.realEstate.isSmart.toggle()
                            } label: {
                                VStack(spacing: 2 ){
                                    Image(systemName: "entry.lever.keypad.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30 , height: 30)
                                    Text("smart")
                                        .font(.system(size: 14, weight: .semibold))
                                        .padding(.top , 2)
                                    Image(systemName: viewModel.realEstate.isSmart ? "checkmark.square.fill" : "square")
                                        .foregroundColor(viewModel.realEstate.isSmart ? .green: .white)
                                        .padding(.top , 4)
                                }.foregroundColor(Color.white)
                            }
                            
                            Divider()
                            Button {
                                viewModel.realEstate.hasWiFi.toggle()
                            } label: {
                                VStack(spacing: 2 ){
                                    Image(systemName: "wifi")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30 , height: 30)
                                    Text("wifi")
                                        .font(.system(size: 14, weight: .semibold))
                                        .padding(.top , 2)
                                    Image(systemName: viewModel.realEstate.hasWiFi ? "checkmark.square.fill" : "square")
                                        .foregroundColor(viewModel.realEstate.hasWiFi ? .green: .white)
                                        .padding(.top , 4)
                                }.foregroundColor(Color.white)
                            }
                            //                    .ButtonStyle(.borderless)
                            
                            Divider()
                            Button {
                                viewModel.realEstate.hasPool.toggle()
                            } label: {
                                VStack(spacing: 2 ){
                                    Image(systemName: "figure.pool.swim")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30 , height: 30)
                                    Text("pool")
                                        .font(.system(size: 14, weight: .semibold))
                                        .padding(.top , 2)
                                    Image(systemName: viewModel.realEstate.hasPool ? "checkmark.square.fill" : "square")
                                        .foregroundColor(viewModel.realEstate.hasPool ?  .green: .white)
                                        .padding(.top , 4)
                                }.foregroundColor(Color.white)
                                    .buttonStyle(.borderless)
                            }
                            
                            Divider()
                            Button {
                                viewModel.realEstate.hasElevator.toggle()
                            } label: {
                                VStack(spacing: 2 ){
                                    Image(systemName: "figure.walk.arrival")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30 , height: 30)
                                    Text("wifi")
                                        .font(.system(size: 14, weight: .semibold))
                                        .padding(.top , 2)
                                    Image(systemName: viewModel.realEstate.hasElevator ? "checkmark.square.fill" : "square")
                                        .foregroundColor(viewModel.realEstate.hasElevator ? .green: .white)
                                        .padding(.top , 4)
                                }.foregroundColor(Color.white)
                            }.buttonStyle(.borderless)
                            
                        }
                        HStack{
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.2))
                                .frame(maxWidth:.infinity)
                                .frame(height: 1)
                            
                            
                        }
                    }.padding(.horizontal , 4)
                }
                Group{
                    Divider()
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
                                    
                                    Text("Beds \(viewModel.realEstate.beds)")
                                        .minimumScaleFactor(0.5)
                                    
                                    
                                }
                            }.frame(width: 90 , height: 48)
                                .background(Color.blue)
                                .cornerRadius(8)
                            VStack{
                                Image(systemName: "shower.fill")
                                    .font(.system(size: 18 , weight: .semibold))
                                HStack{
                                    Text("baths \(viewModel.realEstate.baths)")
                                        .minimumScaleFactor(0.5)
                                    
                                    
                                }
                            }.frame(width: 90 , height: 48)
                                .background(Color.orange)
                                .cornerRadius(8)
                            VStack{
                                Image(systemName: "sofa.fill")
                                    .font(.system(size: 18 , weight: .semibold))
                                HStack{
                                    Text("baths \(viewModel.realEstate.livingRooms)")
                                        .minimumScaleFactor(0.5)
                                    
                                    
                                }
                            }.frame(width: 90 , height: 48)
                                .background(Color.purple)
                                .cornerRadius(8)
                            
                            VStack{
                                Image(systemName: "ruler.fill")
                                    .font(.system(size: 18 , weight: .semibold))
                                HStack{
                                    Text("baths \(viewModel.realEstate.livingRooms)")
                                        .minimumScaleFactor(0.5)
                                    
                                    
                                }
                            }.frame(width: 90 , height: 48)
                                .background(Color.gray)
                                .cornerRadius(8)
                        }
                        
                        
                    }.padding(.horizontal , 4)
                }
                
           
                
                
                Group{
                    Divider()
                    VStack{
                        HStack{
                            Text("info :")
                                .foregroundColor(.orange)
                                .font(.title)
                            Spacer()
                        }
                        
                        TextField("type info", text:$viewModel.realEstate.description, axis:.vertical)
                            .padding()
                            .frame(minHeight: 100)
                        
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.white,lineWidth: 0.2)
                            )
                    }.padding(.horizontal , 4)
                    
                }
                
                
                
 
 
              
                    
                    mapUIkitView(realEstate: $viewModel.realEstate)
                        .frame(width:UIScreen.main.bounds.width - 50  , height:250 )
                        .cornerRadius(12)
                    //                    ععشان تطلع كل مدينه جديده
                        .id(viewModel.refreshMapViewId)
                        .overlay(
                            Image(systemName: "mappin.and.ellipse")
                                .padding(4)
                                .background(Color.red)
                                .clipShape(Circle())
                            ,alignment: .center
                            
                            
                        ).onChange(of: viewModel.realEstate.city) { _ in
                            self.viewModel.refreshMapViewId = UUID()
                        }
                    HStack{
                        Text("Lat:\(viewModel.realEstate.location.latitude)")
                        Text("Lat:\(viewModel.realEstate.location.longitude)")
                        
                        
                        
                        
                        
                    }
                
     
                    
                    NavigationLink {
                        
//                        كان فاضي وتم اضافه فيه الفايربيس كان button
                        SampleRealEstate(realEstate: $viewModel.realEstate,
                                         coordinateRegion: $viewModel.coordinateRegion,
                                         images: $viewModel.images)
                    } label: {
                        Text("show sample")
                            .foregroundColor(.white)
                            .frame(width: 380 , height: 48)
                            .background(Color.indigo)
                        
                            .padding()
                    }
                

                //
                //
            

            
        }
            
        .navigationTitle("add real estate")
        .navigationBarTitleDisplayMode(.large)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancal")
                }

            }
        }
        }
    }
}

struct AddRealEstateView_Previews: PreviewProvider {
    static var previews: some View {
        AddRealEstateView()
            .preferredColorScheme(.dark)
            .environmentObject(FirebaseUserManager())
    }
}





import MapKit

struct mapUIkitView: UIViewRepresentable{
    
    @Binding var realEstate : RealEstate
    let mapView = MKMapView()
    
    func makeUIView(context: Context) ->  MKMapView {
       
        mapView.delegate = context.coordinator
        
        
        mapView.setRegion(.init(center: realEstate.city.coordinate, span: realEstate.city.zoomLevel), animated: true)
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator : NSObject, MKMapViewDelegate , UIGestureRecognizerDelegate{
        var parent: mapUIkitView
        var gRecognizer = UILongPressGestureRecognizer()
        
        init(_ parent: mapUIkitView){
            self.parent = parent
            super.init()
//             if want to make usr taP TO HOLD TO GET LOCATION
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//            print("Dueubg: user coordinets\(mapView.centerCoordinate)")
            self.parent.realEstate.location = mapView.centerCoordinate
        }
    }
}
