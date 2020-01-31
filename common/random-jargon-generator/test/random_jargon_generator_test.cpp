#include "random_jargon_generator.h"
#include "gtest/gtest.h"

TEST(random_jargon_generator, generate_phrase) {
    std::string phrase = generate_phrase();

    EXPECT_GT(phrase.size(), 0);
}
