#include<iostream>

extern "C" {
	double pandu(double,double);
}

int main() {
	std::cout<<pandu(1,2)<<std::endl;
	return 0;
}
