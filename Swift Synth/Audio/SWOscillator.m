//
//  SWOscillator.m
//  Swift Synth
//
//  Created by drago on 29/06/2020.
//  Copyright © 2020 Grant Emerson. All rights reserved.
//

#import "SWOscillator.h"

#define RANDOM(smallNumber, bigNumber) ((((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * (bigNumber - smallNumber)) + smallNumber)

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
        double period = 1.0 / (double)SWOscillatorFrequency;
        double currentTime = fmod((double)time, period);

        double value = currentTime / period;

        double result = 0.0;

        if (value < 0.25) {
            result = value * 4.0;
        }
        else if (value < 0.75) {
            result = 2.0 - (value * 4.0);
        } else {
            result = value * 4.0 - 4.0;
        }

        return SWOscillatorAmplitude * (float)result;
    };
}

+(SWSignalFunctionType) sawtooth {
    return ^float(float time) {
        double period = 1.0 / (double)SWOscillatorFrequency;
        double currentTime = fmod((double)time, period);

        return SWOscillatorAmplitude * (((float)currentTime / period) * 2.0 - 1.0);
    };
}

+(SWSignalFunctionType) square {
    return ^float(float time) {
        double period = 1.0 / (double)SWOscillatorFrequency;
        double currentTime = fmod((double)time, period);

        return ((currentTime / period) < 0.5) ? SWOscillatorAmplitude : -1.0 * SWOscillatorAmplitude;
    };
}

+(SWSignalFunctionType) whiteNoise {
    return ^float(float time) {
        return SWOscillatorAmplitude * RANDOM(-1.0, 1.0);
    };
}

@end
