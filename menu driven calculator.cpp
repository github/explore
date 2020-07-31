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
     result=num1+num2;
     cout<<"Sum is : " <<result<<endl;
     break; 
   case 2 :
      result=num1-num2;
      cout<<"Difference is :"<<result<<endl;
      break;
   case 3 :
      result=num1*num2;
      cout<<"Product is :"<<result<<endl;
      break;
   case 4 :
       result=num1/num2;
       cout<<"Quotient is :"<<result<<endl;
       break;
       default:
    cout<<"Invalid Option"<<endl;
    }
    return0;
    }
   




