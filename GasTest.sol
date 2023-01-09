// SPDX-License-Identifier: no licence

pragma solidity >=0.8.11;

contract GasTest{
    
    struct StakeInfo {        
        uint256 depositTime;
        uint256 withdrawTime;        
        uint256 amount; 
        uint256 reward;       
    }

    mapping(uint => StakeInfo) public stakers;
    uint sCount = 0;

    StakeInfo[] stakersArr;

    constructor(){
      //  stakersArr.push();
    }

    function addStakers() external {
        StakeInfo memory sInfo = StakeInfo(34347822813,2134838246,328218029,73274039249);
        for(uint i=0; i<10; i++) {
            stakersArr.push(sInfo);
        }
    }

    function getStakersCount() public view returns(uint){
        return stakersArr.length;
    }

    function iterateOverArray() public view returns(uint) {
        uint amount = 0;
        for(uint i=0; i<stakersArr.length; i++) {
            amount += stakersArr[i].amount; 
        }

        return amount;
    }

    function iterateOverArray1() public view returns(uint) {
        uint amount = 0;
        StakeInfo[] memory _stakersInfo = stakersArr;
        for(uint i=0; i<_stakersInfo.length; i++) {
            amount += _stakersInfo[i].amount; 
        }

        return amount;
    }

    function addStakersToMap() external {
        StakeInfo memory sInfo = StakeInfo(34347822813,2134838246,328218029,73274039249);
        for(uint i=0; i<10; i++) {
            stakers[i] = sInfo;
            sCount ++;
        }
    }


    function getStakersCountMap() public view returns(uint){
        return sCount;
    }


    function iterateOverMap() public view returns(uint) {
        uint amount = 0;
        for(uint i=0; i<sCount; i++) {
            amount += stakers[i].amount; 
        }

        return amount;
    }

    function iterateSetMap() public returns(uint) {
        uint amount = 0;
        for(uint i=0; i<sCount; i++) {
            stakers[i].amount = 483705239;
        }

        return amount;
    }

    function compareOverMap() public view returns(uint) {
        uint amount = 0;
        for(uint i=0; i<sCount; i++) {
            if(stakers[i].amount == 2342323)
            {
                amount += 1;
            }
             
        }

        return amount;
    }

    function compare1OverMap() public view returns(uint) {
        uint amount = 0;
        uint mapLength = sCount;
        for(uint i=0; i<mapLength;) {
            if(stakers[i].amount == 2342323)
            {
                amount += 1;
            }
             unchecked{i++;}
        }

        return amount;
    }
}
