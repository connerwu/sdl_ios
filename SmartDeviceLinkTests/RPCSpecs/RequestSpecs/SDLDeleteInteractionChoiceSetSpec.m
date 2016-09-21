//
//  SDLDeleteInteractionChoiceSetSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLDeleteInteractionChoiceSet.h"
#import "SDLNames.h"

QuickSpecBegin(SDLDeleteInteractionChoiceSetSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLDeleteInteractionChoiceSet* testRequest = [[SDLDeleteInteractionChoiceSet alloc] init];
        
		testRequest.interactionChoiceSetID = @20314;

		expect(testRequest.interactionChoiceSetID).to(equal(@20314));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary* dict = [@{SDLNameRequest:
                                           @{SDLNameParameters:
                                                 @{SDLNameInteractionChoiceSetId:@20314},
                                             SDLNameOperationName:SDLNameDeleteInteractionChoiceSet}} mutableCopy];
        SDLDeleteInteractionChoiceSet* testRequest = [[SDLDeleteInteractionChoiceSet alloc] initWithDictionary:dict];
        
        expect(testRequest.interactionChoiceSetID).to(equal(@20314));
    });

    it(@"Should return nil if not set", ^ {
        SDLDeleteInteractionChoiceSet* testRequest = [[SDLDeleteInteractionChoiceSet alloc] init];
        
		expect(testRequest.interactionChoiceSetID).to(beNil());
	});
});

QuickSpecEnd
