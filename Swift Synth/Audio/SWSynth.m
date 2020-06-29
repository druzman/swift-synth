//
//  SWSynth.m
//  Swift Synth
//
//  Created by drago on 29/06/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import "SWSynth.h"
#import "SWOscillator.h"

@implementation SWSynth

+(instancetype) shared {
    static SWSynth* shared = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[SWSynth alloc] init];
    });

    return shared;
}

-(instancetype) init {
    return [self initWithSignal:[SWOscillator sine]];
}

-(instancetype) initWithSignal:(SWSignalFunctionType) signal {
    if (self = [super init]) {

    }

    return self;
}

-(void) setWaveformToSignal:(SWSignalFunctionType) signal {
    
}

@end
