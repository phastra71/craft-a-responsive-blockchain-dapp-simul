pragma solidity ^0.8.0;

contract CraftABlockchain {
    // State variables
    uint public totalUsers;
    uint public totalAssets;
    mapping (address => uint) public userAssets;
    mapping (address => uint) public userExperience;

    // Events
    event NewUser(address indexed user);
    event AssetCreated(uint indexed assetId);
    event AssetTraded(uint indexed assetId, address indexed from, address indexed to);
    event ExperienceEarned(address indexed user, uint experience);

    //Modifiers
    modifier onlyUserExists(address user) {
        require(userAssets[user] > 0, "User does not exist");
        _;
    }

    // Functions
    function createUser() public {
        totalUsers++;
        userAssets[msg.sender] = 0;
        userExperience[msg.sender] = 0;
        emit NewUser(msg.sender);
    }

    function createAsset() public onlyUserExists(msg.sender) {
        totalAssets++;
        emit AssetCreated(totalAssets);
    }

    function tradeAsset(uint assetId, address to) public onlyUserExists(msg.sender) onlyUserExists(to) {
        require(userAssets[msg.sender] > 0, "You do not own this asset");
        userAssets[msg.sender]--;
        userAssets[to]++;
        emit AssetTraded(assetId, msg.sender, to);
    }

    function earnExperience() public onlyUserExists(msg.sender) {
        userExperience[msg.sender]++;
        emit ExperienceEarned(msg.sender, userExperience[msg.sender]);
    }

    function getUserAssets() public view onlyUserExists(msg.sender) returns (uint) {
        return userAssets[msg.sender];
    }

    function getUserExperience() public view onlyUserExists(msg.sender) returns (uint) {
        return userExperience[msg.sender];
    }
}