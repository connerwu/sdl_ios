//  SDLImageField.m
//

#import "SDLImageField.h"

#import "SDLFileType.h"
#import "SDLImageFieldName.h"
#import "SDLImageResolution.h"



@implementation SDLImageField

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (instancetype)initWithDictionary:(NSMutableDictionary *)dict {
    if (self = [super initWithDictionary:dict]) {
    }
    return self;
}

- (void)setName:(SDLImageFieldName *)name {
    if (name != nil) {
        [store setObject:name forKey:SDLNameName];
    } else {
        [store removeObjectForKey:SDLNameName];
    }
}

- (SDLImageFieldName *)name {
    NSObject *obj = [store objectForKey:SDLNameName];
    if (obj == nil || [obj isKindOfClass:SDLImageFieldName.class]) {
        return (SDLImageFieldName *)obj;
    } else {
        return [SDLImageFieldName valueOf:(NSString *)obj];
    }
}

- (void)setImageTypeSupported:(NSMutableArray *)imageTypeSupported {
    if (imageTypeSupported != nil) {
        [store setObject:imageTypeSupported forKey:SDLNameImageTypeSupported];
    } else {
        [store removeObjectForKey:SDLNameImageTypeSupported];
    }
}

- (NSMutableArray *)imageTypeSupported {
    NSMutableArray *array = [store objectForKey:SDLNameImageTypeSupported];
    if ([array count] < 1 || [[array objectAtIndex:0] isKindOfClass:SDLFileType.class]) {
        return array;
    } else {
        NSMutableArray *newList = [NSMutableArray arrayWithCapacity:[array count]];
        for (NSString *enumString in array) {
            [newList addObject:[SDLFileType valueOf:enumString]];
        }
        return newList;
    }
}

- (void)setImageResolution:(SDLImageResolution *)imageResolution {
    if (imageResolution != nil) {
        [store setObject:imageResolution forKey:SDLNameImageResolution];
    } else {
        [store removeObjectForKey:SDLNameImageResolution];
    }
}

- (SDLImageResolution *)imageResolution {
    NSObject *obj = [store objectForKey:SDLNameImageResolution];
    if (obj == nil || [obj isKindOfClass:SDLImageResolution.class]) {
        return (SDLImageResolution *)obj;
    } else {
        return [[SDLImageResolution alloc] initWithDictionary:(NSMutableDictionary *)obj];
    }
}

@end
