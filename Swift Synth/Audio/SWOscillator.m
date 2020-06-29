//
//  SWOscillator.m
//  Swift Synth
//
//  Created by drago on 29/06/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import "SWOscillator.h"

float SWOscillatorAmplitude = 1.0;
float SWOscillatorFrequency = 440.0;

@implementation SWOscillator

+(SWSignalFunctionType) sine {
    return ^float(float time) {
        return SWOscillatorAmplitude * sin(2.0 * M_PI * SWOscillatorFrequency * time);
    };
}

+(SWSignalFunctionType) triangle {
    return ^float(float time) {
        return SWOscillatorAmplitude * sin(2.0 * M_PI * SWOscillatorFrequency * time);
    };
}

+(SWSignalFunctionType) sawtooth {
    return ^float(float time) {
        return SWOscillatorAmplitude * sin(2.0 * M_PI * SWOscillatorFrequency * time);
    };
}

+(SWSignalFunctionType) square {
    return ^float(float time) {
        return SWOscillatorAmplitude * sin(2.0 * M_PI * SWOscillatorFrequency * time);
    };
}

+(SWSignalFunctionType) whiteNoise {
    return ^float(float time) {
        return SWOscillatorAmplitude * sin(2.0 * M_PI * SWOscillatorFrequency * time);
    };
}

@end
