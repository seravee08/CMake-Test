#include <iostream>

#include "main.h"
#include "simple_kernel.cuh"

using namespace std;

int main() {
	
	cmake_t t1;
	t1.mem_a = 0;
	t1.mem_b = 0;

	cu_control(3, 5000);
	
	system("pause");

	return 0;
}
