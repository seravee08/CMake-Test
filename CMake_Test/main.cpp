#include <iostream>

#include "simple_kernel.cuh"

using namespace std;

int main() {
	
	cu_control(3, 5000);
	
	system("pause");

	return 0;
}
