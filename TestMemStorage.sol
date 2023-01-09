//SPDX-License-Identifier: Unlicense
pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";


contract StorageLocation {
    Person[] public persons;

    struct Person {
        string name;
        uint age;
        address personAddress;
    }

    constructor() payable {
       Person memory newperson = Person({
           name: "Jamie",
           age: 33,
           personAddress: msg.sender
       });

       Person memory personTwo = Person({
           name: "Bones Man",
           age: 33,
           personAddress: msg.sender
       });
       persons.push(newperson);
       persons.push(personTwo);

       personTwo = Person({
           name: "John Doe",
           age: 23,
           personAddress: msg.sender
       });

       persons.push(personTwo);
    }

    receive () external payable { console.log("Receive func is executed! ");}

    fallback () external payable { console.log("Fallback func is executed! "); }
    

    function loadPerson() public view returns ( Person[] memory ){
        return persons;
    }

    function changeDataone() public view {
        Person memory person = persons[0];
        person.age = 56;
    }

    function changeDataTwo() public {
        Person storage person = persons[0];
        person.age = 76;
    }

    function changeDataThree(uint _age) public returns (Person memory) {
        Person[] storage person = persons;
        person[0].age = _age ;
        return person[0];
    }

    function testFunc(uint _age) public returns (Person memory) {
        uint[1] memory arr = [uint(10)];
        uint[] memory a = new uint[](7);
      //  a.push();
      //  arr[0]=1;
   //     uint[] storage arrNew = new uint[](1);

        Person memory newPerson = changeDataThree(_age);
        newPerson.age += 1;
        return newPerson;
    }   

    function testFuncView() public view returns (Person memory) {
        changeDataone();
        Person memory newPerson = persons[1];
        newPerson.age += 1;
        return newPerson;
    } 
    function receiveAsCallData(uint256[] calldata a) external {
        //you can not modify a
    }
    
    function receiveAsCallDataTestCost(uint256[] calldata a) external view {
        //you can not modify a
    }
    
}

