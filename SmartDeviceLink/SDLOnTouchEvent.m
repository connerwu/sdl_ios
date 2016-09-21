//  SDLOnTouchEvent.m
//

#import "SDLOnTouchEvent.h"


#import "SDLTouchEvent.h"
#import "SDLTouchType.h"


@implementation SDLOnTouchEvent

- (instancetype)init {
    if (self = [super initWithName:SDLNameOnTouchEvent]) {
    }
    return self;
}

- (instancetype)initWithDictionary:(NSMutableDictionary *)dict {
    if (self = [super initWithDictionary:dict]) {
    }
    return self;
}

- (void)setType:(SDLTouchType *)type {
    if (type != nil) {
        [parameters setObject:type forKey:SDLNameType];
    } else {
        [parameters removeObjectForKey:SDLNameType];
    }
}

- (SDLTouchType *)type {
    NSObject *obj = [parameters objectForKey:SDLNameType];
    if (obj == nil || [obj isKindOfClass:SDLTouchType.class]) {
        return (SDLTouchType *)obj;
    } else {
        return [SDLTouchType valueOf:(NSString *)obj];
    }
}

- (void)setEvent:(NSMutableArray *)event {
    if (event != nil) {
        [parameters setObject:event forKey:SDLNameEvent];
    } else {
        [parameters removeObjectForKey:SDLNameEvent];
    }
}

- (NSMutableArray *)event {
    NSMutableArray *array = [parameters objectForKey:SDLNameEvent];
    if ([array count] < 1 || [[array objectAtIndex:0] isKindOfClass:SDLTouchEvent.class]) {
        return array;
    } else {
        NSMutableArray *newList = [NSMutableArray arrayWithCapacity:[array count]];
        for (NSDictionary *dict in array) {
            [newList addObject:[[SDLTouchEvent alloc] initWithDictionary:(NSMutableDictionary *)dict]];
        }
        return newList;
    }
}

@end
