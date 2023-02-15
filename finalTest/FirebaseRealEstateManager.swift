//
//  FirebaseRealEstateManager.swift
//  finalTest
//
//  Created by eman alejilah on 23/07/1444 AH.
//
import SwiftUI
import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift
import FirebaseFirestore

class FirebaseRealEstateManager: NSObject, ObservableObject {
    
    
//    فقط اسم الكولكشن في الفايربيس بدون s
    @Published var realEstates: [RealEstate] = []
    
    let auth: Auth
    let firestore: Firestore
    let storage: Storage
    
    override init() {
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        self.storage = Storage.storage()
        super.init()
        fetchRealEstates()
    }
    
    func fetchRealEstates(){
        firestore.collection("realEstate").addSnapshotListener { querySnapshot, error in
            if let error = error  {
                print("Dubug: ERROR WHILE  FETCHING all realestate \(error)")
                return
            }
//            print("DEBUG: SNAPSHOT \(querySnapshot)")
            guard let realEstate = querySnapshot?.documents.compactMap({try? $0.data(as:RealEstate.self)}) else {return}
            self.realEstates = realEstate
//            print("DEBUG: realestate \(realEstate.map({$0.id}))")
        }
    }
    
    func addRealEstate(realEstate: RealEstate, images:[UIImage], completion: @escaping(Bool) -> ()){
//       try? firestore.collection("realEstate").document(realEstate.id).setData(from: realEstate)
        var realEstate = realEstate
        self.uploadImagesToStorage(images: images) { imageUrlStrings in
            realEstate.images = imageUrlStrings
            try? self.firestore.collection("realEstate").document(realEstate.id).setData(from: realEstate)
        }
    }
    
    func uploadImagesToStorage(images: [UIImage], onCompletion: @escaping( ([String]) -> () )) {
        print("DEBUG: ENTRING UPLOUDIMAGE TO STROGE FUNC")
        var imageUrlStrings: [String] = []

        guard let userId = auth.currentUser?.uid else { return }

        for image in images {
            print("DEBUG: ENTRING PHOTO LOOP")
            
            let imageId: String = UUID().uuidString
            guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
            print("DEBUG: CONVRET TO DATA")
            let refStorage = storage.reference(withPath: userId + "/" + imageId)

            refStorage.putData(imageData, metadata: nil) { storageMetaData, error in
                if let error = error{
                    print("DEBUG: Error while uploading Photo \(error)")
                    return
                }
                
            
                print("DEBUG: SUCCEFULY UPLODING PHOTO")
                refStorage.downloadURL { imageUrl, error in
                    if let error = error{
                        print("DEBUG: Error while downloading Photo \(error)")
                        return
                    }
                    print("DEBUG: SUCCEFULY DOWNLOWD PHOTO")
                    guard let imageUrlString = imageUrl?.absoluteString else { return }
                    imageUrlStrings.append(imageUrlString)
                    onCompletion(imageUrlStrings)
                }
            }
        }
    }
}
