#include "random_jargon_generator.h"

#include <vector>
#include <ctime>
#include <random>

std::string generate_phrase() {
    std::vector<std::string> phrases;

    phrases.push_back("gosh");
    phrases.push_back("darn");
    phrases.push_back("what in 'tarnation");
    phrases.push_back("fixin' to");

    std::mt19937 randomNumberGenerator(std::time(nullptr));
    std::uniform_int_distribution<int> randomNumberRange(0, phrases.size() - 1);

    int randomNumber = randomNumberRange(randomNumberGenerator);

    return phrases.at(randomNumber);
}
