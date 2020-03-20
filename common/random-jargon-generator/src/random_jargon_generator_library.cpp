#include "random_jargon_generator_library.h"

#include <vector>
#include <random>

extern "C" auto generate_phrase() -> const char* {
  std::vector<std::string> phrases;

  phrases.emplace_back("gosh");
  phrases.emplace_back("darn");
  phrases.emplace_back("what in 'tarnation");
  phrases.emplace_back("fixin' to");
  phrases.emplace_back("dang");
  phrases.emplace_back("y'all");
  phrases.emplace_back("might could");
  phrases.emplace_back("all hat, no cattle");
  phrases.emplace_back("all y'll");
  phrases.emplace_back("meaner than a two-dollar rattlesnake");
  phrases.emplace_back("howdy");

  std::random_device dev;
  std::mt19937 rng(dev());
  std::uniform_int_distribution<std::mt19937::result_type> randomNumberGenerator(0, (int)phrases.size() - 1);
  int randomNumber = randomNumberGenerator(rng);

  std::string phrase = phrases.at(randomNumber);

  char* convertedPhrase = new char [phrase.length() + 1];
  std::strcpy(convertedPhrase, phrase.c_str());

  return convertedPhrase;
}
