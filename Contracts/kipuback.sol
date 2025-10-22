// SPDX-License-Identifier: MIT
// Long K - Woondey 

pragma solidity ^0.8.20;

contract KipuBank {
    uint256 public immutable max_withdraw;
    uint256 public immutable bank_limit;
    uint256 public total_in_bank;
    uint256 public deposits_made;
    uint256 public withdraws_made;
    mapping(address => uint256) public user_balances;

    error TooMuchForBank();
    error TooMuchToWithdraw();
    error NoFunds();
    error NoZeroAllowed();

    event DepositDone(address who, uint256 how_much);
    event WithdrawDone(address who, uint256 how_much);

    modifier noZero() {
        if (msg.value == 0) revert NoZeroAllowed();
        _;
    }

    constructor(uint256 _max_withdraw, uint256 _bank_limit) {
        max_withdraw = _max_withdraw;
        bank_limit = _bank_limit;
    }

    function putMoney() external payable noZero {
        // checks if bank can take more
        if (total_in_bank + msg.value > bank_limit) revert TooMuchForBank();
        
        user_balances[msg.sender] += msg.value;
        total_in_bank += msg.value;
        deposits_made++;
        
        emit DepositDone(msg.sender, msg.value);
    }

    function takeMoney(uint256 amount) external {
        // makes sure amount is valid
        if (amount == 0) revert NoZeroAllowed();
        if (amount > max_withdraw) revert TooMuchToWithdraw();
        if (amount > user_balances[msg.sender]) revert NoFunds();

        user_balances[msg.sender] -= amount;
        total_in_bank -= amount;
        withdraws_made++;

        emit WithdrawDone(msg.sender, amount);

        // send ETH
        (bool sent,) = msg.sender.call{value: amount}("");
        if (!sent) revert("Send failed");
    }

    function checkBalance(address who) external view returns (uint256) {
        return user_balances[who];
    }

    function _internalCheck() private view returns (bool) {
        // just a private function to check state
        return total_in_bank <= bank_limit;
    }
}