#include<iostream>

extern "C" {
	double avg(double,double);
}

int main() {
	std::cout<<avg(1,2)<<std::endl;
	return 0;
}
