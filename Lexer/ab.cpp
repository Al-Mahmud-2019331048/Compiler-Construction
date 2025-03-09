#include <iostream>
#include <vector>
using namespace std;

void printVector(vector<int> v) { // Passed by Value
    for (int num : v) {
        cout << num << " ";
    }
    cout << endl;
}

int main() {
    int arr[]={1,2,3}; //array
    vector<int> nums = {1, 2, 3, 4, 5};
    printVector(nums); // Copy is passed
    return 0;
}
