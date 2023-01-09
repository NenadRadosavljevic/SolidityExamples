//SPDX-License-Identifier: Unlicense

pragma solidity >0.8.0;

import "hardhat/console.sol";

contract Todo {

    address owner;

    struct Task {
        uint id;
        uint date;
        string content;
        string author;
        bool done;
        uint dateComplete;
    }

    mapping(uint => Task) public tasks;
    uint public nextTaskId;

    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can modify!");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    event TaskCreated (
        Task indexed user_task
    );

    event TaskStatusToggled (
        uint id,
        bool done,
        uint date
    );

    function createTask(string calldata _content, string calldata _author) external {
        tasks[nextTaskId] = Task(nextTaskId, block.timestamp, _content, _author, false, 0);
        emit TaskCreated(tasks[nextTaskId]);
        nextTaskId++;
    }

    function getTask(uint _id) external view returns(Task memory task){
        require( _id < nextTaskId, "Task does not exists!");
        return tasks[_id];
    } 

    function getAllTasks() external view returns(Task[] memory) {        
        Task[] memory _tasks = new Task[](nextTaskId);
        for(uint i=0; i<nextTaskId; i++){
            _tasks[i]=tasks[i];
        }
        return _tasks;
    }

    function toggleDone(uint _id) external {
        require(tasks[_id].date != 0, "task does not exist");
        Task storage task = tasks[_id];
        task.done = !task.done;
        task.dateComplete = task.done ? block.timestamp : 0;

        emit TaskStatusToggled(_id, task.done, task.dateComplete);
    }

    function task_storage_test() external {
        for(uint i=0; i<nextTaskId; i++){
            delete tasks[i];
        }
        nextTaskId = 0;
      //  delete tasks;
    }

    event TestEvent (
        address indexed user,
        Task indexed user_task,
        uint id,
        uint date,
        bytes32 indexed content,
        string author,
        bool done,
        uint dateComplete
    );

    function testLogs() external {
        require(nextTaskId > 0, "No tasks yet!");
        Task memory lastTask = tasks[nextTaskId-1];

        // bytes indexed content,
        // bytes(lastTask.content)
/*
"4": {
				"_isIndexed": true,
				"hash": "0x3ac225168df54212a25c1c01fd35bebfea408fdac2e31ddd6f80a4bbf9a5f1cb"
			},

*/

        // bytes32(abi.encodePacked(lastTask.content))
        // bytes32(bytes(lastTask.content))
        // "4": "0x6162626262626262626262626262626262626262626262626262620000000000",
        emit TestEvent(msg.sender, lastTask, lastTask.id, lastTask.date, bytes32(abi.encodePacked(lastTask.content)), lastTask.author, lastTask.done, lastTask.dateComplete);
    }
}
