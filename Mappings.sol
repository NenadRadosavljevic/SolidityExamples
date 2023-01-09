// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;
contract Map {

    // mapping can only be on storage due to dynamic len size.
    // mapping can't be part of function arguments and return value.
    
    mapping (uint256 => uint256)[] private array;

    function allocate(uint newMaps) public {
        for (uint256 i = 0; i < newMaps; i++)
            array.push();
    }
    function writeMap(uint map, uint key, uint value) public {
         array[map][key] = value;
    }
    function readMap(uint map, uint key) public view returns (uint) {
       return array[map][key];
    }
    function eraseMaps() public {
        // Calling delete array does not delete
        // any of the elements of the maps.
        delete array;

        delete tasks[1];

    }

    struct Task {
        uint id;
        string content;
    }

    mapping(uint => Task) public tasks;
}
