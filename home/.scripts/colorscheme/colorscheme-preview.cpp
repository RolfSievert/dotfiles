/* Colorscheme preview */ // 8
#include <iostream> // 4 2
typedef unsigned int uint; // 5 3 7

#ifndef hmm
#define hmm // TODO
#endif

class Base {};

namespace Yepp {
template <class T> class Preview : Base {
  private: // 1
    T hello;
  public:
    Preview() : Base() {}
    void watchThis();
};
} // namespace Yepp

int main() { // main
    const uint kompis = 5 * 10 << 2;
    Yepp::Preview<char> hej;
    hej.watchThis();
    if (kompis)
        return 0;
    else { return 1 ? false : true }
    std::cout << "Hej\t!" << 'y'
        << 'err' << std::endl;
};
