#include "random_jargon_generator_library.h"

#include <vector>

auto generate_phrase() -> std::string {
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

  int randomNumber = arc4random_uniform((int)phrases.size());

  return phrases.at(randomNumber);
}
