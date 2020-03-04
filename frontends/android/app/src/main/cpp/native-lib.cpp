#include <jni.h>
#include <string>

#include "../../../../../../common/random-jargon-generator/src/random_jargon_generator_library.h"

extern "C" JNIEXPORT jstring JNICALL
Java_com_example_texasjargongenerator_MainActivity_stringFromJNI(
        JNIEnv *env,
        jobject /* this */) {
    std::string phrase = generate_phrase();
    return env->NewStringUTF(phrase.c_str());
}
