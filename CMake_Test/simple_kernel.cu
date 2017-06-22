#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <windows.h>
#include <conio.h>
#include <stdio.h>
#include <math.h>

#include "simple_kernel.cuh"
#include "main.h"

__global__ void add_kernel(int* to_be_added, int to_add, int boundary) 
{
	const int x_id = threadIdx.x + blockDim.x * blockIdx.x;
	if (x_id >= boundary) {
		return;
	}

	to_be_added[x_id] = to_be_added[x_id] + to_add;
}

void cu_control(int to_add, int boundary)
{
	thrust::host_vector<int> hv_1(5);

	cmake_t t1;
	t1.mem_a = 1;
	t1.mem_b = 2;

	int* to_be_added = new int[boundary];
	memset(to_be_added, 0, boundary * sizeof(int));

	int* device_to_be_added;
	cudaMalloc((void**)&device_to_be_added, boundary * sizeof(int));
	cudaMemcpy(device_to_be_added, to_be_added, boundary * sizeof(int), cudaMemcpyHostToDevice);

	int add_blkSettings = ceil(boundary * 1.0 / 256);
	add_kernel << <add_blkSettings, 256 >> > (device_to_be_added, to_add, boundary);

	cudaMemcpy(to_be_added, device_to_be_added, boundary * sizeof(int), cudaMemcpyDeviceToHost);
	for (int i = 0; i < boundary; i++)
		printf("%d\n", to_be_added[i]);
		
	delete[] to_be_added;
}