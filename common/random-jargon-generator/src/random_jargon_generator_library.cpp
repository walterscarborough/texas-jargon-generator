#include "random_jargon_generator_library.h"

#include <vector>

std::string generate_phrase() {
    std::vector<std::string> phrases;

    phrases.push_back("gosh");
    phrases.push_back("darn");
    phrases.push_back("what in 'tarnation");
    phrases.push_back("fixin' to");
    phrases.push_back("dang");
    phrases.push_back("y'all");
    phrases.push_back("might could");
    phrases.push_back("all hat, no cattle");
    phrases.push_back("all y'll");
    phrases.push_back("meaner than a two-dollar rattlesnake");
    phrases.push_back("howdy");

    int randomNumber = arc4random_uniform((int)phrases.size());

    return phrases.at(randomNumber);
}
