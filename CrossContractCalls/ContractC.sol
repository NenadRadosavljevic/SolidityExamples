/*
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
pragma solidity >=0.8;

/**
 * Implementation of greeting contract which has a voting capability.
 */
contract ContractC {
    uint256 public bVal = 37;
    uint256 public val;

    function stuff1(bool _fail) external returns (uint256) {
        require(!_fail, "Failed");
       //  assert(!_fail);
       // bVal /= 0;
        uint256 newVal = bVal + 1;
        bVal = newVal;
        val = 1000;
        return newVal;
    }

}
