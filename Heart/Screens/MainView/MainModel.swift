//
//  MainModel.swift
//  Heart
//
//  Created by Александр Александрович on 04.08.2022.
//

import Foundation

enum MainModel {
    enum Start {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {
            let sections: [Section]
        }
    }
    
    enum Interact {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum Update {
        struct Request {
            let duration: Double
        }
        
        struct Response {
            let pulse: String
        }
        
        struct ViewModel {
            let sections: [Section]
        }
    }
    enum Result {
        struct Request { }
        
        struct Response {
            let pulse: [String]?
        }
        struct ViewModel {
            let sections: [Section]
        }
    }
}

extension MainModel {
    enum SectionType {
        case horizontalDescription
        case bigHeart
        case yourPulse
        case sleepTime
        case stepsGoal
        
        var headerTitle: String? {
            switch self {
            case .horizontalDescription,
                    .bigHeart:
                return nil
            case .yourPulse:
                return Text.pulse.uppercased()
            case .sleepTime:
                return Text.sleep.uppercased()
            case .stepsGoal:
                return Text.steps.uppercased()
            }
        }
    }
    
    enum ItemType {
        case horizontalDescriptionItem(HorizontalDescriptionCellViewModel)
        case bigHeart(BigHeartCellViewModel)
        case yourPulse(YourPulseCellViewModel)
        case sleepTime(SleepTimeCellViewModel)
        case stepsGoal(StepsGoalCellViewModel)
    }
    
    struct Section {
        let type: SectionType
        let items: [ItemType]
        let headerTitle: String?
        
        init(type: SectionType, items: [ItemType]) {
            self.type = type
            self.items = items
            self.headerTitle = type.headerTitle
        }
    }
}
