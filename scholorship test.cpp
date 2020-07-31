#include<iostream>
using namespace std;
int main()
{
int cls,per;

cout<<"Enter the class in which u studied :"<<endl;
cin>>cls;
cout<<"Enter the percentage marks :"<<endl;
cin>>per;

(cls==10 ||cls==12) ? ((per>=90) ? cout<<"Granted" :cout<<"Not granted") : cout<<"Not eligible"<<endl;
return 0;
}
