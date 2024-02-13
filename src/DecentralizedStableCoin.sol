// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

error DecentralizedStableCoin__AmountMustbeMoreThanZero(uint256 amount);
error DecentralizedStableCoin__BurnAmountExceedsBalance();
error DecentralizedStableCoin__NotZeroAddress();

contract DecentralizedStableCoin is Ownable, ERC20Burnable {
    constructor() ERC20("DecentralizedStableCoin", "DSC") Ownable(msg.sender) {}

    function burn(uint256 _amount) public override onlyOwner {
        if (_amount <= 0) {
            revert DecentralizedStableCoin__AmountMustbeMoreThanZero(_amount);
        }
        if (_amount > address(this).balance) {
            revert DecentralizedStableCoin__BurnAmountExceedsBalance();
        }
        super.burn(_amount);
    }

    function mint(uint256 _amount, address _to) external onlyOwner returns (bool) {
        if (_to == address(0)) {
            revert DecentralizedStableCoin__NotZeroAddress();
        } //sanitizing
        if (_amount <= 0) {
            revert DecentralizedStableCoin__AmountMustbeMoreThanZero(_amount);
        }
        _mint(_to, _amount);
        return true;
    }
}
