/* Colorscheme preview */
#include <iostream>
typedef unsigned int uint;

#ifndef hmm
#define hmm // TODO
#endif

class Base {};

namespace Yepp {
template <class T> class Preview : Base {
  private:
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
