//
//  GenderEntity.swift
//  Heart
//
//  Created by Александр Александрович on 28.07.2022.
//

import Foundation

enum GenderModel {
    enum Start {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {
            let sections : [Section]
        }
    }
    
    enum Route {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
}

extension GenderModel {
    enum SectionType {
        case gender
    }
    
    enum ItemType {
        case gender(GenderCellViewModel)
    }
    
    struct Section {
        let type : SectionType
        let items : [ItemType]
        
        init(type : SectionType, items : [ItemType]) {
            self.items = items
            self.type = type
        }
    }
}



