//SPDX-License-Identifier: Unlicense

pragma solidity >0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "hardhat/console.sol";

contract DataTypesTest{

    using Strings for uint;

    string[] public strArray;

    function test_push() public {
        strArray.push("first");
        strArray.push("second");
        strArray.push("third");
    }
    
    function test_pop() public {
        strArray.pop();  
    }

    function test_length() public view returns(uint){
        return strArray.length;       
    }    

    string public str = "some string";
    string public str_append = "Counting starts here: ";
    uint public counter;

    function test() public view returns(bool){
        string memory _str = "some string";
        return compareStrings(str, _str);
    }
    function compareStrings(string memory a, string memory b) public pure returns (bool) {
       // uint len = abi.encodePacked(a).length;
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
    function getStrLen() public view returns(uint)
    { 
        return bytes(str).length;
    }
    function concatStr1() public returns(string memory)
    { 
        // string memory tmp = " concatenated.";

        // string(abi.encode(counter++))  Ovo ne radi lepo.
        // string(abi.encodePacked(counter++))  Ni ovo.
        string memory tmp = string.concat(str_append, " ", Strings.toString(counter++));
        str_append = tmp;
        return tmp;
    }
    function concatStr2() public
    { 
        str_append = string(abi.encodePacked(str_append, " ", Strings.toString(counter++)));
    }

    event MemArrResult(uint256[] mem_arr);
    uint256[] public new_array;


    function testMemArrays() public returns(string[] memory){
        uint size = 3;
        
        uint256[] memory _array;

        _array = new uint[](size);
        _array[0] = 3;
       // _array = new uint[](0);
        _array = new uint[](2);
        _array[1] = 2;
        emit MemArrResult(_array);

        new_array = new uint256[](3);
        new_array.push(1);

        new_array = new uint256[](0);
        new_array.push(2);




        

        return strArray;

    }

    uint256[] array = [1,2,3];
    uint[3] balance2 = [1, 2, 3];

    function mem_storage_arrays() public {
        uint8[3] memory balance = [1, 2, 3];
     //   uint8[] memory balance1 = [1, 2, 3];
        // The type of the array is the type of the first element: the conversion must be explicit. But for the other elements, the conversion can be implicit. By default, the type of 1 is uint8.
        uint[3] memory data = [uint(1), 2, 3];

        uint size = 3;
        uint[] memory a = new uint[](size);
        bytes memory b = new bytes(size);     
    }

    function getMemCopyArray() external returns(uint256[] memory) {
        uint[] memory _tmpArray = new_array;
        emit MemArrResult(_tmpArray);
        return _tmpArray;
    }


    function testSig(bytes calldata _payload) public view {

        console.log("_payload je: ", _payload.length);

        bytes4 sig = bytes4(_payload[:4]);
        console.log("sig je: ", sig.length);
        bytes calldata bRight = bytes(_payload[3:]);
        console.log("sig  je: ", bRight.length);
    }

    uint data;
    uint[] dataArray;

    function f() public {
        uint x = data;
        delete x; // sets x to 0, does not affect data
        delete data; // sets data to 0, does not affect x
        uint[] storage y = dataArray;
        delete dataArray; // this sets dataArray.length to zero, but as uint[] is a complex object, also
        // y is affected which is an alias to the storage object
        // On the other hand: "delete y" is not valid, as assignments to local variables
        // referencing storage objects can only be made from existing storage objects.
      //  delete y;
        assert(y.length == 0);
    }

}
