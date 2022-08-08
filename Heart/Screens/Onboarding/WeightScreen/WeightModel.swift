//
//  HeightModel.swift
//  Heart
//
//  Created by Александр Александрович on 02.08.2022.
//

import Foundation

enum WeightModel {
    enum Start {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum Appear {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum Disappear {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum Change {
        struct Request {
            let index: Int
        }
        
        struct Response {
            let index: Int
        }
        
        struct ViewModel {
            let index: Int
        }
    }
    
    enum Keyboard {
        struct Request {
            let height: Int?
        }
        
        struct Response {
            let height: Int?
        }
        
        struct ViewModel {
            let height: Int?
        }
    }
    
    enum Route {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
}
