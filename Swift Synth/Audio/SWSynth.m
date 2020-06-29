//
//  SWSynth.m
//  Swift Synth
//
//  Created by drago on 29/06/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import "SWSynth.h"

@implementation SWSynth

+(instancetype) shared {
    static SWSynth* shared = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // TODO: init with actual default signal
        shared = [[SWSynth alloc] initWithSignal:nil];
    });

    return shared;
}

-(instancetype) initWithSignal:(SWSignalFunctionType) signal {
    if (self = [super init]) {

    }

    return self;
}

-(void) setWaveformToSignal:(SWSignalFunctionType) signal {
    
}

@end
