#import <Foundation/Foundation.h>
#import "RandomJargonGenerator.h"
#import "random_jargon_generator_library.h"

@interface RandomJargonGenerator()
@end

@implementation RandomJargonGenerator
+ (NSString *) generatePhrase {
    const char* phrase = generate_phrase();

    NSString* convertedPhrase = [[NSString alloc] initWithUTF8String: phrase];

    return convertedPhrase;
}
@end
