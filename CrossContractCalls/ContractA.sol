/*
 * Copyright 2022 ConsenSys Software Inc
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 */
pragma solidity >=0.8.11;

import "./ContractC.sol";
import "./ContractB.sol";
import "hardhat/console.sol";

/**
 * Implementation of greeting contract which has a voting capability.
 */
contract ContractA {
    ContractB immutable public conB;
    ContractC immutable public conC;

    uint256 public val;
    address public dummyAddress;
    uint256 public dummyUint;
   // uint8 public dummyUint;

    event CrossCall(address indexed _respFrom, uint256 indexed _respValue);

    constructor (address _conB, address _conC) {
        conB = ContractB(_conB);
        conC = ContractC(_conC);
        dummyAddress = _conC;
        dummyUint = 7;
    }

    function callStuff1(bool _fail) external {
        val = conB.stuff1(_fail);
        emit CrossCall(address(conB), val);
    }

    function callStuff2(bool _fail) external {
        bool success;
        bytes memory returnValueEncoded;
        bytes memory funcParams = abi.encodeWithSelector(conB.stuff1.selector, _fail);
        (success, returnValueEncoded) = address(conB).call(funcParams);       

        if (success) {
            val = abi.decode(returnValueEncoded, (uint256));
            console.log("ContractC call - success response value: ", val);
        }
        else {
            // Assume revert and not a panic
            assembly {
                // Remove the function selector / sighash.
                returnValueEncoded := add(returnValueEncoded, 0x04)
            }
            string memory revertReason = abi.decode(returnValueEncoded, (string));
          //  uint256 revertReason = abi.decode(returnValueEncoded, (uint256)); // Panic
            console.log("ContractB call - error response value: ", revertReason);
          //  revert(string(abi.encode(revertReason))); // Panic
            revert(revertReason);
        }
    }

    error MyPanic(uint256 _error);
    error UnknownError(bytes _error);

    function callStuff3(bool _fail) external {
        try conB.stuff1(_fail) returns (uint256 v) {
            val = v;
            return;
        } catch Error(string memory reason) {
            console.log("ContractB call - Error reason: ", reason);
            revert(reason);
        } catch Panic(uint256 errorCode) {
            console.log("ContractB call - Panic reason: ", errorCode);
            revert MyPanic(errorCode);
        } catch (bytes memory lowLevelData) {
            console.log("ContractB call - UnknownError reason: ", string(lowLevelData));
            revert UnknownError(lowLevelData);
        }        
    }


    error MyError(uint256 _errorCode, uint256 _balance);

    function throwMyError(bool _fail) external {
        if (_fail) {
            revert MyError(23, val);
        }
        val = 29;
    }

    function callStuff4(bool _fail) external {
        try conB.stuff1(_fail) returns (uint256 v) {
            val = v;
            return;
        } catch Panic(uint256 errorCode) {
            revert MyPanic(errorCode);
        } catch (bytes memory lowLevelData) {
            revert UnknownError(lowLevelData);
        }        
    }


    function callContractC(bool _fail) external {
        bool success;
        bytes memory returnValueEncoded;
        bytes memory funcParams = abi.encodeWithSelector(conC.stuff1.selector, _fail);
        (success, returnValueEncoded) = address(conC).delegatecall(funcParams);       

        if (success) {
            uint256 _tempVal = abi.decode(returnValueEncoded, (uint256));
            console.log("ContractC call - success response value: ", _tempVal);
        }
        else {
            // Assume revert and not a panic
            assembly {
                // Remove the function selector / sighash.
                returnValueEncoded := add(returnValueEncoded, 0x04)
            }
            string memory revertReason = abi.decode(returnValueEncoded, (string));
          //  uint256 revertReason = abi.decode(returnValueEncoded, (uint256)); // Panic
            console.log("ContractC call - error response value: ", revertReason);
          //  revert(string(abi.encode(revertReason))); // Panic
            revert(revertReason);
        }
    }    

}

