#include <iostream>
using namespace std;

/* #include <thread> */
/* #include <chrono> */

int main() {

  int low, high, i;
  bool is_prime = true;

  cout << "Enter two numbers (intervals): ";
  cin >> low >> high;

  cout << "\nPrime numbers between " << low << " and " << high
       << " are: " << endl;

  while (low < high) {
    is_prime = true;

    if (low == 0 || low == 1) {
      is_prime = false;
    }

    for (i = 2; i <= low / 2; ++i) {
      if (low % i == 0) {
        is_prime = false;
        break;
      }
    }
    if (is_prime)
      cout << low << ", ";
    ++low;
  }

  char exit_character;

  cout << "\nPress 'q' to quit out." << endl;
  cin >> exit_character;

  if (exit_character == 'q') {
    exit(0);
  } else {
    cout << "Starting main again because you hit the wrong key..." << endl;
    main();
  }

  /**/
  /**/
  /**/
  /**/

  return EXIT_SUCCESS;
}
