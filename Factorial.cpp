#include<iostream>
using namespace std;
int main ()
{
int num,fact;

cout<<"Enter the number whose factorial has to be calculated :"<<endl;
cin>>num;

while (num>1) {
fact = fact*num;
}
num--;

cout<<"Factorial value is :"<<endl;
return 0;
}

