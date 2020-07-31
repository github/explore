#include<iostream>
using namespace std;
int main()
{
int x, double y, char z;
int *ip;
double *dp;
char *cp;

cout<<"Enter the variable value :"<<endl;
cin>>x >>y >>z;

ip = &x;
dp = &y;
cp = &z;

cout<<"Variable value is : " <<x <<endl;
cout<<"Variable value is : " <<y <<endl;
cout<<"Variable value is : " <<z <<endl;
cout<<"Address  value is : " <<ip <<endl;
cout<<"Address value is : " <<dp <<endl;
cout<<"Address value is : " <<cp <<endl;
cout<<"pointer pointing to value is : " <<*ip <<endl;
cout<<"pointer pointing to value is : " <<*dp <<endl;
cout<<"pointer pointing to value is : " <<*cp <<endl;

return 0;
}

