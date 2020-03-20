#include <jni.h>

#include "../../../../../../common/random-jargon-generator/src/random_jargon_generator_library.h"

extern "C" JNIEXPORT jstring JNICALL Java_com_example_texasjargongenerator_MainActivity_stringFromJNI(
    JNIEnv *env,
    jobject /* this */
) {
    const char* phrase = generate_phrase();
    return env->NewStringUTF(phrase);
}
