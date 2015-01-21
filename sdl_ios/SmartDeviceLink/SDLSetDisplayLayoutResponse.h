//  SDLSetDisplayLayoutResponse.h
//
//  Copyright (c) 2014 Ford Motor Company. All rights reserved.

#import <Foundation/Foundation.h>
#import <SmartDeviceLink/SDLRPCResponse.h>

#import <SmartDeviceLink/SDLDisplayCapabilities.h>
#import <SmartDeviceLink/SDLPresetBankCapabilities.h>

/**
 * Set Display Layout Response is sent, when SetDisplayLayout has been called
 *
 * Since AppLink 2.0
 */
@interface SDLSetDisplayLayoutResponse : SDLRPCResponse {}

/**
 * @abstract Constructs a new SDLSetDisplayLayoutResponse object
 */
-(id) init;
-(id) initWithDictionary:(NSMutableDictionary*) dict;

@property(strong) SDLDisplayCapabilities* displayCapabilities;
@property(strong) NSMutableArray* buttonCapabilities;
@property(strong) NSMutableArray* softButtonCapabilities;
@property(strong) SDLPresetBankCapabilities* presetBankCapabilities;

@end
