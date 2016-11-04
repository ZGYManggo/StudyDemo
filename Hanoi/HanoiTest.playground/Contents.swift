//: Playground - noun: a place where people can play

import UIKit

func move(n:Int,A:String, B:String){
    print("\(n)号盘子\(A)->\(B)")
}
func Hanoi(n:Int,A:String,B:String,C:String) {
    if(n==1){
        move(n: 1, A: A, B: C)
    }
    else{
        Hanoi(n:n-1, A: A, B: C, C: B)
        move(n:n,A:A, B: C)
        Hanoi(n:n-1, A: B, B: A, C: C)
    }
}
Hanoi(n:3, A: "A", B: "B", C: "C")

