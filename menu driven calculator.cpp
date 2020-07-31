#include<iostream>
using namespace  std;
int main()
{
float num1,num2,result;
int choice;

cout<<"Enter the two numbers : "<<endl;
cin>>num1 >>num2;
cout<<"Press1 - add, Press2 - sub, Press3 - mul, Press4 - div"<<endl;
cin>>choice;

switch (choice) {
  case 1 :
     sum=num1+num2;
     cout<<"Sum is : " <<sum<<endl;
     break; 
   case 2 :
      sub=num1-num2;
      cout<<"Difference is :"<<sub<<endl;
      break;
   case 3 :
      mul=num1*num2;
      cout<<"Product is :"<<mul<<endl;
      break;
   case 4 :
       div=num1/num2;
       cout<<"Quotient is :"<<div<<endl;
       break;
       default:
    cout<<"Invalid Option"<<endl;
    }
    return0;
    }
   




