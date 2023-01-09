//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract DynamicSizeArray {
    uint256[] _array;

    function add(uint256 _value) external {
        _array.push(_value);
    }

    function get() external view returns(uint256[] memory) {
        return _array;
    }

    function getElement(uint256 _index) external view returns(uint256) {
        require(_index < _array.length, "Out of bounds");

        return _array[_index];
    }

    function size() external view returns(uint256) {
        return _array.length;
    }

    function remove(uint256 _index) external {
        require(_index < _array.length, "Out of bounds");

        delete _array[_index];
    }

    function removeAndShuffle(uint256 _index) external {
        require(_index < _array.length, "Out of bounds");

        for (uint256 i = _index; i < _array.length - 1; i++) {
            _array[i] = _array[i + 1];
        }
        _array.pop();
    }
}

contract FixedSizeArray {
    uint256[10] _array;

    uint256[] array = [1,2,3];

    function set(uint256 _index, uint256 _value) external {
        require(_index < _array.length, "Out of bounds");

        _array[_index] = _value;
    }

    function get() external view returns(uint256[10] memory) {
        uint[10] memory _tmpArray = _array;
        return _tmpArray;
    }
}

contract CreateFixedSizeArray {
    uint256[] _array;

    constructor(uint256[] memory array) {
        _array = array;
    }

    function slice(uint256 start, uint256 end) external view returns(uint256[] memory) {
        uint256[] memory _tmpArray = new uint256[](end - start);

        for(uint256 i = start; i < end; i++) {
            _tmpArray[i - start] = _array[i];
        }

        return _tmpArray;
    }
}


