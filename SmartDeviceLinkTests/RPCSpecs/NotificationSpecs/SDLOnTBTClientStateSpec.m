//
//  SDLOnTBTClientStateSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLOnTBTClientState.h"
#import "SDLNames.h"
#import "SDLTBTState.h"


QuickSpecBegin(SDLOnTBTClientStateSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLOnTBTClientState* testNotification = [[SDLOnTBTClientState alloc] init];
        
        testNotification.state = [SDLTBTState ETA_REQUEST];
        
        expect(testNotification.state).to(equal([SDLTBTState ETA_REQUEST]));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary* dict = [@{SDLNameNotification:
                                           @{SDLNameParameters:
                                                 @{SDLNameState:[SDLTBTState ETA_REQUEST]},
                                             SDLNameOperationName:SDLNameOnTbtClientState}} mutableCopy];
        SDLOnTBTClientState* testNotification = [[SDLOnTBTClientState alloc] initWithDictionary:dict];
        
        expect(testNotification.state).to(equal([SDLTBTState ETA_REQUEST]));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLOnTBTClientState* testNotification = [[SDLOnTBTClientState alloc] init];
        
        expect(testNotification.state).to(beNil());
    });
});

QuickSpecEnd
