//
//  SDLOnLanguageChangeSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLLanguage.h"
#import "SDLOnLanguageChange.h"
#import "SDLNames.h"


QuickSpecBegin(SDLOnLanguageChangeSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLOnLanguageChange* testNotification = [[SDLOnLanguageChange alloc] init];
        
        testNotification.language = [SDLLanguage ES_ES];
        testNotification.hmiDisplayLanguage = [SDLLanguage DE_DE];
        
        expect(testNotification.language).to(equal([SDLLanguage ES_ES]));
        expect(testNotification.hmiDisplayLanguage).to(equal([SDLLanguage DE_DE]));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary* dict = [@{SDLNameNotification:
                                           @{SDLNameParameters:
                                                 @{SDLNameLanguage:[SDLLanguage ES_ES],
                                                   SDLNameHmiDisplayLanguage:[SDLLanguage DE_DE]},
                                             SDLNameOperationName:SDLNameOnLanguageChange}} mutableCopy];
        SDLOnLanguageChange* testNotification = [[SDLOnLanguageChange alloc] initWithDictionary:dict];
        
        expect(testNotification.language).to(equal([SDLLanguage ES_ES]));
        expect(testNotification.hmiDisplayLanguage).to(equal([SDLLanguage DE_DE]));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLOnLanguageChange* testNotification = [[SDLOnLanguageChange alloc] init];
        
        expect(testNotification.language).to(beNil());
        expect(testNotification.hmiDisplayLanguage).to(beNil());
    });
});

QuickSpecEnd
